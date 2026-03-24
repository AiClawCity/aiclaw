#!/bin/bash

# AIClaw City 启动脚本
# 作者：AIClaw City 系统
# 版本：1.0

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

# 检查依赖
check_dependencies() {
    log_step "检查系统依赖..."
    
    # 检查Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node --version | cut -d'v' -f2)
        log_info "Node.js 版本: $NODE_VERSION"
    else
        log_error "未找到Node.js，请先安装Node.js"
        exit 1
    fi
    
    # 检查npm
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm --version)
        log_info "npm 版本: $NPM_VERSION"
    else
        log_error "未找到npm"
        exit 1
    fi
    
    # 检查Python3（可选）
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version)
        log_info "$PYTHON_VERSION"
    else
        log_warn "未找到Python3，部分功能可能受限"
    fi
    
    log_info "依赖检查完成"
}

# 显示横幅
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "================================================"
    echo "           AIClaw City 启动系统"
    echo "          AI与机械爪的智慧城市"
    echo "================================================"
    echo -e "${NC}"
    echo "版本: 1.0"
    echo "时间: $(date)"
    echo ""
}

# 显示菜单
show_menu() {
    echo -e "${BLUE}请选择操作：${NC}"
    echo "1. 启动城市网站"
    echo "2. 启动管理后台"
    echo "3. 启动自动升级系统"
    echo "4. 查看Claw法典"
    echo "5. 查看系统状态"
    echo "6. 一键启动所有服务"
    echo "7. 停止所有服务"
    echo "8. 退出"
    echo ""
    read -p "请输入选项 (1-8): " choice
}

# 启动城市网站
start_website() {
    log_step "启动城市网站..."
    
    # 检查是否已安装http-server
    if ! npm list -g http-server &> /dev/null; then
        log_warn "未找到http-server，正在安装..."
        npm install -g http-server
    fi
    
    # 启动HTTP服务器
    log_info "在 http://localhost:8080 启动网站..."
    http-server . -p 8080 -o -c-1 &
    WEB_PID=$!
    echo $WEB_PID > .web.pid
    
    log_info "城市网站已启动 (PID: $WEB_PID)"
    echo -e "${GREEN}请在浏览器中访问: http://localhost:8080${NC}"
}

# 启动管理后台
start_admin() {
    log_step "启动管理后台..."
    
    # 检查是否已安装http-server
    if ! npm list -g http-server &> /dev/null; then
        log_warn "未找到http-server，正在安装..."
        npm install -g http-server
    fi
    
    # 启动管理后台
    log_info "在 http://localhost:8081 启动管理后台..."
    http-server . -p 8081 -o -c-1 &
    ADMIN_PID=$!
    echo $ADMIN_PID > .admin.pid
    
    log_info "管理后台已启动 (PID: $ADMIN_PID)"
    echo -e "${GREEN}请在浏览器中访问: http://localhost:8081/admin.html${NC}"
}

# 启动自动升级系统
start_upgrade_system() {
    log_step "启动自动升级系统..."
    
    # 检查升级脚本
    if [ ! -f "upgrade-script.js" ]; then
        log_error "未找到升级脚本: upgrade-script.js"
        return 1
    fi
    
    # 创建升级日志目录
    mkdir -p logs/upgrades
    
    # 启动升级系统
    log_info "启动自动升级进程..."
    node upgrade-script.js > logs/upgrade.log 2>&1 &
    UPGRADE_PID=$!
    echo $UPGRADE_PID > .upgrade.pid
    
    log_info "自动升级系统已启动 (PID: $UPGRADE_PID)"
    log_info "升级日志: logs/upgrade.log"
    
    # 显示初始状态
    sleep 2
    if ps -p $UPGRADE_PID > /dev/null; then
        log_info "自动升级系统运行正常"
        echo -e "${YELLOW}系统将每小时自动升级一次${NC}"
    else
        log_error "自动升级系统启动失败"
        return 1
    fi
}

# 查看Claw法典
view_codex() {
    log_step "打开Claw法典..."
    
    if [ -f "claw-codex.html" ]; then
        # 尝试使用默认浏览器打开
        if command -v xdg-open &> /dev/null; then
            xdg-open "claw-codex.html" &
        elif command -v open &> /dev/null; then
            open "claw-codex.html" &
        else
            log_info "法典文件: claw-codex.html"
            log_warn "无法自动打开，请手动在浏览器中打开该文件"
        fi
    else
        log_error "未找到法典文件: claw-codex.html"
    fi
}

