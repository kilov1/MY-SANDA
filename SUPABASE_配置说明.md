# MY SANDA Supabase 完整配置说明

## 一、Supabase 项目设置

### 1. 创建项目
1. 登录 [Supabase](https://supabase.com)
2. 新建项目，记录 **Project URL** 和 **anon key**（Project Settings → API）

### 2. 关闭邮箱验证（必须）
- 进入 **Authentication → Providers → Email**
- 关闭 **Confirm email**（不要求邮箱验证）
- 这样注册后可直接登录，无需点击验证链接

### 3. 配置 js/supabase-config.js
```javascript
window.SUPABASE_URL = 'https://你的项目.supabase.co';
window.SUPABASE_ANON_KEY = '你的anon-key';
```

---

## 二、执行数据库 Schema

在 **SQL Editor** 中执行 `supabase-full-schema.sql` 全部内容。

---

## 三、创建 Storage 存储桶

在 **Storage** 中创建两个 **Public** 桶：

| 名称 | 类型 | 说明 |
|------|------|------|
| avatars | Public | 用户头像 |
| publish-files | Public | 发布图片/文件 |

---

## 四、部署密码重置 Edge Function（无邮箱验证）

### 使用 Supabase CLI

```bash
npm install -g supabase
supabase login
cd 项目目录
supabase link --project-ref 你的项目ID
supabase functions deploy reset-password
```

项目 ID 在 Supabase Dashboard → Project Settings → General 中查看。

### 函数代码位置

`supabase/functions/reset-password/index.ts`

---

## 五、功能清单

- ✅ 注册：邮箱+密码+昵称，无邮箱验证，注册成功跳转登录页
- ✅ 登录：邮箱+密码，登录后右上角显示头像+昵称
- ✅ 忘记密码：输入邮箱（格式正确）→ 输入新密码+重复 → 重置成功跳转登录（不发邮件）
- ✅ 个人资料：昵称、性别、生日、个性签名、学校、学院、专业、头像、修改密码（带密码强度条）
- ✅ 校园生活 / 失物招领 / 二手闲置：发布文字+图片，可删可改
- ✅ 提问求助：仅文字，可删不可改
- ✅ 学习资料：上传文件/图片+分类+简介，可删可改
- ✅ 建议改进：仅文字，需登录才能发布
