import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

// Generate a random password
function generatePassword(length = 12): string {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789';
  let password = '';
  const array = new Uint8Array(length);
  crypto.getRandomValues(array);
  for (let i = 0; i < length; i++) {
    password += chars[array[i] % chars.length];
  }
  return password;
}

// Decode JWT to get user info
function decodeJwt(token: string): any {
  try {
    const parts = token.split('.');
    if (parts.length !== 3) return null;
    const payload = JSON.parse(atob(parts[1]));
    return payload;
  } catch {
    return null;
  }
}

// Send email via SMTP
async function sendEmail(to: string, subject: string, html: string): Promise<boolean> {
  const smtpHost = Deno.env.get("SMTP_HOST") || "smtp.163.com";
  const smtpPort = parseInt(Deno.env.get("SMTP_PORT") || "465");
  const smtpUser = Deno.env.get("SMTP_USER") || "";
  const smtpPass = Deno.env.get("SMTP_PASS") || "";

  if (!smtpUser || !smtpPass) {
    console.error("SMTP credentials not configured");
    return false;
  }

  console.log("SMTP config:", { host: smtpHost, port: smtpPort, user: smtpUser });

  try {
    const client = new SMTPClient({
      connection: {
        hostname: smtpHost,
        port: smtpPort,
        tls: true,
        auth: {
          username: smtpUser,
          password: smtpPass,
        },
      },
    });

    await client.send({
      from: smtpUser,
      to: to,
      subject: subject,
      content: "auto",
      html: html,
    });

    await client.close();
    console.log("Email sent successfully to:", to);
    return true;
  } catch (error) {
    console.error("SMTP send error:", error);
    return false;
  }
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Verify the calling user is authenticated
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("Missing authorization header");
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    // Extract token and decode it to get user ID
    const token = authHeader.replace('Bearer ', '');
    const payload = decodeJwt(token);
    
    if (!payload || !payload.sub) {
      throw new Error("Invalid token");
    }

    const callingUserId = payload.sub;
    console.log("Calling user ID from token:", callingUserId);

    // Create admin client
    const adminClient = createClient(supabaseUrl, supabaseServiceKey, {
      auth: { autoRefreshToken: false, persistSession: false },
    });

    // Check if calling user is a researcher
    const { data: callerProfile, error: profileError } = await adminClient
      .from("profiles")
      .select("role")
      .eq("id", callingUserId)
      .single();

    console.log("Caller profile:", { role: callerProfile?.role, error: profileError?.message });

    if (profileError || callerProfile?.role !== "researcher") {
      throw new Error("Only researchers can invite participants");
    }

    // Parse request body
    const { email, experiment_id, redirect_url, experiment_name } = await req.json();
    if (!email || !experiment_id) {
      throw new Error("Missing email or experiment_id");
    }

    console.log("Inviting:", email, "to experiment:", experiment_id);

    // Try to create user - if user already exists, createUser will fail
    let targetUserId: string;
    let password: string | null = null;
    let isNewUser = false;

    password = generatePassword();
    console.log("Attempting to create new user");

    const { data: newUser, error: createError } = await adminClient.auth.admin.createUser({
      email: email,
      password: password,
      email_confirm: true,
      user_metadata: {
        role: 'participant',
        is_private: true,
      },
    });

    if (createError) {
      // Check if user already exists
      if (createError.message.includes("already been registered") || 
          createError.message.includes("already exists") ||
          createError.message.includes("duplicate")) {
        console.log("User already exists, looking up...");
        
        // User exists - we need to find their ID
        // Try using invitation records to find existing user
        const { data: existingInvite } = await adminClient
          .from("experiment_invitations")
          .select("*")
          .eq("email", email)
          .limit(1)
          .maybeSingle();
        
        if (existingInvite) {
          console.log("Found existing invitation for email");
        }
        
        // Since we can't easily get user ID, just proceed without password
        password = null;
        isNewUser = false;
        targetUserId = "existing-user"; // placeholder - we don't need it for invitation
      } else {
        console.error("Create user error:", createError);
        throw createError;
      }
    } else {
      // New user created successfully
      isNewUser = true;
      targetUserId = newUser.user.id;
      console.log("New user created:", targetUserId);

      // Create profile for new user
      const { error: profileCreateError } = await adminClient
        .from("profiles")
        .insert({
          id: targetUserId,
          role: 'participant',
        });

      if (profileCreateError) {
        console.error("Profile creation error:", profileCreateError);
      }
    }

    // Add invitation record
    const { error: inviteError } = await adminClient
      .from("experiment_invitations")
      .upsert({
        experiment_id: experiment_id,
        email: email,
        status: 'pending',
      }, {
        onConflict: 'experiment_id,email',
      });

    if (inviteError) {
      console.error("Invitation record error:", inviteError);
    }

    // Get experiment name if not provided
    let expName = experiment_name;
    if (!expName) {
      const { data: expData } = await adminClient
        .from("experiments")
        .select("name")
        .eq("experiment_id", experiment_id)
        .single();
      expName = expData?.name || `实验 ${experiment_id}`;
    }

    // Build URLs - replace internal kong URL with external URL
    const externalUrl = supabaseUrl.replace('http://kong:8000', 'http://localhost:5173');
    const loginUrl = `${externalUrl}/`;
    const experimentUrl = `${externalUrl}/experiment/${experiment_id}?invite=true`;

    // Send email
    let emailSent = false;
    if (isNewUser && password) {
      // Send email with password for new user
      const emailHtml = `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2>您好！</h2>
          <p>您已被邀请参加实验: <strong>${expName}</strong></p>
          
          <div style="background-color: #f5f5f5; padding: 20px; border-radius: 8px; margin: 20px 0;">
            <h3 style="margin-top: 0;">您的登录信息</h3>
            <p><strong>邮箱:</strong> ${email}</p>
            <p><strong>临时密码:</strong> <code style="background: #e0e0e0; padding: 2px 6px; border-radius: 4px;">${password}</code></p>
            <p style="color: #d32f2f; font-size: 14px;">⚠️ 请登录后立即修改密码！</p>
          </div>
          
          <p>请点击下面的链接开始实验:</p>
          <p><a href="${experimentUrl}" 
             style="display: inline-block; background-color: #1976d2; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; margin: 10px 0;">
            开始实验
          </a></p>
          
          <p style="color: #666; font-size: 14px; margin-top: 20px;">
            或者您也可以访问 <a href="${loginUrl}">${loginUrl}</a> 使用邮箱和密码登录。
          </p>
          
          <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;">
          <p style="color: #999; font-size: 12px;">此邮件由系统自动发送，请勿直接回复。</p>
        </div>
      `;

      emailSent = await sendEmail(email, `邀请参加实验: ${expName}`, emailHtml);
    } else {
      // Send invitation email for existing user
      const emailHtml = `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2>您好！</h2>
          <p>您已被邀请参加实验: <strong>${expName}</strong></p>
          
          <p>请点击下面的链接使用您已有的账号登录并开始实验:</p>
          <p><a href="${experimentUrl}" 
             style="display: inline-block; background-color: #1976d2; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; margin: 10px 0;">
            开始实验
          </a></p>
          
          <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;">
          <p style="color: #999; font-size: 12px;">此邮件由系统自动发送，请勿直接回复。</p>
        </div>
      `;

      emailSent = await sendEmail(email, `邀请参加实验: ${expName}`, emailHtml);
    }

    console.log("Invitation complete. Email sent:", emailSent);

    return new Response(
      JSON.stringify({
        success: true,
        isNewUser: isNewUser,
        userId: targetUserId,
        email: email,
        password: isNewUser ? password : undefined,
        emailSent: emailSent,
        message: emailSent 
          ? (isNewUser ? "新用户已创建，邮件已发送" : "邀请邮件已发送")
          : (isNewUser ? `新用户已创建，临时密码: ${password}（邮件发送失败）` : "用户已存在，但邮件发送失败"),
      }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );

  } catch (error) {
    console.error("Error:", error);
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  }
});
