# MY SANDA 校园网站 - Supabase 完整配置指南

按以下步骤操作，保证能直接成功。

---

## 第一步：创建 Supabase 项目

1. 打开 https://supabase.com 并登录
2. 点击 **New Project**
3. **Name** 填：`sanda-blog`
4. **Database Password** 设置并记住（用于数据库连接，网站前端不用）
5. **Region** 选：`East Asia (Tokyo)` 或离你最近的
6. 点击 **Create new project**，等待约 2 分钟

---

## 第二步：开启 Email 登录、验证、找回密码

1. 左侧点 **Authentication**（人形图标）
2. 点 **Providers**
3. 找到 **Email**，确保是 **Enabled**（开启）
4. 点 **Email** 右侧进入设置
5. 打开 **Confirm email**（必须开，未验证不能登录）
6. 其他保持默认，点 **Save**

---

## 第三步：配置 URL（找回密码必须）

1. 左侧 **Authentication** → **URL Configuration**
2. **Site URL** 填：`http://localhost:3000`
3. **Redirect URLs** 点 **Add URL**，添加：
   - `http://localhost:3000/**`
   - `http://127.0.0.1:3000/**`（备用）
4. 点 **Save**

---

## 第四步：复制 Project URL 和 anon key

1. 左侧点 **Project Settings**（齿轮图标）
2. 点 **API** 标签
3. **Project URL**：复制整行（如 `https://xxxxx.supabase.co`）
4. **Project API keys** 区域：
   - 找到 **anon** 和 **public**
   - 点击 **Reveal** 或复制图标
   - 复制 **anon** 的 key（一长串字符）

---

## 第五步：修改网站代码中的 URL 和 Key

打开 `js/supabase-init.js`，把第 6、7 行改成你的真实值：

```javascript
const SUPABASE_URL = '你复制的 Project URL';
const SUPABASE_ANON_KEY = '你复制的 anon key';
```

保存文件。

---

## 第六步：创建数据库表

1. 左侧点 **SQL Editor**
2. 点 **New query**
3. 打开你项目里的 `supabase-schema.sql` 文件
4. 全选复制（Ctrl+A → Ctrl+C）
5. 粘贴到 SQL Editor
6. 点 **Run**（或 Ctrl+Enter）
7. 看到绿色 **Success** 表示成功

---

## 第七步：权限与安全设置（重要）

### 必须保持的默认设置：
- **RLS（Row Level Security）**：已通过 SQL 脚本开启，不要关
- **anon key**：可以暴露在前端，Supabase 靠 RLS 保护数据
- **Confirm email**：必须开启

### 不要做的事：
- 不要关闭 **Email** Provider
- 不要关闭 **Confirm email**
- 不要禁用 RLS
- **service_role key** 绝对不要写入前端代码

---

## 第八步：设置管理员（可选）

1. 在网站上注册一个账号
2. 去邮箱点验证链接完成验证
3. 左侧 **SQL Editor** → **New query**
4. 执行（把邮箱改成你的）：

```sql
UPDATE public.profiles 
SET is_admin = true 
WHERE email = '你的邮箱@xxx.com';
```

---

## 第九步：验证连接

1. 用 `http://localhost:3000` 打开网站（不要用 file://）
2. 测试注册 → 收邮件 → 点验证 → 登录
3. 测试发布校园生活 → 刷新页面数据还在
4. 测试忘记密码 → 收邮件 → 点链接 → 设新密码

---

## 常见问题

| 问题 | 解决 |
|------|------|
| 注册后提示邮箱未验证 | 正常，去邮箱点链接验证 |
| 收不到邮件 | 检查垃圾箱；Supabase 免费版有发送限制 |
| 忘记密码链接点开没反应 | 检查 Redirect URLs 是否包含你的地址 |
| 登录失败 | 确认已点过验证链接 |
| 发布失败 | 确认 SQL 脚本完整执行成功 |

---

## 表结构说明（已通过 SQL 脚本创建）

- `profiles` - 用户资料（昵称、头像等）
- `life_posts` - 校园生活
- `lost_found_posts` - 失物招领
- `secondhand_posts` - 二手闲置
- `ask_help_posts` - 提问求助
- `materials` - 学习资料
- `feedback` - 建议反馈
- `reports` - 内容举报

在线人数使用 Realtime Presence，无需建表。
