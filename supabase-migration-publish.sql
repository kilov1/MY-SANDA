-- 发布功能表结构（按用户要求）
-- 在 Supabase SQL Editor 中执行

-- 1. 学习资料
CREATE TABLE IF NOT EXISTS study_materials (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    content TEXT,
    category TEXT NOT NULL,
    file_url TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE study_materials ENABLE ROW LEVEL SECURITY;
CREATE POLICY "study_materials_select" ON study_materials FOR SELECT USING (true);
CREATE POLICY "study_materials_insert" ON study_materials FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "study_materials_update" ON study_materials FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "study_materials_delete" ON study_materials FOR DELETE USING (auth.uid() = user_id);

-- 2. 校园动态（comments 用于评论列表，兼容前端）
CREATE TABLE IF NOT EXISTS campus_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE campus_posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "campus_posts_select" ON campus_posts FOR SELECT USING (true);
CREATE POLICY "campus_posts_insert" ON campus_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "campus_posts_update" ON campus_posts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "campus_posts_delete" ON campus_posts FOR DELETE USING (auth.uid() = user_id);

-- 3. 失物招领
CREATE TABLE IF NOT EXISTS lost_items (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE lost_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "lost_items_select" ON lost_items FOR SELECT USING (true);
CREATE POLICY "lost_items_insert" ON lost_items FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "lost_items_update" ON lost_items FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "lost_items_delete" ON lost_items FOR DELETE USING (auth.uid() = user_id);

-- 4. 二手闲置
CREATE TABLE IF NOT EXISTS secondhand (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    image_url TEXT,
    comments JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE secondhand ENABLE ROW LEVEL SECURITY;
CREATE POLICY "secondhand_select" ON secondhand FOR SELECT USING (true);
CREATE POLICY "secondhand_insert" ON secondhand FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "secondhand_update" ON secondhand FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "secondhand_delete" ON secondhand FOR DELETE USING (auth.uid() = user_id);

-- 5. 提问求助（无图片）
CREATE TABLE IF NOT EXISTS questions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    comments JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "questions_select" ON questions FOR SELECT USING (true);
CREATE POLICY "questions_insert" ON questions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "questions_update" ON questions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "questions_delete" ON questions FOR DELETE USING (auth.uid() = user_id);

-- 6. 建议改进
CREATE TABLE IF NOT EXISTS suggestions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE suggestions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "suggestions_select" ON suggestions FOR SELECT USING (true);
CREATE POLICY "suggestions_insert" ON suggestions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "suggestions_update" ON suggestions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "suggestions_delete" ON suggestions FOR DELETE USING (auth.uid() = user_id);

-- 存储桶（上传文件/图片）：
-- 在 Supabase Dashboard → Storage → New bucket 创建：
-- 名称: publish-files
-- Public bucket: 勾选
