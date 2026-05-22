@echo off
chcp 65001 >nul
SETLOCAL

SET "PATH=%~dp0PortableGit\bin;%~dp0PortableGit\cmd;%PATH%"
SET "HOME=%~dp0userdata"
if not exist "%HOME%" mkdir "%HOME%"

:: --- 安全保障：自动创建 .gitignore 如果它不存在 ---
if not exist ".gitignore" (
    echo /PortableGit/ >> .gitignore
    echo /userdata/ >> .gitignore
    echo sync.bat >> .gitignore
    echo 🛡️ 已自动创建 .gitignore 以保护密钥安全
)

echo 🔍 正在同步根目录仓库...

:: 1. 添加更改，但排除 userdata 和 PortableGit
git add .

:: 2. 提交
set "commit_msg=Auto-sync: %date% %time%"
git diff --cached --quiet || (
    git commit -m "%commit_msg%"
)

:: 3. 拉取并推送
echo ⬇️ 正在拉取...
git pull --rebase origin main

echo ⬆️ 正在推送...
git push origin main

echo =======================================
echo ✨ 同步完成！