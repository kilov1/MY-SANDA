# 上传 mysanda 项目到 GitHub 的几种方法

如果你在 GitHub 网页上传时出现浏览器报错（如 "Refused to get unsafe header"），可以用以下方式代替：

---

## 方法一：安装 Git 后用命令行上传（推荐）

### 1. 安装 Git

1. 打开 https://git-scm.com/download/win  
2. 下载并安装，一路默认即可  
3. 安装后**重启终端**或重启 Cursor

### 2. 在项目文件夹执行

打开 PowerShell 或 CMD，执行（把 `你的用户名` 换成你的 GitHub 用户名）：

```bash
cd d:\mysanda

# 初始化 Git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "首次提交 mysanda 项目"

# 添加远程仓库（在 GitHub 网页先创建一个空仓库，复制地址替换下面）
git remote add origin https://github.com/你的用户名/mysanda.git

# 上传
git push -u origin main
```

如果分支是 `master` 不是 `main`，把最后一行的 `main` 改成 `master`。

---

## 方法二：使用 GitHub Desktop（图形界面）

1. 下载安装：https://desktop.github.com/
2. 登录 GitHub 账号
3. 菜单 **File** → **Add local repository**，选择 `d:\mysanda`
4. 若提示「不是 Git 仓库」，点 **create a repository** 创建
5. 写提交说明，点 **Commit to main**
6. 点 **Publish repository** 上传到 GitHub

---

## 方法三：浏览器上传（针对报错的临时办法）

1. **换个浏览器**：如 Chrome、Edge、Firefox 轮流试
2. **使用无痕模式**：避免扩展干扰
3. **少量多次**：不要一次上传太多文件，分成多次上传
4. **压缩后上传**：将整个 `mysanda` 文件夹打成 zip，上传后在 GitHub 中解压（GitHub 支持 zip 上传）

---

## 关于「Refused to get unsafe header」错误

- 这是 GitHub 网页或浏览器扩展的问题，不是你的项目代码问题
- 一般不影响实际使用，可尝试刷新页面后再试
- 推荐用 **方法一** 或 **方法二** 上传，更稳定，也不依赖网页上传
