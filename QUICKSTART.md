# 快速开始指南

## 5分钟快速上手 MY SANDA

### 第一步：配置 Supabase（2分钟）

1. **访问 Supabase**
   - 打开 https://supabase.com
   - 点击 "Sign Up" 注册账户

2. **创建项目**
   - 点击 "New Project"
   - 填写项目名称（如 "my-sanda"）
   - 设置数据库密码
   - 选择地区（推荐选择离你最近的）
   - 点击 "Create new project"

3. **获取 API 密钥**
   - 等待项目创建完成
   - 进入项目 → Settings → API
   - 复制 "Project URL"（看起来像 `https://xxxxx.supabase.co`）
   - 复制 "anon public" 密钥

4. **关闭邮箱验证**
   - 进入 Authentication → Providers
   - 找到 "Email" 提供商
   - 关闭 "Confirm email" 开关
   - 点击 "Save"

### 第二步：配置项目（1分钟）

1. **打开 `js/app.js`**
   - 找到第 1-2 行：
   ```javascript
   const SUPABASE_URL = 'https://your-project.supabase.co';
   const SUPABASE_KEY = 'your-anon-key';
   ```

2. **替换为你的值**
   ```javascript
   const SUPABASE_URL = 'https://xxxxx.supabase.co';  // 替换为你的 Project URL
   const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';  // 替换为你的 anon key
   ```

3. **保存文件**

### 第三步：启动服务器（2分钟）

#### 方式 A：使用 Python（推荐）
```bash
# 在项目目录打开命令行，运行：
python -m http.server 8000

# 然后在浏览器打开：
http://localhost:8000
```

#### 方式 B：使用 Node.js
```bash
# 安装依赖（第一次运行）
npm install

# 启动服务器
npm start

# 浏览器会自动打开 http://localhost:8000
```

#### 方式 C：Windows 用户
```bash
# 双击运行 start-server.bat 文件
```

### 完成！🎉

现在你可以：
- ✅ 访问首页
- ✅ 注册新账户
- ✅ 登录
- ✅ 测试忘记密码功能
- ✅ 查看密码强度反馈

## 测试账户

你可以创建测试账户来体验所有功能：

1. 点击 "注册" 按钮
2. 填写邮箱、昵称、密码
3. 观察密码强度条的变化
4. 完成注册
5. 使用邮箱和密码登录

## 常见问题

### Q: 页面显示空白？
A: 检查浏览器控制台（F12）是否有错误。确保 Supabase URL 和 Key 配置正确。

### Q: 注册时提示错误？
A: 
- 确保邮箱格式正确
- 确保密码强度不是"弱"
- 检查 Supabase 中是否已关闭邮箱验证

### Q: 登录失败？
A: 
- 确认邮箱和密码正确
- 确认账户已成功注册
- 检查 Supabase 连接是否正常

### Q: 忘记密码功能不工作？
A: 
- 确保已在 Supabase 中关闭邮箱验证
- 确保输入的邮箱是注册时使用的邮箱

## 下一步

项目框架已完成，你可以：

1. **自定义样式**
   - 编辑 `css/style.css` 修改颜色和字体
   - 编辑 `index.html` 中的 Tailwind 类名

2. **修改文案**
   - 编辑首页欢迎文字
   - 修改分类名称
   - 更新论坛介绍

3. **添加功能**
   - 发布帖子功能
   - 评论系统
   - 用户个人资料
   - 搜索功能

## 需要帮助？

- 查看 README.md 了解详细文档
- 检查浏览器控制台错误信息
- 访问 Supabase 文档：https://supabase.com/docs

祝你使用愉快！🚀
