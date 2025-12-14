/**
 * 信封加密 (Envelope Encryption) 工具库
 * 
 * 架构说明:
 * - DEK (Data Encryption Key): 用于加密实际数据的随机密钥
 * - KEK (Key Encryption Key): 由用户密码派生，用于加密 DEK
 * 
 * 流程:
 * 1. 生成随机 DEK
 * 2. 用 DEK 加密数据
 * 3. 用 KEK (从用户密码派生) 加密 DEK
 * 4. 存储: 加密后的数据 + 加密后的 DEK + salt + iv
 */

import {
  decode as base64Decode,
  encode as base64Encode,
} from 'https://deno.land/std@0.208.0/encoding/base64.ts';

// --- Configuration ---
const ALGO = 'AES-GCM';
const IV_LENGTH = 12; // 12 bytes (96 bits) recommended for AES-GCM
const SALT_LENGTH = 16; // 16 bytes for PBKDF2 salt
const DEK_LENGTH = 32; // 256-bit DEK
const PBKDF2_ITERATIONS = 100000;

const textEncoder = new TextEncoder();
const textDecoder = new TextDecoder();

// --- DEK 相关函数 ---

/**
 * 生成随机 DEK (Data Encryption Key)
 */
export function generateDEK(): Uint8Array {
  return crypto.getRandomValues(new Uint8Array(DEK_LENGTH));
}

/**
 * 生成随机 Salt
 */
export function generateSalt(): Uint8Array {
  return crypto.getRandomValues(new Uint8Array(SALT_LENGTH));
}

/**
 * 从 DEK 字节数组创建 CryptoKey
 */
async function importDEK(dekBytes: Uint8Array): Promise<CryptoKey> {
  return await crypto.subtle.importKey(
    'raw',
    dekBytes,
    { name: ALGO, length: 256 },
    true,
    ['encrypt', 'decrypt']
  );
}

// --- KEK 相关函数 ---

/**
 * 从用户密码派生 KEK (Key Encryption Key)
 * 使用 PBKDF2 算法
 */
export async function deriveKEK(password: string, salt: Uint8Array): Promise<CryptoKey> {
  const keyMaterial = await crypto.subtle.importKey(
    'raw',
    textEncoder.encode(password),
    'PBKDF2',
    false,
    ['deriveKey']
  );
  
  return await crypto.subtle.deriveKey(
    {
      name: 'PBKDF2',
      salt: salt,
      iterations: PBKDF2_ITERATIONS,
      hash: 'SHA-256'
    },
    keyMaterial,
    { name: ALGO, length: 256 },
    true,
    ['encrypt', 'decrypt', 'wrapKey', 'unwrapKey']
  );
}

// --- 加密/解密函数 ---

/**
 * 用 DEK 加密数据
 * 返回: Base64(iv + ciphertext)
 */
export async function encryptWithDEK(plaintext: string, dekBytes: Uint8Array): Promise<string> {
  const key = await importDEK(dekBytes);
  const iv = crypto.getRandomValues(new Uint8Array(IV_LENGTH));
  
  const encryptedData = await crypto.subtle.encrypt(
    { name: ALGO, iv: iv },
    key,
    textEncoder.encode(plaintext)
  );

  // Combine IV + ciphertext
  const fullMessage = new Uint8Array(iv.length + encryptedData.byteLength);
  fullMessage.set(iv);
  fullMessage.set(new Uint8Array(encryptedData), iv.length);
  
  return base64Encode(fullMessage);
}

/**
 * 用 DEK 解密数据
 * 输入: Base64(iv + ciphertext)
 */
export async function decryptWithDEK(base64Ciphertext: string, dekBytes: Uint8Array): Promise<string> {
  const key = await importDEK(dekBytes);
  const fullMessage = base64Decode(base64Ciphertext);

  const iv = fullMessage.slice(0, IV_LENGTH);
  const ciphertext = fullMessage.slice(IV_LENGTH);

  const decryptedData = await crypto.subtle.decrypt(
    { name: ALGO, iv: iv },
    key,
    ciphertext
  );

  return textDecoder.decode(decryptedData);
}

/**
 * 用 KEK 加密 DEK
 * 返回: { encryptedDEK: Base64, iv: Base64 }
 */
export async function encryptDEK(dekBytes: Uint8Array, kek: CryptoKey): Promise<{ encryptedDEK: string; iv: string }> {
  const iv = crypto.getRandomValues(new Uint8Array(IV_LENGTH));
  
  const encryptedData = await crypto.subtle.encrypt(
    { name: ALGO, iv: iv },
    kek,
    dekBytes
  );

  return {
    encryptedDEK: base64Encode(new Uint8Array(encryptedData)),
    iv: base64Encode(iv)
  };
}

