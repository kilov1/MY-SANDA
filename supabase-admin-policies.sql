-- 管理员相关策略 - 在 Supabase SQL Editor 中执行
-- 1. 设置管理员：将指定用户的 is_admin 设为 true（需先注册该邮箱）
UPDATE public.profiles SET is_admin = true WHERE email = '1941125975@qq.com';

-- 2. 若 suggestions 表需管理员删除权限，执行以下（表名以实际为准，若为 feedback 则改表名）
-- DROP POLICY IF EXISTS "suggestions_delete_admin" ON public.suggestions;
-- CREATE POLICY "suggestions_delete_admin" ON public.suggestions FOR DELETE
--   USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
