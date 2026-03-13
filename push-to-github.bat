@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ========================================
echo    MY SANDA 上传到 GitHub
echo ========================================
echo.

where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Git，请先安装：
    echo https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

cd /d "%~dp0"

if not exist ".git" (
    echo 首次使用，正在初始化 Git...
    git init
    git branch -M main
    echo.
    if not exist "GITHUB_REPO.txt" (
        echo 请在 GitHub 创建一个空仓库，然后编辑本目录下的 GITHUB_REPO.txt
        echo 填入仓库地址，例如：https://github.com/你的用户名/mysanda.git
        echo.
        echo GITHUB_REPO.txt 已创建，请编辑后重新运行本脚本。
        echo https://github.com/new  ^> 创建新仓库
        echo.
        (
            echo 请将下面的地址替换为你的 GitHub 仓库地址
            echo 例如：https://github.com/你的用户名/mysanda.git
            echo.
            echo REPO_URL=
        ) > GITHUB_REPO.txt
        notepad GITHUB_REPO.txt
        pause
        exit /b 0
    )
    for /f "usebackq tokens=2* delims==" %%a in ('findstr "REPO_URL=" GITHUB_REPO.txt') do set "REPO=%%a%%b"
    set "REPO=!REPO: =!"
    if "!REPO!"=="" (
        echo [错误] 请在 GITHUB_REPO.txt 中设置 REPO_URL=你的仓库地址
        pause
        exit /b 1
    )
    echo 添加远程仓库: !REPO!
    git remote add origin "!REPO!"
)

git add .
git status
echo.
set /p MSG="输入本次提交说明 (直接回车使用默认): "
if "%MSG%"=="" set MSG=更新项目
git commit -m "%MSG%"
if %errorlevel% neq 0 (
    echo 没有新改动，或提交失败。
    echo 若需强制推送，可运行: git push -u origin main --force
) else (
    git push -u origin main
    if %errorlevel% equ 0 (
        echo.
        echo [成功] 已上传到 GitHub！
    ) else (
        echo.
        echo 如果是首次推送且仓库非空，可先执行：
        echo   git pull origin main --allow-unrelated-histories
        echo   git push -u origin main
    )
)
echo.
pause
