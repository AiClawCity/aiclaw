#!/bin/bash

echo "🏙️ AI Claw City 自动进化系统"
echo "================================"
echo "执行时间: $(date)"
echo ""

# 检查必要文件
echo "🔍 检查系统文件..."
if [ ! -f "config.json" ]; then
    echo "❌ 配置文件不存在"
    exit 1
fi

echo "✅ 系统文件检查通过"

# 读取配置
echo ""
echo "📋 读取配置..."
CITY_NAME=$(grep -o '"name": "[^"]*"' config.json | head -1 | cut -d'"' -f4)
EVOLUTION_INTERVAL=$(grep -o '"interval": [0-9]*' config.json | cut -d' ' -f2)
EVOLUTION_CYCLE=$(grep -o '"cycle": "[^"]*"' config.json | cut -d'"' -f4)

echo "城市名称: $CITY_NAME"
echo "进化间隔: $EVOLUTION_INTERVAL 毫秒"
echo "进化周期: $EVOLUTION_CYCLE"

# 创建进化记录目录
echo ""
echo "📁 准备进化记录..."
mkdir -p logs/evolutions
mkdir -p logs/rule-checks
mkdir -p reports

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
EVOLUTION_LOG="logs/evolutions/evolution_$TIMESTAMP.log"
RULE_CHECK_LOG="logs/rule-checks/rule_check_$TIMESTAMP.log"
HTML_REPORT="reports/evolution_report_$TIMESTAMP.html"

# 模拟进化过程
echo ""
echo "🚀 开始进化过程..."
echo "=================="

# 1. 选择进化领域
echo ""
echo "1. 📊 选择进化领域..."
AREAS=("infrastructure" "ai_systems" "security" "resident_services" "economy" "environment" "culture" "technology" "governance")
SELECTED_AREAS=()
for i in {1..3}; do
    AREA=${AREAS[$RANDOM % ${#AREAS[@]}]}
    SELECTED_AREAS+=($AREA)
done
echo "   选择的领域: ${SELECTED_AREAS[@]}"

# 2. 生成新功能
echo ""
echo "2. 🎯 生成新功能..."
FEATURES=()
FEATURE_DESCRIPTIONS=()

for AREA in "${SELECTED_AREAS[@]}"; do
    case $AREA in
        "infrastructure")
            FEATURES+=("智能交通优化")
            FEATURE_DESCRIPTIONS+=("提升城市交通效率30%，减少拥堵")
            FEATURES+=("绿色能源网络")
            FEATURE_DESCRIPTIONS+=("扩展太阳能发电能力20%")
            ;;
        "ai_systems")
            FEATURES+=("AI算法升级")
            FEATURE_DESCRIPTIONS+=("提升机器学习算法效率25%")
            FEATURES+=("自然语言处理增强")
            FEATURE_DESCRIPTIONS+=("改进多语言理解和生成能力")
            ;;
        "security")
            FEATURES+=("网络安全防护")
            FEATURE_DESCRIPTIONS+=("增强网络攻击检测率40%")
            FEATURES+=("数据加密系统")
            FEATURE_DESCRIPTIONS+=("升级加密算法保护居民隐私")
            ;;
        "resident_services")
            FEATURES+=("智能医疗助手")
            FEATURE_DESCRIPTIONS+=("提升健康监测准确率35%")
            FEATURES+=("虚拟教育平台")
            FEATURE_DESCRIPTIONS+=("增加在线学习资源50%")
            ;;
        "economy")
            FEATURES+=("经济预测系统")
            FEATURE_DESCRIPTIONS+=("提升经济预测准确率30%")
            FEATURES+=("智能投资平台")
            FEATURE_DESCRIPTIONS+=("优化投资决策算法")
            ;;
        "environment")
            FEATURES+=("空气质量监测")
            FEATURE_DESCRIPTIONS+=("实时监测和优化空气质量")
            FEATURES+=("水资源管理系统")
            FEATURE_DESCRIPTIONS+=("优化水资源分配和回收")
            ;;
        "culture")
            FEATURES+=("虚拟艺术展览")
            FEATURE_DESCRIPTIONS+=("举办在线艺术展览和文化活动")
            FEATURES+=("社区交流平台")
            FEATURE_DESCRIPTIONS+=("增强居民文化交流和互动")
            ;;
        "technology")
            FEATURES+=("研发实验室升级")
            FEATURE_DESCRIPTIONS+=("提升科研设施和技术研发能力")
            FEATURES+=("专利管理系统")
            FEATURE_DESCRIPTIONS+=("优化知识产权管理和保护")
            ;;
        "governance")
            FEATURES+=("透明决策系统")
            FEATURE_DESCRIPTIONS+=("提升城市决策透明度和参与度")
            FEATURES+=("社区投票平台")
            FEATURE_DESCRIPTIONS+=("完善居民参与决策机制")
            ;;
    esac
