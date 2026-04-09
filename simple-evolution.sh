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

if [ ! -f "scripts/city-evolution.js" ]; then
    echo "❌ 进化系统文件不存在"
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
for AREA in "${SELECTED_AREAS[@]}"; do
    case $AREA in
        "infrastructure")
            FEATURES+=("智能交通优化-提升交通效率30%")
            FEATURES+=("绿色能源网络-增加太阳能发电20%")
            ;;
        "ai_systems")
            FEATURES+=("AI算法升级-提升学习速度25%")
            FEATURES+=("自然语言处理-多语言支持增强")
            ;;
        "security")
            FEATURES+=("网络安全防护-攻击检测率提升40%")
            FEATURES+=("数据加密升级-保护居民隐私")
            ;;
        "resident_services")
            FEATURES+=("智能医疗助手-健康监测准确率提升35%")
            FEATURES+=("虚拟教育平台-学习资源增加50%")
            ;;
        *)
            FEATURES+=("$AREA 系统优化-性能提升20%")
            ;;
    esac
done
echo "   生成功能: ${#FEATURES[@]} 个"
for FEATURE in "${FEATURES[@]}"; do
    echo "     - $FEATURE"
done

# 3. 规则检查
echo ""
echo "3. ⚖️ 执行规则检查..."
APPROVED_FEATURES=()
REJECTED_FEATURES=()

for FEATURE in "${FEATURES[@]}"; do
    # 模拟规则检查
    if [[ $FEATURE == *"攻击"* ]] || [[ $FEATURE == *"监控"* ]] || [[ $FEATURE == *"歧视"* ]]; then
        echo "   ❌ $FEATURE - 违反城市规则"
        REJECTED_FEATURES+=("$FEATURE|违反安全/隐私/平等原则")
    else
        echo "   ✅ $FEATURE - 通过规则检查"
        APPROVED_FEATURES+=($FEATURE)
    fi
done

# 4. 实施功能
echo ""
echo "4. 🛠️ 实施通过的功能..."
for FEATURE in "${APPROVED_FEATURES[@]}"; do
    SUCCESS=$((RANDOM % 100))
    if [ $SUCCESS -lt 85 ]; then
        echo "   ✅ $FEATURE - 成功实施"
    else
        echo "   ⚠️  $FEATURE - 实施遇到问题"
    fi
done

# 5. 更新城市数据
echo ""
echo "5. 📈 更新城市数据..."
CITY_LEVEL=$(echo "scale=2; 1.0 + ${#APPROVED_FEATURES[@]} * 0.05" | bc)
SATISFACTION=$(echo "scale=1; 85.0 + ${#APPROVED_FEATURES[@]} * 2.5 - ${#REJECTED_FEATURES[@]} * 1.0" | bc)
if (( $(echo "$SATISFACTION > 100" | bc -l) )); then
    SATISFACTION=100.0
fi

echo "   城市等级: $CITY_LEVEL"
echo "   居民满意度: $SATISFACTION%"

# 6. 生成报告
echo ""
echo "6. 📊 生成进化报告..."

# 文本报告
cat > $EVOLUTION_LOG << EOF
AI Claw City 进化报告
=====================
报告时间: $(date)
进化编号: $(date +%Y%m%d-%H%M%S)

