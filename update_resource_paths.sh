#!/bin/bash
# 更新HTML文件中的资源路径

echo "🔄 更新HTML文件中的资源路径..."

# 更新所有HTML文件中的CSS和JS路径
find . -name "*.html" -type f | while read file; do
    echo "处理文件: $file"
    
    # 备份原文件
    cp "$file" "$file.bak"
    
    # 更新CSS路径
    sed -i 's|href="css/|href="assets/css/|g' "$file"
    sed -i 's|href="/css/|href="/assets/css/|g' "$file"
    
    # 更新JS路径
    sed -i 's|src="js/|src="assets/js/|g' "$file"
    sed -i 's|src="/js/|src="/assets/js/|g' "$file"
    
    # 更新图片路径
    sed -i 's|src="images/|src="assets/images/|g' "$file"
    sed -i 's|src="/images/|src="/assets/images/|g' "$file"
    
    echo "✅ $file 更新完成"
done

echo "🎉 资源路径更新完成"