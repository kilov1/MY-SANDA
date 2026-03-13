# MY SANDA - Netlify 部署 + Supabase 联通指南

## 一、前置准备

### 1. 完成 Supabase 配置
1. 在 [Supabase](https://supabase.com) 创建项目
2. 在 **Project Settings → API** 复制 **Project URL** 和 **anon key**
3. 在 **SQL Editor** 中执行 `supabase-schema.sql` 创建所有表
4. 在 **Authentication → URL Configuration**：
   - **Site URL** 填：`https://你的站点.netlify.app`（部署后再填最终地址）
   - **Redirect URLs** 添加：
     - `https://*.netlify.app/**`
     - `http://localhost:3000/**`（本地开发）

### 2. 修改 Supabase 配置
打开 `js/supabase-config.js`，将占位符替换为你的实际值：

```javascript
window.SUPABASE_URL = 'https://你的项目ID.supabase.co';
window.SUPABASE_ANON_KEY = '你的anon-key';
```

---

## 二、上传到 GitHub

1. 在 GitHub 创建新仓库
2. 本地初始化并推送：

```bash
git init
git add .
git commit -m "Initial commit: MY SANDA with Supabase"
git branch -M main
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
```

---

## 三、Netlify 部署

1. 登录 [Netlify](https://netlify.com)
2. 点击 **Add new site → Import an existing project**
3. 选择 **GitHub**，授权后选中你的仓库
4. 构建配置：
   - **Build command**：留空（或填写 `echo "ok"`）
   - **Publish directory**：`.`（根目录）
5. 点击 **Deploy site**
6. 部署完成后记下你的站点地址，如：`https://xxx.netlify.app`

---

## 四、配置 Supabase 重定向（部署后）

1. 回到 Supabase → **Authentication → URL Configuration**
2. **Site URL** 改为：`https://你的站点.netlify.app`
3. 在 **Redirect URLs** 中确认已有 `https://你的站点.netlify.app/**`
4. 保存

---

## 五、验证

- 打开 `https://你的站点.netlify.app`
- 测试注册 → 收邮件 → 验证 → 登录
- 测试发布校园生活、学习资料等，数据应写入 Supabase
- 测试忘记密码流程

---

## 六、本地模式说明

若 `supabase-config.js` 保持占位符（`your-project`、`your-anon-key`），站点将自动使用**本地模式**：
- 数据存于浏览器 localStorage
- 无需真实邮箱，假邮箱即可注册/登录
- 适用于本地开发或无需数据库的场景

配置有效 Supabase 后，自动切换到数据库模式，登录注册使用真实邮箱和 Supabase Auth。