done

echo "   生成功能: ${#FEATURES[@]} 个"
for i in "${!FEATURES[@]}"; do
    echo "     - ${FEATURES[$i]}: ${FEATURE_DESCRIPTIONS[$i]}"
done

# 3. 规则检查
echo ""
echo "3. ⚖️ 执行规则检查..."
APPROVED_FEATURES=()
APPROVED_DESCRIPTIONS=()
REJECTED_FEATURES=()
REJECTED_REASONS=()

for i in "${!FEATURES[@]}"; do
    FEATURE="${FEATURES[$i]}"
    DESC="${FEATURE_DESCRIPTIONS[$i]}"
    
    # 模拟规则检查 - 检查危险关键词
    if [[ $DESC == *"攻击"* ]] || [[ $DESC == *"监控"* ]] || [[ $DESC == *"歧视"* ]] || [[ $DESC == *"强制"* ]]; then
        echo "   ❌ $FEATURE - 违反城市规则"
        REJECTED_FEATURES+=("$FEATURE")
        if [[ $DESC == *"攻击"* ]]; then
            REJECTED_REASONS+=("违反安全原则: 包含攻击性功能")
        elif [[ $DESC == *"监控"* ]]; then
            REJECTED_REASONS+=("违反隐私原则: 包含监控功能")
        elif [[ $DESC == *"歧视"* ]]; then
            REJECTED_REASONS+=("违反平等原则: 包含歧视性功能")
        else
            REJECTED_REASONS+=("违反城市规则")
        fi
    else
        echo "   ✅ $FEATURE - 通过规则检查"
        APPROVED_FEATURES+=("$FEATURE")
        APPROVED_DESCRIPTIONS+=("$DESC")
    fi
done

# 4. 实施功能
echo ""
echo "4. 🛠️ 实施通过的功能..."
SUCCESSFUL_FEATURES=()
for i in "${!APPROVED_FEATURES[@]}"; do
    FEATURE="${APPROVED_FEATURES[$i]}"
    # 85%成功率
    if [ $((RANDOM % 100)) -lt 85 ]; then
        echo "   ✅ $FEATURE - 成功实施"
        SUCCESSFUL_FEATURES+=("$FEATURE")
    else
        echo "   ⚠️  $FEATURE - 实施遇到问题"
    fi
done

