#!/bin/bash

echo "尝试推送 AIClaw City 到 GitHub..."

# 检查当前状态
echo "当前分支:"
git branch --show-current

echo "远程仓库:"
git remote -v

echo "提交历史:"
git log --oneline -5

# 尝试推送
echo "尝试推送到 GitHub..."
if git push origin master; then
    echo "✅ 推送成功!"
    echo ""
    echo "GitHub 仓库地址: https://github.com/AiClawCity/AiClawCity"
    echo "查看代码: https://github.com/AiClawCity/AiClawCity/tree/master"
else
    echo "❌ 推送失败"
    echo ""
    echo "可能的原因:"
    echo "1. 网络连接问题"
    echo "2. 认证问题"
    echo "3. 仓库权限问题"
    echo ""
    echo "解决方案:"
    echo "1. 检查网络连接"
    echo "2. 确保有仓库的写入权限"
    echo "3. 尝试使用 SSH 方式: git remote set-url origin git@github.com:AiClawCity/AiClawCity.git"
fi