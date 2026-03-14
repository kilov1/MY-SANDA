-- MY SANDA 校园网站 Supabase 数据库 Schema
-- 在 Supabase 控制台 SQL Editor 中执行此脚本

-- 1. 启用 UUID 扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. 用户资料表（与 auth.users 关联）
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    nickname TEXT NOT NULL,
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

-- 3. 校园生活
CREATE TABLE IF NOT EXISTS public.life_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    uploader TEXT NOT NULL,
    avatar TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. 失物招领
CREATE TABLE IF NOT EXISTS public.lost_found_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    uploader TEXT NOT NULL,
    avatar TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. 二手闲置
CREATE TABLE IF NOT EXISTS public.secondhand_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    uploader TEXT NOT NULL,
    avatar TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. 提问求助
CREATE TABLE IF NOT EXISTS public.ask_help_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    uploader TEXT NOT NULL,
    avatar TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT,
    comments JSONB DEFAULT '[]'::jsonb,
    anonymous BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. 学习资料
CREATE TABLE IF NOT EXISTS public.materials (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    uploader TEXT NOT NULL,
    file_path TEXT,
    file_size TEXT,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. 建议反馈
CREATE TABLE IF NOT EXISTS public.feedback (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    uploader TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. 内容举报
CREATE TABLE IF NOT EXISTS public.reports (
    id BIGSERIAL PRIMARY KEY,
    reporter_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    target_type TEXT NOT NULL,
    target_id BIGINT NOT NULL,
    reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 10. 在线人数：使用 Supabase Realtime Presence 统计，无需单独表

-- 11. 在 Supabase Dashboard > Storage 中手动创建 bucket: posts-images, materials（可选，用于图片和文件上传）

-- 12. RLS 策略
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.life_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lost_found_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.secondhand_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ask_help_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.materials ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;

-- profiles: 所有人可读，仅自己可更新
CREATE POLICY "profiles_read" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "profiles_insert" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "profiles_update" ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- life_posts: 所有人可读，登录用户可增，仅作者或管理员可改删
CREATE POLICY "life_read" ON public.life_posts FOR SELECT USING (true);
CREATE POLICY "life_insert" ON public.life_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "life_update" ON public.life_posts FOR UPDATE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "life_delete" ON public.life_posts FOR DELETE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- lost_found_posts
CREATE POLICY "lost_found_read" ON public.lost_found_posts FOR SELECT USING (true);
CREATE POLICY "lost_found_insert" ON public.lost_found_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "lost_found_update" ON public.lost_found_posts FOR UPDATE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "lost_found_delete" ON public.lost_found_posts FOR DELETE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- secondhand_posts
CREATE POLICY "secondhand_read" ON public.secondhand_posts FOR SELECT USING (true);
CREATE POLICY "secondhand_insert" ON public.secondhand_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "secondhand_update" ON public.secondhand_posts FOR UPDATE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "secondhand_delete" ON public.secondhand_posts FOR DELETE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- ask_help_posts
CREATE POLICY "ask_help_read" ON public.ask_help_posts FOR SELECT USING (true);
CREATE POLICY "ask_help_insert" ON public.ask_help_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "ask_help_update" ON public.ask_help_posts FOR UPDATE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "ask_help_delete" ON public.ask_help_posts FOR DELETE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- materials
CREATE POLICY "materials_read" ON public.materials FOR SELECT USING (true);
CREATE POLICY "materials_insert" ON public.materials FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "materials_update" ON public.materials FOR UPDATE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));
CREATE POLICY "materials_delete" ON public.materials FOR DELETE USING (auth.uid() = user_id OR EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- feedback
CREATE POLICY "feedback_read" ON public.feedback FOR SELECT USING (true);
CREATE POLICY "feedback_insert" ON public.feedback FOR INSERT WITH CHECK (auth.uid() = user_id);

-- reports
CREATE POLICY "reports_insert" ON public.reports FOR INSERT WITH CHECK (auth.uid() = reporter_id);
CREATE POLICY "reports_read_admin" ON public.reports FOR SELECT USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- 13. 自动创建 profile 的触发器
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, nickname)
  VALUES (NEW.id, NEW.email, COALESCE(NEW.raw_user_meta_data->>'nickname', split_part(NEW.email, '@', 1)))
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
