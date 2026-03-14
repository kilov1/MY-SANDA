-- 为 profiles 表添加 avatar_url 列（用于头像上传）
-- 在 Supabase SQL Editor 中执行
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS avatar_url TEXT;

-- 创建 avatars 存储桶（用于头像图片）
-- 在 Supabase Storage 中手动创建名为 avatars 的 bucket，并设置为 public
