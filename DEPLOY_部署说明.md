# 部署到 GitHub + Netlify 说明

## 已完成的修改

1. **路径**：所有 CSS、JS 使用 `./` 相对路径，兼容 GitHub Pages 子路径
2. **_redirects**：Netlify 会把所有路径指向 index.html（SPA 支持）
3. **404.html**：GitHub Pages 访问异常路径时跳回首页
4. **Supabase**：已在 `js/supabase-init.js` 中配置

## 部署步骤

### 方式一：Netlify（推荐）

1. 将项目推送到 GitHub
2. 登录 [Netlify](https://netlify.com)，New site from Git
3. 选择仓库，配置：
   - Build command：留空
   - Publish directory：`.` 或留空
4. 部署完成后，在 Supabase 控制台 **Authentication → URL Configuration** 中：
   - Site URL 改为：`https://你的网站.netlify.app`
   - Redirect URLs 添加：`https://你的网站.netlify.app/**`

### 方式二：GitHub Pages

1. 仓库 Settings → Pages → Source 选 GitHub Actions 或 main 分支 / root
2. 部署后网址：`https://用户名.github.io/仓库名/`
3. 在 Supabase 中配置该 URL 为 Site URL，并把 `https://用户名.github.io/仓库名/**` 加入 Redirect URLs

## Supabase 配置检查

- **Project URL**：`https://hsgvzrnvahkeujragiaz.supabase.co`（已写入）
- **anon key**：已写入
- 若登录/注册异常，到 Supabase **Project Settings → API** 检查 anon key 是否为 JWT 格式（以 `eyJ` 开头），若不是请替换为正确 key

## 本地测试

用 `npx serve` 或 `python -m http.server 3000` 在项目根目录启动，访问 http://localhost:3000 测试。