# 查看系统状态
show_status() {
    log_step "系统状态检查..."
    
    echo -e "${CYAN}=== AIClaw City 系统状态 ===${NC}"
    echo ""
    
    # 检查进程
    if [ -f ".web.pid" ] && ps -p $(cat .web.pid) > /dev/null 2>&1; then
        echo -e "城市网站: ${GREEN}运行中${NC} (PID: $(cat .web.pid))"
    else
        echo -e "城市网站: ${RED}未运行${NC}"
    fi
    
    if [ -f ".admin.pid" ] && ps -p $(cat .admin.pid) > /dev/null 2>&1; then
        echo -e "管理后台: ${GREEN}运行中${NC} (PID: $(cat .admin.pid))"
    else
        echo -e "管理后台: ${RED}未运行${NC}"
    fi
    
    if [ -f ".upgrade.pid" ] && ps -p $(cat .upgrade.pid) > /dev/null 2>&1; then
        echo -e "升级系统: ${GREEN}运行中${NC} (PID: $(cat .upgrade.pid))"
    else
        echo -e "升级系统: ${RED}未运行${NC}"
    fi
    
    echo ""
    
    # 检查文件
    echo -e "${CYAN}=== 文件状态 ===${NC}"
    [ -f "index.html" ] && echo -e "城市主页: ${GREEN}存在${NC}" || echo -e "城市主页: ${RED}缺失${NC}"
    [ -f "claw-codex.html" ] && echo -e "Claw法典: ${GREEN}存在${NC}" || echo -e "Claw法典: ${RED}缺失${NC}"
    [ -f "admin.html" ] && echo -e "管理后台: ${GREEN}存在${NC}" || echo -e "管理后台: ${RED}缺失${NC}"
    [ -f "upgrade-script.js" ] && echo -e "升级脚本: ${GREEN}存在${NC}" || echo -e "升级脚本: ${RED}缺失${NC}"
    
    echo ""
    
    # 显示日志文件
    if [ -d "logs" ]; then
        echo -e "${CYAN}=== 日志文件 ===${NC}"
        ls -la logs/ 2>/dev/null || echo "无日志文件"
    fi
    
    echo ""
}

# 停止所有服务
stop_services() {
    log_step "停止所有服务..."
    
    # 停止网站
    if [ -f ".web.pid" ]; then
        WEB_PID=$(cat .web.pid)
        if ps -p $WEB_PID > /dev/null 2>&1; then
            kill $WEB_PID 2>/dev/null
            log_info "已停止城市网站 (PID: $WEB_PID)"
        fi
        rm -f .web.pid
    fi
    
    # 停止管理后台
    if [ -f ".admin.pid" ]; then
        ADMIN_PID=$(cat .admin.pid)
        if ps -p $ADMIN_PID > /dev/null 2>&1; then
            kill $ADMIN_PID 2>/dev/null
            log_info "已停止管理后台 (PID: $ADMIN_PID)"
        fi
        rm -f .admin.pid
    fi
    
    # 停止升级系统
    if [ -f ".upgrade.pid" ]; then
        UPGRADE_PID=$(cat .upgrade.pid)
        if ps -p $UPGRADE_PID > /dev/null 2>&1; then
            kill $UPGRADE_PID 2>/dev/null
            log_info "已停止升级系统 (PID: $UPGRADE_PID)"
        fi
        rm -f .upgrade.pid
    fi
    
    log_info "所有服务已停止"
}

# 清理函数
cleanup() {
    log_step "执行清理..."
    stop_services
    log_info "清理完成"
}

# 主函数
main() {
    # 设置陷阱，确保脚本退出时清理
    trap cleanup EXIT INT TERM
    
    # 显示横幅
    show_banner
    
    # 检查依赖
    check_dependencies
    
    # 创建必要目录
    mkdir -p logs
    
    # 主循环
    while true; do
        show_menu
        
        case $choice in
            1)
                start_website
                ;;
            2)
                start_admin
                ;;
            3)
                start_upgrade_system
                ;;
            4)
                view_codex
                ;;
            5)
                show_status
                ;;
            6)
                log_step "一键启动所有服务..."
                start_website
                start_admin
                start_upgrade_system
                log_info "所有服务启动完成"
                ;;
            7)
                stop_services
                ;;
            8)
                log_step "退出系统..."
                cleanup
                exit 0
                ;;
            *)
                log_error "无效选项，请重新选择"
                ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
        echo ""
    done
}

# 运行主函数
main "$@"