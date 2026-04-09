#!/bin/bash
# 使用Token推送脚本
# 安全提示: 此脚本使用本地存储的Token，不要提交到版本控制

set -e

# 加载本地Token
if [ -f .github-token.local ]; then
    source .github-token.local
else
    echo "错误: 未找到Token配置文件 .github-token.local"
    echo "请先运行: ./github-token-config.sh -t YOUR_TOKEN"
    exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "错误: Token未配置"
    exit 1
fi

# 检查是否在Git仓库中
if [ ! -d .git ]; then
    echo "错误: 当前目录不是Git仓库"
    exit 1
fi

# 获取远程仓库URL
remote_url=$(git remote get-url origin 2>/dev/null || echo "")

if [ -z "$remote_url" ]; then
    echo "错误: 未配置远程仓库"
    echo "请先配置: git remote add origin https://github.com/用户名/仓库名.git"
    exit 1
fi

# 将HTTPS URL转换为带Token的URL
if [[ "$remote_url" == https://github.com/* ]]; then
    # 移除https://前缀
    repo_path=${remote_url#https://}
    
    # 构建带Token的URL
    token_url="https://${GITHUB_TOKEN}@${repo_path}"
    
    echo "使用Token推送到: ${repo_path%%:*}"
    
    # 推送
    git push "$token_url" main 2>&1 | grep -v "$GITHUB_TOKEN"
    
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        echo "✅ 推送成功!"
    else
        echo "❌ 推送失败"
        exit 1
    fi
else
    echo "错误: 只支持HTTPS远程仓库"
    echo "当前远程仓库: $remote_url"
    exit 1
fi