/**
 * 用 KEK 解密 DEK
 * 返回: DEK 字节数组
 */
export async function decryptDEK(encryptedDEK: string, iv: string, kek: CryptoKey): Promise<Uint8Array> {
  const decryptedData = await crypto.subtle.decrypt(
    { name: ALGO, iv: base64Decode(iv) },
    kek,
    base64Decode(encryptedDEK)
  );

  return new Uint8Array(decryptedData);
}

// --- 高级封装函数 ---

export interface EnvelopeEncryptResult {
  encryptedData: string;    // 加密后的数据 (Base64)
  encryptedDEK: string;     // 加密后的 DEK (Base64)
  dekIV: string;            // DEK 加密用的 IV (Base64)
  salt: string;             // KEK 派生用的 salt (Base64)
}

/**
 * 信封加密 - 完整流程
 * 
 * @param plaintext - 要加密的明文数据
 * @param password - 用户密码 (用于派生 KEK)
 * @returns 加密结果，包含所有需要存储的数据
 */
export async function envelopeEncrypt(plaintext: string, password: string): Promise<EnvelopeEncryptResult> {
  // 1. 生成随机 DEK 和 Salt
  const dek = generateDEK();
  const salt = generateSalt();
  
  // 2. 用 DEK 加密数据
  const encryptedData = await encryptWithDEK(plaintext, dek);
  
  // 3. 从密码派生 KEK
  const kek = await deriveKEK(password, salt);
  
  // 4. 用 KEK 加密 DEK
  const { encryptedDEK, iv: dekIV } = await encryptDEK(dek, kek);
  
  return {
    encryptedData,
    encryptedDEK,
    dekIV,
    salt: base64Encode(salt)
  };
}

/**
 * 信封解密 - 完整流程
 * 
 * @param encrypted - 加密结果对象
 * @param password - 用户密码
 * @returns 解密后的明文
 */
export async function envelopeDecrypt(encrypted: EnvelopeEncryptResult, password: string): Promise<string> {
  // 1. 从密码派生 KEK
  const salt = base64Decode(encrypted.salt);
  const kek = await deriveKEK(password, salt);
  
  // 2. 用 KEK 解密 DEK
  const dek = await decryptDEK(encrypted.encryptedDEK, encrypted.dekIV, kek);
  
  // 3. 用 DEK 解密数据
  return await decryptWithDEK(encrypted.encryptedData, dek);
}

// --- 用户 DEK 管理 (用于持久化存储) ---

export interface UserDEKInfo {
  encryptedDEK: string;  // 用 KEK 加密的 DEK
  dekIV: string;         // DEK 加密的 IV
  salt: string;          // KEK 派生的 salt
}

/**
 * 为新用户创建 DEK
 * 生成 DEK 并用密码派生的 KEK 加密
 */
export async function createUserDEK(password: string): Promise<{ dek: Uint8Array; info: UserDEKInfo }> {
  const dek = generateDEK();
  const salt = generateSalt();
  const kek = await deriveKEK(password, salt);
  const { encryptedDEK, iv: dekIV } = await encryptDEK(dek, kek);
  
  return {
    dek,
    info: {
      encryptedDEK,
      dekIV,
      salt: base64Encode(salt)
    }
  };
}

/**
 * 恢复用户 DEK
 * 用密码解密存储的加密 DEK
 */
export async function recoverUserDEK(info: UserDEKInfo, password: string): Promise<Uint8Array> {
  const salt = base64Decode(info.salt);
  const kek = await deriveKEK(password, salt);
  return await decryptDEK(info.encryptedDEK, info.dekIV, kek);
}

/**
 * 更换密码时重新加密 DEK
 * (DEK 本身不变，只是用新密码重新加密)
 */
export async function reencryptDEK(dek: Uint8Array, newPassword: string): Promise<UserDEKInfo> {
  const salt = generateSalt();
  const kek = await deriveKEK(newPassword, salt);
  const { encryptedDEK, iv: dekIV } = await encryptDEK(dek, kek);
  
  return {
    encryptedDEK,
    dekIV,
    salt: base64Encode(salt)
  };
}

// --- 辅助函数 ---

/**
 * 将 Uint8Array 转为 Base64
 */
export function bytesToBase64(bytes: Uint8Array): string {
  return base64Encode(bytes);
}

/**
 * 将 Base64 转为 Uint8Array
 */
export function base64ToBytes(base64: string): Uint8Array {
  return base64Decode(base64);
}
