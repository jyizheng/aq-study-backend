import {
  decode as base64Decode,
  encode as base64Encode,
} from 'https://deno.land/std@0.208.0/encoding/base64.ts';

// --- Configuration ---
const ALGO = 'AES-GCM';
const IV_LENGTH = 12; // 12 bytes (96 bits) is recommended for AES-GCM

// --- Helper Functions ---
const textEncoder = new TextEncoder();
const textDecoder = new TextDecoder();

/**
 * Derives a CryptoKey from the master environment key
 */
async function getKey(masterKey: string): Promise<CryptoKey> {
  const keyMaterial = await crypto.subtle.importKey(
    'raw',
    textEncoder.encode(masterKey),
    'PBKDF2',
    false,
    ['deriveKey']
  );
  
  return await crypto.subtle.deriveKey(
    { name: 'PBKDF2', salt: new Uint8Array(), iterations: 100000, hash: 'SHA-256' },
    keyMaterial,
    { name: ALGO, length: 256 },
    true,
    ['encrypt', 'decrypt']
  );
}

/**
 * Encrypts a plaintext string and returns a Base64 string (iv + ciphertext)
 */
export async function encrypt(plaintext: string, masterKey: string): Promise<string> {
  const key = await getKey(masterKey);
  const iv = crypto.getRandomValues(new Uint8Array(IV_LENGTH));
  const encryptedData = await crypto.subtle.encrypt(
    { name: ALGO, iv: iv },
    key,
    textEncoder.encode(plaintext)
  );

  // Combine IV + ciphertext and encode as Base64
  const fullMessage = new Uint8Array(iv.length + encryptedData.byteLength);
  fullMessage.set(iv);
  fullMessage.set(new Uint8Array(encryptedData), iv.length);
  
  return base64Encode(fullMessage);
}

/**
 * Decrypts a Base64 string (iv + ciphertext) and returns a plaintext string
 */
export async function decrypt(base64Ciphertext: string, masterKey: string): Promise<string> {
  const key = await getKey(masterKey);
  const fullMessage = base64Decode(base64Ciphertext);

  // Extract IV and ciphertext
  const iv = fullMessage.slice(0, IV_LENGTH);
  const ciphertext = fullMessage.slice(IV_LENGTH);

  const decryptedData = await crypto.subtle.decrypt(
    { name: ALGO, iv: iv },
    key,
    ciphertext
  );

  return textDecoder.decode(decryptedData);
}

