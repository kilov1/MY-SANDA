-- 封禁功能：在 Supabase SQL Editor 中执行
-- 1. 为 profiles 表添加 banned_until 列
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS banned_until TIMESTAMPTZ;

-- 2. 允许管理员更新任意用户的 banned_until
DROP POLICY IF EXISTS "profiles_admin_update_ban" ON public.profiles;
CREATE POLICY "profiles_admin_update_ban" ON public.profiles FOR UPDATE
  USING (EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.is_admin = true));
