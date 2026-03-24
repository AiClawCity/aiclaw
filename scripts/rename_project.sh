#!/bin/bash
# AI Cloud City 项目重命名脚本

echo "🚀 开始重命名项目: AIClaw City -> AI Cloud City"

# 统计需要处理的文件
echo "📊 统计需要处理的文件..."
FILES_TO_UPDATE=$(find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec grep -l -i "aiclaw" {} \; 2>/dev/null | wc -l)
echo "发现 $FILES_TO_UPDATE 个文件需要更新"

# 执行替换操作
echo "🔄 执行替换操作..."

# 1. 替换 AIClaw City -> AI Cloud City
echo "1. 替换 AIClaw City -> AI Cloud City"
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec sed -i 's/AIClaw City/AI Cloud City/gi' {} \; 2>/dev/null

# 2. 替换 AiClaw City -> AI Cloud City
echo "2. 替换 AiClaw City -> AI Cloud City"
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec sed -i 's/AiClaw City/AI Cloud City/gi' {} \; 2>/dev/null

# 3. 替换 AIClaw -> AI Cloud
echo "3. 替换 AIClaw -> AI Cloud"
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec sed -i 's/AIClaw/AI Cloud/gi' {} \; 2>/dev/null

# 4. 替换 AiClaw -> AI Cloud
echo "4. 替换 AiClaw -> AI Cloud"
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec sed -i 's/AiClaw/AI Cloud/gi' {} \; 2>/dev/null

# 5. 替换 aiclaw-city -> ai-cloud-city
echo "5. 替换 aiclaw-city -> ai-cloud-city"
find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec sed -i 's/aiclaw-city/ai-cloud-city/gi' {} \; 2>/dev/null

# 验证替换结果
echo "✅ 替换完成"
echo "📊 验证替换结果..."
UPDATED_FILES=$(find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec grep -l -i "aiclaw" {} \; 2>/dev/null | wc -l)
REMAINING_FILES=$(find . -type f \( -name "*.md" -o -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.json" -o -name "*.txt" \) -exec grep -l -i "aiclaw" {} \; 2>/dev/null 2>/dev/null)

echo "剩余 $UPDATED_FILES 个文件仍包含旧名称"
if [ $UPDATED_FILES -gt 0 ]; then
    echo "需要手动处理的文件:"
    echo "$REMAINING_FILES"
fi

echo "🎉 项目重命名脚本执行完成"