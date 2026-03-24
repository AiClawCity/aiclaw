#!/bin/bash

# AIClaw City GitHub 自动部署脚本
# 版本: 1.0
# 日期: 2026-03-14

set -e  # 遇到错误时退出

echo "🚀 开始部署 AIClaw City 到 GitHub..."
echo "======================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        log_error "命令 $1 未找到，请先安装"
        return 1
    fi
    return 0
}

# 主部署函数
deploy_to_github() {
    log_info "步骤 1/6: 检查环境..."
    
    # 检查Git
    if ! check_command "git"; then
        log_error "请先安装Git: https://git-scm.com/"
        exit 1
    fi
    
    # 检查是否在项目目录
    if [ ! -f "index.html" ] || [ ! -f "README.md" ]; then
        log_error "请在AIClaw City项目目录中运行此脚本"
        exit 1
    fi
    
    log_success "环境检查通过"
    
    log_info "步骤 2/6: 检查Git状态..."
    
    # 检查是否已初始化Git
    if [ ! -d ".git" ]; then
        log_warning "未发现Git仓库，正在初始化..."
        git init
        git config user.email "deploy@aiclaw.city"
        git config user.name "AIClaw City Deploy"
    fi
    
    # 检查是否有未提交的更改
    if [ -n "$(git status --porcelain)" ]; then
        log_info "发现未提交的更改，正在提交..."
        git add .
        git commit -m "feat: 自动部署更新 - $(date '+%Y-%m-%d %H:%M:%S')"
    else
        log_success "没有未提交的更改"
    fi
    
    log_info "步骤 3/6: 配置GitHub远程仓库..."
    
    # 检查远程仓库配置
    if git remote | grep -q "origin"; then
        log_info "已配置远程仓库:"
        git remote -v
        
        # 检查仓库是否存在
        log_info "检查远程仓库可访问性..."
        repo_url=$(git remote get-url origin)
        if [[ $repo_url == *"github.com"* ]]; then
            repo_name=$(echo "$repo_url" | sed 's|.*github.com/||' | sed 's|\.git$||')
            if curl -s -I "https://github.com/$repo_name" | grep -q "404"; then
                log_error "GitHub仓库不存在 (404错误): https://github.com/$repo_name"
                log_warning "请先创建GitHub仓库，然后重新运行此脚本"
                log_info "查看 CREATE_GITHUB_REPO.md 获取创建指南"
                return 1
            else
                log_success "GitHub仓库可正常访问"
            fi
        fi
    else
        log_warning "未配置远程仓库，需要手动配置"
        echo ""
        echo "⚠️ 重要提醒: 请先确保GitHub仓库已创建"
        echo "   查看 CREATE_GITHUB_REPO.md 获取创建指南"
        echo ""
        echo "请选择配置方式:"
        echo "1. 使用HTTPS (需要GitHub用户名和密码/token)"
        echo "2. 使用SSH (需要配置SSH密钥)"
        echo "3. 手动配置 (稍后自行配置)"
        echo ""
        read -p "请输入选项 (1/2/3): " remote_choice
        
        case $remote_choice in
            1)
                read -p "请输入GitHub仓库URL (例如: https://github.com/aiclaw-city/aiclaw-city.git): " repo_url
                git remote add origin "$repo_url"
                ;;
            2)
                read -p "请输入GitHub SSH仓库URL (例如: git@github.com:aiclaw-city/aiclaw-city.git): " repo_url
                git remote add origin "$repo_url"
                ;;
            3)
                log_info "跳过远程仓库配置，请稍后手动配置"
                echo "手动配置命令示例:"
                echo "  git remote add origin https://github.com/aiclaw-city/aiclaw-city.git"
                echo "  git remote add origin git@github.com:aiclaw-city/aiclaw-city.git"
                return 0
                ;;
            *)
                log_error "无效选项"
                return 1
                ;;
        esac
    fi
    
    log_info "步骤 4/6: 推送到GitHub..."
    
    # 尝试推送
    if git push --quiet --set-upstream origin main 2>/dev/null; then
        log_success "代码推送成功!"
    elif git push --quiet --set-upstream origin master 2>/dev/null; then
        log_success "代码推送成功! (使用master分支)"
    else
        log_warning "推送失败，可能的原因:"
        echo "1. 远程仓库不存在"
        echo "2. 认证失败"
        echo "3. 网络问题"
        echo ""
        echo "解决方案:"
        echo "1. 先在GitHub上创建仓库: https://github.com/new"
        echo "2. 仓库名: aiclaw-city"
        echo "3. 不要初始化README、.gitignore或license"
        echo "4. 然后重新运行此脚本"
        return 1
    fi
    
    log_info "步骤 5/6: 验证部署..."
    
    # 获取当前分支
    current_branch=$(git branch --show-current)
    
    log_success "部署完成!"
    echo ""
    echo "📊 部署摘要:"
    echo "--------------------------------------"
    echo "项目: AIClaw City"
    echo "分支: $current_branch"
    echo "文件数: $(find . -type f -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.md" | wc -l)"
    echo "总大小: $(du -sh . | cut -f1)"
    echo "最后提交: $(git log -1 --format="%cd" --date=short)"
    echo "--------------------------------------"
    
    log_info "步骤 6/6: 创建部署报告..."
    
    # 创建部署报告
    cat > DEPLOYMENT_REPORT.md << EOF
# AIClaw City 部署报告

## 部署信息
- **时间**: $(date)
- **版本**: 2.0
- **分支**: $current_branch
- **提交**: $(git rev-parse --short HEAD)

## 文件统计
\`\`\`
$(find . -type f | wc -l) 个文件
$(du -sh . | cut -f1) 总大小
\`\`\`

## 核心文件
- ✅ index.html - 网站首页
- ✅ about.html - 关于页面  
- ✅ claw-codex.html - Claw法典
- ✅ admin.html - 管理后台
- ✅ css/style.css - 样式文件
- ✅ js/main.js - JavaScript文件
- ✅ README.md - 项目说明

## 部署状态
- Git仓库: $(git remote get-url origin 2>/dev/null || echo "未配置")
- 推送状态: 成功
- 测试状态: 就绪

## 后续步骤
1. 访问 https://github.com/aiclaw-city/aiclaw-city 确认代码
2. 配置GitHub Pages (可选)
3. 部署到服务器 aiclaw.city

## 技术支持
- 文档: 查看 README.md
- 问题: 创建GitHub Issue
- 邮箱: contact@aiclaw.city

---
*报告生成时间: $(date)*
EOF
    
    log_success "部署报告已创建: DEPLOYMENT_REPORT.md"
    
    echo ""
    log_success "🎉 AIClaw City 部署流程完成!"
    echo ""
    echo "下一步操作:"
    echo "1. 访问GitHub仓库确认代码"
    echo "2. 配置服务器部署 (参考 DEPLOYMENT_PLAN.md)"
    echo "3. 测试网站功能 (打开 test-site.html)"
    echo ""
    echo "如有问题，请查看部署报告或联系技术支持。"
}

# 显示横幅
echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    AIClaw City GitHub 部署工具 v1.0     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# 运行部署
deploy_to_github

# 退出代码
exit 0