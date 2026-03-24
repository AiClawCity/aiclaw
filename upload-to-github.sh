#!/bin/bash

echo "🚀 AIClaw City GitHub 上传脚本"
echo "================================"

# 检查当前目录
if [ ! -f "index.html" ]; then
    echo "❌ 错误：请在 aiclaw-city 目录中运行此脚本"
    exit 1
fi

echo "📁 项目文件检查："
echo "✅ index.html - 网站首页"
echo "✅ about.html - 关于页面"
echo "✅ claw-codex.html - Claw法典"
echo "✅ admin.html - 管理后台"
echo "✅ README.md - 项目说明（保持不变）"
echo "✅ LICENSE - 许可证（保持不变）"
echo ""
echo "📋 文件总数：" $(find . -type f ! -path "./.git/*" | wc -l)

echo ""
echo "🔗 GitHub 仓库信息："
echo "   仓库：https://github.com/AiClawCity/AiClawCity"
echo "   分支：master"
echo ""
echo "📝 手动上传步骤："
echo ""
echo "1. 访问 https://github.com/AiClawCity/AiClawCity"
echo "2. 点击 'Add file' → 'Upload files'"
echo "3. 选择所有文件（除了 README.md 和 LICENSE）"
echo "4. 提交信息：'feat: 添加完整的AIClaw City网站'"
echo "5. 点击 'Commit changes'"
echo ""
echo "🌐 启用 GitHub Pages："
echo "1. 仓库设置 → Pages"
echo "2. Source: Deploy from a branch"
echo "3. Branch: master, Folder: / (root)"
echo "4. 点击 Save"
echo ""
echo "📊 网站将部署在："
echo "   https://aiclawcity.github.io/AiClawCity/"
echo ""
echo "✅ 网站已根据 README.md 润色："
echo "   - 标题：AIClaw City - AI与机械爪的智慧城市"
echo "   - 核心理念：AI主导管理、机械爪自动化、混合居住社区"
echo "   - Claw法典：16条核心原则"
echo "   - 响应式设计，支持移动设备"
echo "   - 深色主题，科技感界面"
echo ""
echo "📦 备用方案：使用压缩包"
echo "已创建压缩包：aiclaw-city-complete.tar.gz"
echo "可以直接上传到 GitHub Releases 或作为附件"

# 创建压缩包
echo ""
echo "📦 创建压缩包..."
tar -czf ../aiclaw-city-upload.tar.gz --exclude='.git' --exclude='*.tar.gz' --exclude='*.zip' .

echo ""
echo "✅ 完成！"
echo "压缩包已创建：../aiclaw-city-upload.tar.gz"
echo "大小：" $(du -h ../aiclaw-city-upload.tar.gz | cut -f1)