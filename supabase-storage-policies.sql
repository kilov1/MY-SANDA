-- ============================================================
-- Supabase 存储桶权限策略 - 解决「无权限」上传问题
-- 在 Supabase Dashboard → SQL Editor 中执行此脚本
-- ============================================================
-- 执行前请确保已创建 publish-files 和 avatars 存储桶（Dashboard → Storage）
-- 若未创建：Storage → New bucket → 名称 publish-files，勾选 Public

-- 若提示 policy 已存在，可忽略（DROP POLICY IF EXISTS 会先删除）

-- 1. publish-files 桶：认证用户可上传、所有人可读
DROP POLICY IF EXISTS "publish-files_upload" ON storage.objects;
CREATE POLICY "publish-files_upload" ON storage.objects
FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'publish-files');

DROP POLICY IF EXISTS "publish-files_read" ON storage.objects;
CREATE POLICY "publish-files_read" ON storage.objects
FOR SELECT TO public
USING (bucket_id = 'publish-files');

-- upsert 需要 UPDATE 权限
DROP POLICY IF EXISTS "publish-files_update" ON storage.objects;
CREATE POLICY "publish-files_update" ON storage.objects
FOR UPDATE TO authenticated
USING (bucket_id = 'publish-files');

-- 2. avatars 桶：认证用户可上传、所有人可读
DROP POLICY IF EXISTS "avatars_upload" ON storage.objects;
CREATE POLICY "avatars_upload" ON storage.objects
FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_read" ON storage.objects;
CREATE POLICY "avatars_read" ON storage.objects
FOR SELECT TO public
USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_update" ON storage.objects;
CREATE POLICY "avatars_update" ON storage.objects
FOR UPDATE TO authenticated
USING (bucket_id = 'avatars');
