# Supabase 认证配置 - 最简步骤

实现：**邮箱注册 + 邮箱验证 + 邮箱找回密码**

---

## 一、Supabase 控制台操作（5 步）

### 1. 开启邮箱验证（必须）
- 左侧 **Authentication** → **Providers** → **Email**
- 打开 **Confirm email** 开关
- 未验证邮箱的用户无法登录

### 2. 配置重定向地址
- 左侧 **Authentication** → **URL Configuration**
- **Site URL**：填网站地址
  - 本地调试：`http://localhost:5500`（或你实际的端口）
  - 上线后：`https://你的域名.com`
- **Redirect URLs**：新增一行
  - 本地：`http://localhost:5500/**`
  - 上线：`https://你的域名.com/**`
  - 多环境可多行

### 3. 使用 Supabase 默认邮件
- 左侧 **Authentication** → **Email Templates**
- 保持默认，Supabase 会自动发验证和重置邮件
- 注意：免费版有每日邮件数量限制

### 4. 检查是否已有 profiles 表
- 左侧 **Table Editor**
- 有 `profiles` 表即可，与 `auth.users` 关联
- 如尚未执行过 schema，请执行 `supabase-schema.sql`

### 5. （可选）自定义邮件模板
- **Authentication** → **Email Templates**
- **Confirm signup**：验证邮箱
- **Reset password**：重置密码
- 可改文案，不要改链接变量

---

## 二、本地配置

1. 打开 `js/supabase-init.js`
2. 填入：
   ```js
   const SUPABASE_URL = 'https://你的项目.supabase.co';
   const SUPABASE_ANON_KEY = '你的 anon key';
   ```
3. URL 和 Key 在：**Project Settings** → **API**

---

## 三、本地运行方式

**不要用 `file://` 直接打开 HTML**，需要本地服务器，否则重定向会出问题。

推荐：
```
npx serve .
```
或
```
python -m http.server 8080
```

然后访问 `http://localhost:8080` 或 `http://localhost:5500`

---

## 四、流程说明

| 操作 | 流程 |
|------|------|
| 注册 | 填邮箱/密码/昵称 → 收到验证邮件 → 点击验证 → 可登录 |
| 登录 | 仅验证过邮箱的账号能登录 |
| 忘记密码 | 填邮箱 → 收到重置邮件 → 点击链接 → 设新密码 → 登录 |

---

## 五、常见问题

| 现象 | 处理 |
|------|------|
| 收不到邮件 | 查垃圾箱；检查 Supabase Email 是否启用；免费版有配额 |
| 登录提示邮箱未验证 | 检查确认邮件；去 Auth → Users 看该用户是否已确认 |
| 点重置链接后仍是登录页 | 检查 Redirect URLs 是否包含当前站点 |
| 本地测试 redirect 异常 | 用本地服务器（如 `npx serve .`），不要用 file:// |
