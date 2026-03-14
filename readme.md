# MY SANDA - 校园论坛网站

一个现代化的校园论坛网站，使用 HTML、Tailwind CSS、JavaScript 和 Supabase 构建。

## 功能特性

✨ **完整的认证系统**
- 用户注册（邮箱、昵称、密码）
- 用户登录
- 忘记密码 / 重置密码
- 密码强度实时反馈

🎨 **现代化设计**
- 响应式布局，完美适配手机和电脑
- 美观的渐变色设计
- 流畅的动画效果
- 清晰的用户界面

📱 **分类系统**
- 8个校园论坛分类
- 横版分类按钮布局
- 校园论坛介绍文字

## 项目结构

```
sandablog/
├── index.html           # 主页面
├── css/
│   └── style.css       # 样式文件
├── js/
│   ├── app.js          # 主应用逻辑
│   └── supabase-config.js  # Supabase 配置
└── README.md           # 本文件
```

## 快速开始

### 1. 克隆或下载项目

```bash
git clone <repository-url>
cd sandablog
```

### 2. 配置 Supabase

#### 步骤 1：创建 Supabase 项目
- 访问 [https://supabase.com](https://supabase.com)
- 注册账户并创建新项目
- 等待项目初始化完成

#### 步骤 2：获取 API 密钥
- 进入项目设置 → API
- 复制 `Project URL` 和 `anon public key`

#### 步骤 3：配置认证
- 进入 Authentication → Providers
- 找到 Email 提供商
- 禁用 "Confirm email" 选项（关闭邮箱验证）
- 点击 Save

#### 步骤 4：更新配置文件
编辑 `js/app.js`，找到以下代码并替换：

```javascript
const SUPABASE_URL = 'https://your-project.supabase.co';
const SUPABASE_KEY = 'your-anon-key';
```

替换为你的实际值：

```javascript
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### 3. 运行项目

#### 方式 1：使用 Python 简单服务器
```bash
python -m http.server 8000
```

然后在浏览器中打开 `http://localhost:8000`

#### 方式 2：使用 Node.js http-server
```bash
npx http-server
```

#### 方式 3：直接打开文件
在浏览器中直接打开 `index.html` 文件（某些功能可能受限）

## 功能说明

### 首页
- 展示欢迎信息
- 8个分类按钮（横版排列）
- 校园论坛介绍文字
- 内容区域占位符

### 注册页面
- 邮箱输入（作为账号）
- 昵称输入
- 密码输入
- 重复密码输入
- 实时密码强度显示（红/黄/绿三色）
- 表单验证

### 登录页面
- 邮箱登录
- 密码输入
- 忘记密码链接
- 注册链接

### 忘记密码页面
- 邮箱验证
- 直接跳转到重置密码页面

### 重置密码页面
- 新密码输入
- 重复密码输入
- 密码强度显示
- 密码重置功能

## 密码强度标准

- **弱（红色）**：密码长度 < 8 或只包含一种字符类型
- **中（黄色）**：密码长度 ≥ 8 且包含 2 种字符类型
- **强（绿色）**：密码长度 ≥ 8 且包含 3 种以上字符类型

字符类型包括：小写字母、大写字母、数字、特殊字符

## 响应式设计

网站完美适配以下设备：
- 📱 手机（320px 及以上）
- 📱 平板（768px 及以上）
- 💻 桌面（1024px 及以上）

## 技术栈

- **HTML5** - 页面结构
- **Tailwind CSS** - 样式框架
- **JavaScript (ES6+)** - 交互逻辑
- **Supabase** - 后端认证服务

## 浏览器兼容性

- Chrome (推荐)
- Firefox
- Safari
- Edge

## 后续开发

当前版本包含完整的前端框架和认证功能。后续可以添加：

- [ ] 论坛帖子发布功能
- [ ] 帖子评论系统
- [ ] 用户个人资料页面
- [ ] 搜索功能
- [ ] 点赞和收藏功能
- [ ] 消息通知系统
- [ ] 用户头像上传
- [ ] 帖子分页加载

## 常见问题

### Q: 如何修改网站名称？
A: 编辑 `index.html` 中的 `<title>` 标签和导航栏中的 `MY SANDA` 文本。

### Q: 如何修改颜色主题？
A: 编辑 `css/style.css` 中的渐变色值：
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

### Q: 如何添加新的分类？
A: 在 `index.html` 中的分类按钮区域添加新按钮：
```html
<button class="category-btn px-6 py-3 rounded-lg bg-white text-gray-800 font-medium text-sm md:text-base" data-category="new-category">新分类</button>
```

### Q: 密码重置不工作？
A: 确保已在 Supabase 中禁用邮箱验证，并且 API 密钥配置正确。

## 许可证

MIT License

## 支持

如有问题或建议，请提交 Issue 或 Pull Request。

---

**最后更新**: 2026年3月13日
