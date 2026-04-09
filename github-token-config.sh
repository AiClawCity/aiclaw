#!/bin/bash
# GitHub Token 配置脚本
# 用于安全管理和更新GitHub访问令牌

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# 显示帮助
show_help() {
    echo "GitHub Token 配置工具"
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -t, --token TOKEN     设置GitHub Token"
    echo "  -c, --check           检查当前Token有效性"
    echo "  -u, --update          更新Token并测试"
    echo "  -h, --help            显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 -t ghp_xxxxxxxxxxxxx  # 设置新Token"
    echo "  $0 -c                    # 检查Token有效性"
    echo "  $0 -u                    # 交互式更新Token"
    echo ""
}

# 检查Token有效性
check_token() {
    local token="$1"
    
    if [ -z "$token" ]; then
        log_error "未提供Token"
        return 1
    fi
    
    log_info "检查Token有效性..."
    
    response=$(curl -s -H "Authorization: token $token" https://api.github.com/user)
    
    if echo "$response" | grep -q '"login"'; then
        username=$(echo "$response" | grep '"login"' | cut -d'"' -f4)
        log_success "Token有效！用户: $username"
        return 0
    else
        log_error "Token无效或已过期"
        echo "响应: $response"
        return 1
    fi
}

# 设置Token
set_token() {
    local token="$1"
    
    if [ -z "$token" ]; then
        log_error "未提供Token"
        return 1
    fi
    
    # 检查Token格式
    if [[ ! "$token" =~ ^ghp_[a-zA-Z0-9]{36,}$ ]]; then
        log_warning "Token格式可能不正确 (应以ghp_开头，长度至少40字符)"
        read -p "是否继续? (y/N): " confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            log_info "操作取消"
            return 1
        fi
    fi
    
    # 检查Token有效性
    if ! check_token "$token"; then
        log_error "Token无效，请检查后重试"
        return 1
    fi
    
    # 保存Token到安全位置（不提交到版本控制）
    echo "GITHUB_TOKEN=\"$token\"" > .github-token.local
    chmod 600 .github-token.local
    
    log_success "Token已保存到 .github-token.local"
    log_info "注意: 此文件已添加到.gitignore，不会提交到版本控制"
    
    # 创建推送脚本
    create_push_script "$token"
    
    return 0
}

# 创建推送脚本
create_push_script() {
    local token="$1"
    
    cat > push-with-token.sh << 'EOF'
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
EOF
    
    chmod +x push-with-token.sh
    
    log_success "已创建推送脚本: push-with-token.sh"
    log_info "使用方法: ./push-with-token.sh"
}

# 交互式更新Token
update_token_interactive() {
    echo "🔐 GitHub Token 更新工具"
    echo "========================"
    echo ""
    
    # 检查当前Token
    if [ -f .github-token.local ]; then
        source .github-token.local 2>/dev/null
        if [ -n "$GITHUB_TOKEN" ]; then
            echo "当前Token: ${GITHUB_TOKEN:0:10}...${GITHUB_TOKEN: -4}"
            if check_token "$GITHUB_TOKEN"; then
                echo "✅ 当前Token有效"
            else
                echo "⚠️  当前Token无效或已过期"
            fi
        fi
    else
        echo "未找到Token配置"
    fi
    
    echo ""
    read -p "请输入新Token (以ghp_开头): " new_token
    
    if [ -z "$new_token" ]; then
        log_error "未输入Token"
        return 1
    fi
    
    set_token "$new_token"
}

# 主函数
main() {
    case "$1" in
        -t|--token)
            set_token "$2"
            ;;
        -c|--check)
            if [ -f .github-token.local ]; then
                source .github-token.local 2>/dev/null
                check_token "$GITHUB_TOKEN"
            else
                log_error "未找到Token配置文件"
            fi
            ;;
        -u|--update)
            update_token_interactive
            ;;
        -h|--help)
            show_help
            ;;
        *)
            show_help
            ;;
    esac
}

# 运行主函数
main "$@"

# 安全提示
echo ""
log_warning "安全提示:"
echo "1. Token文件 (.github-token.local) 已添加到.gitignore"
echo "2. 不要将Token提交到版本控制"
echo "3. 定期更新Token以确保安全"
echo "4. 如果Token泄露，立即在GitHub上撤销"