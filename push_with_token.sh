#!/bin/bash

# 尝试使用不同的推送方法

echo "方法1: 使用 HTTPS 和 Git 凭据助手"
git config --global credential.helper store
echo "https://github.com:AiClawCity/AiClawCity.git" > ~/.git-credentials
echo "请确保您有 GitHub 访问令牌"

echo "方法2: 使用 GitHub CLI"
if command -v gh &> /dev/null; then
    echo "GitHub CLI 已安装"
    gh auth status || echo "需要登录 GitHub CLI"
else
    echo "GitHub CLI 未安装"
fi

echo "方法3: 手动推送说明"
echo "1. 访问 https://github.com/AiClawCity/AiClawCity"
echo "2. 点击 'Add file' → 'Upload files'"
echo "3. 上传以下文件:"
echo "   - index.html"
echo "   - about.html"
echo "   - claw-codex.html"
echo "   - admin.html"
echo "   - css/style.css"
echo "   - js/main.js"
echo "   - 其他项目文档"
echo "4. 不要覆盖 README.md 和 LICENSE"
echo "5. 提交更改"

echo "当前目录内容:"
ls -la