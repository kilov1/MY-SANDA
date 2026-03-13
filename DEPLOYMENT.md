# 部署指南

## 将 MY SANDA 部署到线上

完成本地开发后，你可以将项目部署到以下平台之一。

---

## 方案 1：Vercel（推荐）

Vercel 是最简单的部署方式，完全免费。

### 步骤

1. **访问 Vercel**
   - 打开 https://vercel.com
   - 点击 "Sign Up" 注册账户

2. **连接 GitHub**
   - 将项目上传到 GitHub
   - 在 Vercel 中点击 "Import Project"
   - 选择你的 GitHub 仓库

3. **配置环境变量**
   - 在 Vercel 项目设置中添加环境变量
   - 但由于我们在代码中直接配置，可以跳过此步

4. **部署**
   - Vercel 会自动部署
   - 你会获得一个 `.vercel.app` 的域名

### 优点
- ✅ 完全免费
- ✅ 自动 HTTPS
- ✅ 自动部署（推送到 GitHub 时）
- ✅ 全球 CDN

---

## 方案 2：Netlify

Netlify 也是很好的选择。

### 步骤

1. **访问 Netlify**
   - 打开 https://netlify.com
   - 点击 "Sign up" 注册账户

2. **部署**
   - 点击 "Add new site"
   - 选择 "Deploy manually"
   - 将项目文件夹拖放到部署区域

3. **获取域名**
   - Netlify 会自动分配一个域名
   - 你也可以连接自己的域名

### 优点
- ✅ 完全免费
- ✅ 支持拖放部署
- ✅ 自动 HTTPS
- ✅ 简单易用

---

## 方案 3：GitHub Pages

如果你的项目在 GitHub 上，可以使用 GitHub Pages。

### 步骤

1. **创建 GitHub 仓库**
   - 在 GitHub 上创建新仓库
   - 仓库名称：`username.github.io`（替换 username）

2. **推送代码**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/username/username.github.io.git
   git push -u origin main
   ```

3. **启用 GitHub Pages**
   - 进入仓库设置
   - 找到 "Pages" 选项
   - 选择 "Deploy from a branch"
   - 选择 "main" 分支

4. **访问网站**
   - 你的网站将在 `https://username.github.io` 上线

### 优点
- ✅ 完全免费
- ✅ 与 GitHub 集成
- ✅ 自动 HTTPS

---

## 方案 4：自己的服务器

如果你有自己的服务器或虚拟主机。

### 步骤

1. **上传文件**
   - 使用 FTP 或 SSH 上传所有文件到服务器
   - 确保 `index.html` 在根目录

2. **配置 Web 服务器**
   - 如果使用 Apache，确保启用 `.htaccess`
   - 如果使用 Nginx，配置正确的路由

3. **配置 HTTPS**
   - 使用 Let's Encrypt 获取免费 SSL 证书
   - 配置服务器使用 HTTPS

### 优点
- ✅ 完全控制
- ✅ 可自定义配置
- ✅ 支持后端功能

---

## 部署前检查清单

在部署前，请确保：

- [ ] Supabase 配置正确（`js/app.js` 中的 URL 和 Key）
- [ ] 所有文件都已上传
- [ ] 测试所有功能（注册、登录、忘记密码）
- [ ] 检查浏览器控制台是否有错误
- [ ] 在不同设备上测试响应式设计

---

## 部署后配置

### 1. 自定义域名

如果你有自己的域名，可以连接到部署平台：

**Vercel:**
- 进入项目设置 → Domains
- 添加你的域名
- 按照说明配置 DNS

**Netlify:**
- 进入 Site settings → Domain management
- 添加你的域名
- 按照说明配置 DNS

### 2. 配置 Supabase CORS

为了安全起见，建议在 Supabase 中配置 CORS：

1. 进入 Supabase 项目设置
2. 找到 "API" 部分
3. 在 "CORS" 中添加你的域名

### 3. 监控和分析

- 使用 Google Analytics 追踪用户
- 使用 Sentry 监控错误
- 定期检查 Supabase 日志

---

## 常见问题

### Q: 部署后登录功能不工作？
A: 检查 Supabase 配置是否正确，确保 API URL 和 Key 没有泄露。

### Q: 如何更新已部署的网站？
A: 
- **Vercel/Netlify**: 推送到 GitHub，会自动部署
- **GitHub Pages**: 推送到 main 分支，自动更新
- **自己的服务器**: 重新上传文件

### Q: 如何处理 CORS 错误？
A: 在 Supabase 项目设置中配置 CORS，添加你的域名。

### Q: 部署后性能如何优化？
A: 
- 启用 CDN
- 压缩图片
- 使用缓存
- 最小化 CSS/JS

---

## 推荐部署流程

1. **本地开发和测试**
   - 在本地完成所有功能开发
   - 充分测试所有功能

2. **上传到 GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

3. **部署到 Vercel 或 Netlify**
   - 连接 GitHub 仓库
   - 自动部署

4. **配置自定义域名**
   - 添加你的域名
   - 配置 DNS

5. **监控和维护**
   - 定期检查日志
   - 及时修复 bug
   - 持续添加新功能

---

## 成本估算

| 平台 | 成本 | 备注 |
|------|------|------|
| Vercel | 免费 | 推荐 |
| Netlify | 免费 | 推荐 |
| GitHub Pages | 免费 | 推荐 |
| 自己的服务器 | 按月付费 | 需要维护 |
| Supabase | 免费 + 按用量付费 | 免费额度足够小项目 |

---

## 下一步

部署完成后，你可以：

1. 分享你的网站链接
2. 邀请用户注册和使用
3. 收集用户反馈
4. 继续开发新功能
5. 优化用户体验

---

祝部署顺利！🚀

**更新时间**: 2026年3月13日