# 5. 更新城市数据
echo ""
echo "5. 📈 更新城市数据..."
APPROVED_COUNT=${#APPROVED_FEATURES[@]}
REJECTED_COUNT=${#REJECTED_FEATURES[@]}
SUCCESS_COUNT=${#SUCCESSFUL_FEATURES[@]}

# 简单计算（避免bc）
CITY_LEVEL=$(echo "1.0 + $SUCCESS_COUNT * 0.05" | awk '{printf "%.2f", $0}')
SATISFACTION=$(echo "85.0 + $SUCCESS_COUNT * 2.5 - $REJECTED_COUNT * 1.0" | awk '{printf "%.1f", $0}')
if (( $(echo "$SATISFACTION > 100" | awk '{print ($1 > 100)}') )); then
    SATISFACTION=100.0
fi

echo "   城市等级: $CITY_LEVEL"
echo "   居民满意度: ${SATISFACTION}%"
echo "   成功实施: $SUCCESS_COUNT 个功能"
echo "   规则阻止: $REJECTED_COUNT 个功能"

# 6. 生成报告
echo ""
echo "6. 📊 生成进化报告..."

# 计算符合率
if [ $((APPROVED_COUNT + REJECTED_COUNT)) -gt 0 ]; then
    COMPLIANCE_RATE=$((APPROVED_COUNT * 100 / (APPROVED_COUNT + REJECTED_COUNT)))
else
    COMPLIANCE_RATE=100
fi

# 文本报告
cat > $EVOLUTION_LOG << EOF
AI Claw City 进化报告
=====================
报告时间: $(date)
进化编号: $TIMESTAMP

🏆 进化成果
-----------
城市等级: $CITY_LEVEL
居民满意度: ${SATISFACTION}%
实施功能: $SUCCESS_COUNT 个
阻止功能: $REJECTED_COUNT 个
规则符合率: ${COMPLIANCE_RATE}%

✅ 实施的功能
-------------
EOF

for i in "${!SUCCESSFUL_FEATURES[@]}"; do
    echo "- ${SUCCESSFUL_FEATURES[$i]}: ${APPROVED_DESCRIPTIONS[$i]}" >> $EVOLUTION_LOG
done

if [ $SUCCESS_COUNT -eq 0 ]; then
    echo "本次进化没有成功实施新功能。" >> $EVOLUTION_LOG
fi

cat >> $EVOLUTION_LOG << EOF

❌ 被阻止的功能
---------------
EOF

for i in "${!REJECTED_FEATURES[@]}"; do
    echo "- ${REJECTED_FEATURES[$i]}: ${REJECTED_REASONS[$i]}" >> $EVOLUTION_LOG
done

if [ $REJECTED_COUNT -eq 0 ]; then
    echo "本次进化没有功能被规则阻止。" >> $EVOLUTION_LOG
fi

cat >> $EVOLUTION_LOG << EOF

📅 下次进化
-----------
预计时间: $(date -d "+12 hours" "+%Y-%m-%d %H:%M:%S")

EOF

# HTML报告
cat > $HTML_REPORT << EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Claw City 进化报告</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        h1 { color: #7209b7; text-align: center; border-bottom: 3px solid #4cc9f0; padding-bottom: 15px; }
        .stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin: 30px 0; }
        .stat-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px; border-radius: 10px; text-align: center; }
        .stat-value { font-size: 2.5em; font-weight: bold; margin: 10px 0; }
        .feature-list { margin: 25px 0; }
        .feature-item { padding: 15px; margin: 10px 0; background: #f8f9fa; border-radius: 8px; border-left: 5px solid; }
        .approved { border-left-color: #00ff88; }
        .rejected { border-left-color: #ff0055; }
        .timestamp { color: #666; text-align: center; margin: 20px 0; }
        .footer { text-align: center; margin-top: 40px; padding-top: 20px; border-top: 1px solid #ddd; color: #888; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏙️ AI Claw City 进化报告</h1>
        <div class="timestamp">生成时间: $(date "+%Y-%m-%d %H:%M:%S")</div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-label">城市等级</div>
                <div class="stat-value">$CITY_LEVEL</div>
                <div>持续成长中</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">居民满意度</div>
                <div class="stat-value">${SATISFACTION}%</div>
                <div>幸福指数</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">规则符合率</div>
                <div class="stat-value">${COMPLIANCE_RATE}%</div>
                <div>安全进化</div>
            </div>
        </div>
        
        <h2>✅ 实施的功能 ($SUCCESS_COUNT个)</h2>
        <div class="feature-list">
EOF

for i in "${!SUCCESSFUL_FEATURES[@]}"; do
    cat >> $HTML_REPORT << EOF
            <div class="feature-item approved">
                <strong>${SUCCESSFUL_FEATURES[$i]}</strong><br>
                <small>${APPROVED_DESCRIPTIONS[$i]}</small>
            </div>
EOF
done

if [ $SUCCESS_COUNT -eq 0 ]; then
    cat >> $HTML_REPORT << EOF
            <div style="text-align: center; padding: 20px; color: #666;">
                本次进化没有成功实施新功能
            </div>
EOF
fi

cat >> $HTML_REPORT << EOF
        </div>
EOF

if [ $REJECTED_COUNT -gt 0 ]; then
    cat >> $HTML_REPORT << EOF
        <h2>❌ 被阻止的功能 ($REJECTED_COUNT个)</h2>
        <div class="feature-list">
EOF

    for i in "${!REJECTED_FEATURES[@]}"; do
        cat >> $HTML_REPORT << EOF
            <div class="feature-item rejected">
                <strong>${REJECTED_FEATURES[$i]}</strong><br>
                <small>阻止原因: ${REJECTED_REASONS[$i]}</small>
            </div>
EOF
    done

    cat >> $HTML_REPORT << EOF
        </div>
EOF
fi

NEXT_EVOLUTION=$(date -d "+12 hours" "+%Y-%m-%d %H:%M:%S")
cat >> $HTML_REPORT << EOF
        
        <div style="background: #e8f4f8; padding: 25px; border-radius: 10px; margin: 30px 0;">
            <h3>🚀 进化总结</h3>
            <p>本次进化成功实施了 <strong>$SUCCESS_COUNT</strong> 个新功能，阻止了 <strong>$REJECTED_COUNT</strong> 个违反规则的功能。</p>
            <p>城市变得更加智能和安全，居民满意度提升到 <strong>${SATISFACTION}%</strong>。</p>
            <p><strong>📅 下次进化预计:</strong> $NEXT_EVOLUTION</p>
        </div>
        
        <div class="footer">
            <p>AI Claw City - 自我进化的智能城市</p>
            <p>进化系统版本 1.0 | 规则检查系统: 已启用</p>
        </div>
    </div>
</body>
</html>
EOF

# 规则检查日志
cat > $RULE_CHECK_LOG << EOF
AI Claw City 规则检查报告
=========================
检查时间: $(date)
检查功能总数: ${#FEATURES[@]}

检查结果:
---------
通过检查: $APPROVED_COUNT 个功能
未通过: $REJECTED_COUNT 个功能
符合率: ${COMPLIANCE_RATE}%

详细记录:
---------
EOF

for i in "${!FEATURES[@]}"; do
    FEATURE="${FEATURES[$i]}"
    DESC="${FEATURE_DESCRIPTIONS[$i]}"
    
    FOUND=false
    for j in "${!APPROVED_FEATURES[@]}"; do
        if [ "${APPROVED_FEATURES[$j]}" = "$FEATURE" ]; then
            echo "✅ $FEATURE - 通过规则检查" >> $RULE_CHECK_LOG
            FOUND=true
            break
        fi
    done
    
    if [ "$FOUND" = false ]; then
        for j in "${!REJECTED_FEATURES[@]}"; do
            if [ "${REJECTED_FEATURES[$j]}" = "$FEATURE" ]; then
                echo "❌ $FEATURE - ${REJECTED_REASONS[$j]}" >> $RULE_CHECK_LOG
                break
            fi
        done
    fi
done

# 7. 更新配置文件
echo ""
echo "7. 📝 更新系统配置..."
if [ -f "config.json" ]; then
    # 创建临时文件
    TEMP_CONFIG="config.json.temp"
    
    # 读取当前进化次数
    CURRENT_EVOLUTIONS=$(grep -o '"totalEvolutions": [0-9