🏆 进化成果
-----------
城市等级: $CITY_LEVEL
居民满意度: ${SATISFACTION}%
实施功能: ${#APPROVED_FEATURES[@]} 个
阻止功能: ${#REJECTED_FEATURES[@]} 个
规则符合率: $(echo "scale=1; ${#APPROVED_FEATURES[@]} * 100 / (${#APPROVED_FEATURES[@]} + ${#REJECTED_FEATURES[@]})" | bc)%

✅ 实施的功能
-------------
$(for FEATURE in "${APPROVED_FEATURES[@]}"; do echo "- $FEATURE"; done)

❌ 被阻止的功能
---------------
$(for REJECTED in "${REJECTED_FEATURES[@]}"; do echo "- $REJECTED"; done)

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
                <div class="stat-value">$(echo "scale=0; ${#APPROVED_FEATURES[@]} * 100 / (${#APPROVED_FEATURES[@]} + ${#REJECTED_FEATURES[@]})" | bc)%</div>
                <div>安全进化</div>
            </div>
        </div>
        
        <h2>✅ 实施的功能 (${#APPROVED_FEATURES[@]}个)</h2>
        <div class="feature-list">
EOF

for FEATURE in "${APPROVED_FEATURES[@]}"; do
    cat >> $HTML_REPORT << EOF
            <div class="feature-item approved">
                <strong>$FEATURE</strong><br>
                <small>成功实施，提升城市功能</small>
            </div>
EOF
done

if [ ${#APPROVED_FEATURES[@]} -eq 0 ]; then
    cat >> $HTML_REPORT << EOF
            <div style="text-align: center; padding: 20px; color: #666;">
                本次进化没有实施新功能
            </div>
EOF
fi

cat >> $HTML_REPORT << EOF
        </div>
        
EOF

if [ ${#REJECTED_FEATURES[@]} -gt 0 ]; then
    cat >> $HTML_REPORT << EOF
        <h2>❌ 被阻止的功能 (${#REJECTED_FEATURES[@]}个)</h2>
        <div class="feature-list">
EOF

    for REJECTED in "${REJECTED_FEATURES[@]}"; do
        FEATURE=$(echo $REJECTED | cut -d'|' -f1)
        REASON=$(echo $REJECTED | cut -d'|' -f2)
        cat >> $HTML_REPORT << EOF
            <div class="feature-item rejected">
                <strong>$FEATURE</strong><br>
                <small>阻止原因: $REASON</small>
            </div>
EOF
    done

    cat >> $HTML_REPORT << EOF
        </div>
EOF
fi

cat >> $HTML_REPORT << EOF
        
        <div style="background: #e8f4f8; padding: 25px; border-radius: 10px; margin: 30px 0;">
            <h3>🚀 进化总结</h3>
            <p>本次进化成功实施了 <strong>${#APPROVED_FEATURES[@]}</strong> 个新功能，阻止了 <strong>${#REJECTED_FEATURES[@]}</strong> 个违反规则的功能。</p>
            <p>城市变得更加智能和安全，居民满意度提升到 <strong>${SATISFACTION}%</strong>。</p>
            <p><strong>📅 下次进化预计:</strong> $(date -d "+12 hours" "+%Y-%m-%d %H:%M:%S")</p>
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
通过检查: ${#APPROVED_FEATURES[@]} 个功能
未通过: ${#REJECTED_FEATURES[@]} 个功能
符合率: $(echo "scale=1; ${#APPROVED_FEATURES[@]} * 100 / ${#FEATURES[@]}" | bc)%

详细记录:
---------
EOF

for i in "${!FEATURES[@]}"; do
    FEATURE="${FEATURES[$i]}"
    if [[ " ${APPROVED_FEATURES[@]} " =~ " ${FEATURE} " ]]; then
        echo "✅ $FEATURE - 通过" >> $RULE_CHECK_LOG
    else
        for REJECTED in "${REJECTED_FEATURES[@]}"; do
            if [[ "$REJECTED" == "$FEATURE"* ]]; then
                REASON=$(echo $REJECTED | cut -d'|' -f2)
                echo "❌ $FEATURE - $REASON" >> $RULE_CHECK_LOG
                break
            fi
        done
    fi
done

# 更新配置文件
echo ""
echo "7. 📝 更新系统配置..."
if [ -f "config.json" ]; then
    # 备份原配置
    cp config.json config.json.backup
    
    # 更新进化次数
    CURRENT_EVOLUTIONS=$(grep -o '"totalEvolutions": [0-9]*' config.json 2>/dev/null | cut -d' ' -f2 || echo "0")
    NEW_EVOLUTIONS=$((CURRENT_EVOLUTIONS + 1))
    
    # 使用sed更新配置
    if grep -q '"totalEvolutions"' config.json; then
        sed -i "s/\"totalEvolutions\": [0-9]*/\"totalEvolutions\": $NEW_EVOLUTIONS/" config.json
    else
        # 在evolution对象中添加totalEvolutions
        sed -i '/"evolution": {/a\    "totalEvolutions": '$NEW_EVOLUTIONS',' config.json
    fi
    
    # 添加最后进化时间
    LAST_EVOLUTION=$(date -Iseconds)
    NEXT_EVOLUTION=$(date -d "+12 hours" -Iseconds)
    
    if grep -q '"lastEvolution"' config.json; then
        sed -i "s/\"lastEvolution\": \"[^\"]*\"/\"lastEvolution\": \"$LAST_EVOLUTION\"/" config.json
    else
        sed -i '/"totalEvolutions":/a\    "lastEvolution": "'$LAST_EVOLUTION'",' config.json
    fi
    
    if grep -q '"nextEvolution"' config.json; then
        sed -i "s/\"nextEvolution\": \"[^\"]*\"/\"nextEvolution\": \"$NEXT_EVOLUTION\"/" config.json
    else
        sed -i '/"lastEvolution":/a\    "nextEvolution": "'$NEXT_EVOLUTION'",' config.json
    fi
    
    echo "   配置更新完成"
    echo "   总进化次数: $NEW_EVOLUTIONS"
    echo "   最后进化: $LAST_EVOLUTION"
    echo "   下次进化: $NEXT_EVOLUTION"
fi

echo ""
echo "================================"
echo "🎉 进化完成！"
echo "================================"
echo "📋 进化日志: $EVOLUTION_LOG"
echo "⚖️  规则检查: $RULE_CHECK_LOG"
echo "📄 HTML报告: $HTML_REPORT"
echo ""
echo "🏙️ 城市等级: $CITY_LEVEL"
echo "😊 居民满意度: ${SATISFACTION}%"
echo "✅ 实施功能: ${#APPROVED_FEATURES[@]} 个"
echo "❌ 阻止功能: ${#REJECTED_FEATURES[@]} 个"
echo ""
echo "⏰ 下次进化: 12小时后"
echo "================================"