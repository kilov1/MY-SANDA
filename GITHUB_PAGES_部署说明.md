# GitHub Pages 部署说明

## 一、确保所有文件已上传

404 错误通常是因为 **css、js 等文件夹未成功推送到 GitHub**。

### 1. 检查本地是否有这些文件/文件夹

```
mysanda/
├── index.html
├── css/
│   └── style.css
├── js/
│   ├── local-api.js
│   ├── supabase-config.js
│   ├── supabase-init.js
│   ├── supabase-api.js
│   ├── content-filter.js
│   ├── home-carousel.js
│   ├── materials.js
│   ├── campus-life.js
│   ├── profile.js
│   ├── community-data.js
│   ├── community.js
│   ├── my-posts.js
│   ├── feedback.js
│   └── app.js
├── 404.html
└── ...
```

### 2. 使用命令行上传（推荐）

双击运行 **`push-to-github.bat`**，确保所有文件被 git add 并推送。

### 3. 在 GitHub 网页上检查

打开你的仓库：`https://github.com/kilov1/my-sanda`

确认存在：
- `css` 文件夹（点进去有 `style.css`）
- `js` 文件夹（点进去有以上所有 js 文件）

如果这些文件夹或文件不存在，说明之前只推送了部分文件，需要重新运行 `push-to-github.bat` 完整推送。

---

## 二、启用 GitHub Pages

1. 打开仓库 → **Settings** → 左侧 **Pages**
2. **Source** 选择：`Deploy from a branch`
3. **Branch** 选择：`main`（或你的主分支），文件夹选 `/ (root)`
4. 点击 **Save**
5. 等待 1–2 分钟，访问：`https://kilov1.github.io/my-sanda/`

---

## 三、已修复的问题

- **base 路径**：已修正 `base` 标签，保证在 `kilov1.github.io/my-sanda` 下资源路径正确
- **Supabase CDN**：已改用 Cloudflare CDN，降低被 Tracking Prevention 拦截的概率

---

## 四、Tracking Prevention（跟踪防护）说明

如仍出现 “Tracking Prevention blocked”：

- 多为 **Edge / Firefox** 的隐私设置拦截第三方 CDN
- 可尝试：在该站点中为该页面关闭跟踪防护，或使用 Chrome 访问
- 不影响本地运行，只影响部分浏览器访问线上环境

---

## 五、Tailwind CDN 提示

控制台中 “cdn.tailwindcss.com should not be used in production” 为 Tailwind 官方提示。

- 当前项目使用 CDN 方式，功能正常
- 若希望去掉该提示，需改为本地构建（PostCSS / Tailwind CLI），会增加构建步骤
