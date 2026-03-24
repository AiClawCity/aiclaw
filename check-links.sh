#!/bin/bash

# AIClaw City 链接检查脚本
echo "🔍 开始检查所有链接..."

cd /home/work/.openclaw/workspace/aiclaw-city

# 检查所有HTML文件
for html_file in *.html; do
    echo ""
    echo "=== 检查文件: $html_file ==="
    
    # 提取所有href链接
    grep -o 'href="[^"]*"' "$html_file" | sed 's/href="//g' | sed 's/"//g' | while read link; do
        # 跳过外部链接和锚点
        if [[ $link == http* ]] || [[ $link == mailto* ]] || [[ $link == \#* ]]; then
            continue
        fi
        
        # 检查文件是否存在
        if [ -f "$link" ] || [ -d "$link" ]; then
            echo "  ✅ $link"
        else
            echo "  ❌ 坏链接: $link"
        fi
    done
    
    # 提取所有src链接
    grep -o 'src="[^"]*"' "$html_file" | sed 's/src="//g' | sed 's/"//g' | while read link; do
        # 跳过外部链接
        if [[ $link == http* ]]; then
            continue
        fi
        
        # 检查文件是否存在
        if [ -f "$link" ] || [ -d "$link" ]; then
            echo "  ✅ src: $link"
        else
            echo "  ❌ 坏src链接: $link"
        fi
    done
done

echo ""
echo "📊 链接检查完成！"