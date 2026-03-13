@echo off
REM MY SANDA 校园论坛 - 本地开发服务器启动脚本

echo.
echo ========================================
echo   MY SANDA - 校园论坛
echo   本地开发服务器
echo ========================================
echo.

REM 检查 Python 是否安装
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] 检测到 Python，启动服务器...
    echo.
    echo 服务器地址: http://localhost:8000
    echo 按 Ctrl+C 停止服务器
    echo.
    python -m http.server 8000
) else (
    REM 检查 Node.js 是否安装
    node --version >nul 2>&1
    if %errorlevel% equ 0 (
        echo [✓] 检测到 Node.js，启动服务器...
        echo.
        echo 服务器地址: http://localhost:8080
        echo 按 Ctrl+C 停止服务器
        echo.
        npx http-server -p 8080
    ) else (
        echo [✗] 未检测到 Python 或 Node.js
        echo.
        echo 请安装以下任一工具：
        echo 1. Python: https://www.python.org/downloads/
        echo 2. Node.js: https://nodejs.org/
        echo.
        pause
    )
)
