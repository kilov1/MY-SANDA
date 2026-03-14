-- 我的课表表（在 Supabase SQL Editor 中执行）
-- 若 profiles 使用 auth.users，请根据实际调整 user_id 类型
CREATE TABLE IF NOT EXISTS user_schedules (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  schedule_data jsonb DEFAULT '{}',
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE user_schedules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can manage own schedule" ON user_schedules FOR ALL USING (auth.uid() = user_id);
