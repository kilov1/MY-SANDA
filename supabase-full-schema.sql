-- ============================================================
-- MY SANDA 完整 Supabase 数据库 Schema
-- 在 Supabase Dashboard → SQL Editor 中执行此脚本
-- ============================================================

-- 1. 启用 UUID 扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. 用户资料表（与 auth.users 关联）
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    nickname TEXT NOT NULL DEFAULT '用户',
    avatar INTEGER DEFAULT 5,
    avatar_url TEXT,
    gender TEXT,
    birthday DATE,
    school TEXT,
    college TEXT,
    major TEXT,
    bio TEXT,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 学习资料
CREATE TABLE IF NOT EXISTS public.study_materials (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    content TEXT,
    category TEXT NOT NULL,
    file_url TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. 校园生活
CREATE TABLE IF NOT EXISTS public.campus_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. 失物招领
CREATE TABLE IF NOT EXISTS public.lost_items (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. 二手闲置
CREATE TABLE IF NOT EXISTS public.secondhand (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. 提问求助（仅文字，不可编辑）
CREATE TABLE IF NOT EXISTS public.questions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    comments JSONB DEFAULT '[]'::jsonb,
    anonymous BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. 建议改进
CREATE TABLE IF NOT EXISTS public.suggestions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. RLS 策略
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.campus_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lost_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.secondhand ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suggestions ENABLE ROW LEVEL SECURITY;

-- profiles
DROP POLICY IF EXISTS "profiles_read" ON public.profiles;
DROP POLICY IF EXISTS "profiles_insert" ON public.profiles;
DROP POLICY IF EXISTS "profiles_update" ON public.profiles;
CREATE POLICY "profiles_read" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "profiles_insert" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "profiles_update" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- study_materials
DROP POLICY IF EXISTS "study_materials_select" ON public.study_materials;
DROP POLICY IF EXISTS "study_materials_insert" ON public.study_materials;
DROP POLICY IF EXISTS "study_materials_update" ON public.study_materials;
DROP POLICY IF EXISTS "study_materials_delete" ON public.study_materials;
CREATE POLICY "study_materials_select" ON public.study_materials FOR SELECT USING (true);
CREATE POLICY "study_materials_insert" ON public.study_materials FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "study_materials_update" ON public.study_materials FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "study_materials_delete" ON public.study_materials FOR DELETE USING (auth.uid() = user_id);

-- campus_posts
DROP POLICY IF EXISTS "campus_posts_select" ON public.campus_posts;
DROP POLICY IF EXISTS "campus_posts_insert" ON public.campus_posts;
DROP POLICY IF EXISTS "campus_posts_update" ON public.campus_posts;
DROP POLICY IF EXISTS "campus_posts_delete" ON public.campus_posts;
CREATE POLICY "campus_posts_select" ON public.campus_posts FOR SELECT USING (true);
CREATE POLICY "campus_posts_insert" ON public.campus_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "campus_posts_update" ON public.campus_posts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "campus_posts_delete" ON public.campus_posts FOR DELETE USING (auth.uid() = user_id);

-- lost_items
DROP POLICY IF EXISTS "lost_items_select" ON public.lost_items;
DROP POLICY IF EXISTS "lost_items_insert" ON public.lost_items;
DROP POLICY IF EXISTS "lost_items_update" ON public.lost_items;
DROP POLICY IF EXISTS "lost_items_delete" ON public.lost_items;
CREATE POLICY "lost_items_select" ON public.lost_items FOR SELECT USING (true);
CREATE POLICY "lost_items_insert" ON public.lost_items FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "lost_items_update" ON public.lost_items FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "lost_items_delete" ON public.lost_items FOR DELETE USING (auth.uid() = user_id);

-- secondhand
DROP POLICY IF EXISTS "secondhand_select" ON public.secondhand;
DROP POLICY IF EXISTS "secondhand_insert" ON public.secondhand;
DROP POLICY IF EXISTS "secondhand_update" ON public.secondhand;
DROP POLICY IF EXISTS "secondhand_delete" ON public.secondhand;
CREATE POLICY "secondhand_select" ON public.secondhand FOR SELECT USING (true);
CREATE POLICY "secondhand_insert" ON public.secondhand FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "secondhand_update" ON public.secondhand FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "secondhand_delete" ON public.secondhand FOR DELETE USING (auth.uid() = user_id);

-- questions
DROP POLICY IF EXISTS "questions_select" ON public.questions;
DROP POLICY IF EXISTS "questions_insert" ON public.questions;
DROP POLICY IF EXISTS "questions_update" ON public.questions;
DROP POLICY IF EXISTS "questions_delete" ON public.questions;
CREATE POLICY "questions_select" ON public.questions FOR SELECT USING (true);
CREATE POLICY "questions_insert" ON public.questions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "questions_update" ON public.questions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "questions_delete" ON public.questions FOR DELETE USING (auth.uid() = user_id);

-- suggestions
DROP POLICY IF EXISTS "suggestions_select" ON public.suggestions;
DROP POLICY IF EXISTS "suggestions_insert" ON public.suggestions;
CREATE POLICY "suggestions_select" ON public.suggestions FOR SELECT USING (true);
CREATE POLICY "suggestions_insert" ON public.suggestions FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 10. 新用户注册时自动创建 profile
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, nickname)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'nickname', split_part(COALESCE(NEW.email, 'user@local'), '@', 1))
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    nickname = COALESCE(EXCLUDED.nickname, profiles.nickname),
    updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 11. Storage 存储桶（在 Dashboard → Storage 中手动创建）：
--     - avatars (Public) 头像
--     - publish-files (Public) 发布图片/文件
