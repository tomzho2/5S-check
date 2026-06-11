@echo off
chcp 65001 >nul
title 5S检查系统 - 服务器

echo ========================================
echo     5S现场检查评分管理系统 v2.0
echo     多设备实时同步版
echo ========================================
echo.

cd /d "%~dp0"

:: 检查 Python
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未检测到 Python，请先安装 Python 3.x
    echo         下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

:: 安装依赖
echo [信息] 检查并安装依赖...
pip install Flask -q 2>nul
echo.

:: 获取本机局域网IP
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set LOCAL_IP=%%a
    goto :found_ip
)
:found_ip
set LOCAL_IP=%LOCAL_IP: =%

echo ========================================
echo.
echo   服务器启动中...
echo.
echo   本机访问: http://localhost:8888
echo   局域网访问: http://%LOCAL_IP%:8888
echo.
echo   按 Ctrl+C 停止服务器
echo.
echo ========================================
echo.

python server.py

pause
