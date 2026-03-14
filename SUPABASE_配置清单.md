# MY SANDA 项目 Supabase 配置清单

本文档列出在 Supabase 控制台中需要手动完成的配置，确保项目所有功能上线后可正常使用。

---

## 一、前置准备

1. 在 [Supabase](https://supabase.com) 创建项目
2. 获取 **Project URL** 和 **anon public key**
3. 在 `js/supabase-config.js` 中配置：
   ```javascript
   window.SUPABASE_URL = 'https://你的项目.supabase.co';
   window.SUPABASE_ANON_KEY = '你的anon-key';
   ```

---

## 二、数据库表结构

在 **Supabase Dashboard → SQL Editor** 中执行 `supabase-full-schema.sql` 完整脚本，或按以下顺序手动创建。

### 1. profiles（用户资料，与 auth.users 关联）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID, PK, FK auth.users | 用户ID |
| email | TEXT | 邮箱 |
| nickname | TEXT NOT NULL DEFAULT '用户' | 昵称 |
| avatar | INTEGER DEFAULT 5 | 官方头像索引 0-6 |
| avatar_url | TEXT | 自定义头像 URL |
| gender | TEXT | 性别 |
| birthday | DATE | 生日 |
| school | TEXT | 学校 |
| college | TEXT | 学院 |
| major | TEXT | 专业 |
| bio | TEXT | 个人简介 |
| is_admin | BOOLEAN DEFAULT FALSE | 是否管理员 |
| created_at | TIMESTAMPTZ | 创建时间 |
| updated_at | TIMESTAMPTZ | 更新时间 |

### 2. study_materials（学习资料）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 上传者 |
| title | TEXT NOT NULL | 标题 |
| content | TEXT | 介绍 |
| category | TEXT NOT NULL | 分类 |
| file_url | TEXT | 文件 URL |
| image_url | TEXT | 图片 URL |
| created_at | TIMESTAMPTZ | 创建时间 |

### 3. campus_posts（校园生活）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 发布者 |
| content | TEXT NOT NULL | 内容 |
| image_url | TEXT | 图片 URL |
| comments | JSONB DEFAULT '[]' | 评论列表 |
| created_at | TIMESTAMPTZ | 创建时间 |

### 4. lost_items（失物招领）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 发布者 |
| content | TEXT NOT NULL | 内容 |
| image_url | TEXT | 图片 URL |
| comments | JSONB DEFAULT '[]' | 评论列表 |
| created_at | TIMESTAMPTZ | 创建时间 |

### 5. secondhand（二手闲置）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 发布者 |
| content | TEXT NOT NULL | 内容 |
| image_url | TEXT | 图片 URL |
| comments | JSONB DEFAULT '[]' | 评论列表 |
| created_at | TIMESTAMPTZ | 创建时间 |

### 6. questions（提问求助）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 发布者 |
| content | TEXT NOT NULL | 内容 |
| comments | JSONB DEFAULT '[]' | 评论列表 |
| anonymous | BOOLEAN DEFAULT FALSE | 是否匿名 |
| created_at | TIMESTAMPTZ | 创建时间 |

### 7. suggestions（建议改进）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL, PK | 主键 |
| user_id | UUID, FK auth.users | 发布者 |
| content | TEXT NOT NULL | 内容 |
| created_at | TIMESTAMPTZ | 创建时间 |

### 8. user_schedules（我的课表）

| 字段 | 类型 | 说明 |
|------|------|------|
| user_id | UUID, PK, FK auth.users | 用户ID |
| schedule_data | JSONB DEFAULT '{}' | 课表数据 |
| updated_at | TIMESTAMPTZ | 更新时间 |

---

## 三、RLS 行级安全策略

执行 `supabase-full-schema.sql` 后，以下策略已自动创建：

| 表 | 策略 | 说明 |
|----|------|------|
| profiles | SELECT 所有人可读 | 头像、昵称公开 |
| profiles | INSERT/UPDATE 仅本人 | auth.uid() = id |
| study_materials | SELECT 所有人可读 | 资料公开 |
| study_materials | INSERT/UPDATE/DELETE 仅本人 | auth.uid() = user_id |
| campus_posts | 同上 | 同上 |
| lost_items | 同上 | 同上 |
| secondhand | 同上 | 同上 |
| questions | 同上 | 同上 |
| suggestions | SELECT 所有人可读，INSERT 仅本人 | 建议不可改删 |
| user_schedules | SELECT/INSERT/UPDATE 仅本人 | auth.uid() = user_id |

---

## 四、存储桶（Storage）

在 **Supabase Dashboard → Storage** 中手动创建以下存储桶：

### 1. avatars（头像）

- **名称**：`avatars`
- **公开**：是（Public）
- **用途**：用户自定义头像
- **路径格式**：`{user_id}/{timestamp}.jpg`

### 2. publish-files（发布文件）

- **名称**：`publish-files`
- **公开**：是（Public）
- **用途**：校园生活/失物招领/二手/学习资料的图片和文件
- **路径格式**：`{folder}/{timestamp}_{random}.{ext}`  
  如 `campus/1234567890_abc.jpg`、`materials/1234567890_xyz.pdf`

### 存储桶权限策略（必执行）

在 **SQL Editor** 中执行 `supabase-storage-policies.sql`，否则上传会提示「无权限」：

- **publish-files**：认证用户可上传/更新，所有人可读
- **avatars**：认证用户可上传/更新，所有人可读

---

## 五、Auth 认证配置

1. **Authentication → Providers**：启用 Email 提供商
2. **禁用邮箱验证**（可选）：  
   Authentication → Email Templates → 可关闭 "Confirm email" 以简化注册
3. **密码重置**：需部署 Edge Function `reset-password`（见下文）

---

## 六、Edge Function（密码重置）

项目使用无邮箱验证的密码重置，需部署 Edge Function：

1. 在 Supabase 项目根目录执行：
   ```bash
   supabase functions new reset-password
   ```

2. 在 `supabase/functions/reset-password/index.ts` 中实现逻辑：
   - 接收 `{ email, new_password }`
   - 使用 Service Role Key 调用 `auth.admin.updateUserById()` 或等价 API 直接更新密码
   - 返回 `{ success: true }` 或 `{ error: '...' }`

3. 部署：
   ```bash
   supabase functions deploy reset-password
   ```

4. 若未部署，用户会看到「密码重置功能暂不可用」提示。

---

## 七、触发器（新用户自动创建 profile）

`supabase-full-schema.sql` 中已包含：

- **函数**：`public.handle_new_user()`
- **触发器**：`on_auth_user_created`，在 `auth.users` 插入后执行
- **作用**：新用户注册时自动在 `profiles` 表插入一条记录

---

## 八、CORS 与网络

- Supabase 默认允许浏览器跨域请求，一般无需额外配置
- 若部署在自定义域名，需在 Supabase Dashboard → Settings → API 中确认允许的域名

---

## 九、功能与表/存储对应关系

| 功能 | 表/存储 | 说明 |
|------|---------|------|
| 用户注册/登录 | auth.users + profiles | 邮箱、密码在 auth，资料在 profiles |
| 头像 | profiles.avatar_url / avatars 桶 | 官方头像用 avatar 索引，自定义用 avatar_url |
| 校园生活发布 | campus_posts + publish-files | 文字入表，图片上传至桶 |
| 失物招领发布 | lost_items + publish-files | 同上 |
| 二手闲置发布 | secondhand + publish-files | 同上 |
| 提问求助发布 | questions | 仅文字 |
| 学习资料上传 | study_materials + publish-files | 文件/图片入桶，记录入表 |
| 评论 | 各表 comments JSONB | 存于对应帖子表 |
| 课表 | user_schedules | 按 user_id 存储 |
| 建议反馈 | suggestions | 仅文字 |
| 下载 | publish-files 公开 URL | 通过 file_url/image_url 直接访问 |

---

## 十、检查清单

部署前请确认：

- [ ] 已执行 `supabase-full-schema.sql`
- [ ] 已创建 `avatars` 和 `publish-files` 存储桶，且为 Public
- [ ] 已执行 `supabase-storage-policies.sql` 配置存储桶上传权限
- [ ] 已在 `supabase-config.js` 中配置 URL 和 anon key
- [ ] 已部署 `reset-password` Edge Function（若需密码重置）
- [ ] Auth 已启用 Email 提供商
- [ ] 新用户注册后能自动创建 profile 记录
