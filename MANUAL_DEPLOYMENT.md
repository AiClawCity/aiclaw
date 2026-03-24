# 手动部署说明

由于网络连接问题，我无法直接推送到 GitHub。以下是你可以手动操作的步骤：

## 步骤 1：下载项目文件

我已经为你准备好了完整的项目文件压缩包：
- `aiclaw-city-latest.tar.gz` - 包含所有项目文件

## 步骤 2：访问 GitHub 仓库

1. 打开浏览器，访问：https://github.com/AiClawCity/AiClawCity
2. 确保你已登录并拥有仓库的写入权限

## 步骤 3：上传文件到 GitHub

### 选项 A：使用网页上传（推荐）
1. 在仓库页面，点击 "Add file" → "Upload files"
2. 将 `aiclaw-city` 目录中的所有文件拖拽到上传区域
3. **重要**：不要上传 `README.md` 和 `LICENSE`（跳过这两个文件）
4. 在提交信息中输入："feat: 添加完整的AIClaw City网站"
5. 点击 "Commit changes"

### 选项 B：使用 Git 命令行
如果你有 Git 环境，可以运行以下命令：

```bash
# 1. 解压文件
tar -xzf aiclaw-city-latest.tar.gz

# 2. 进入目录
cd aiclaw-city

# 3. 克隆仓库
git clone https://github.com/AiClawCity/AiClawCity.git

# 4. 进入仓库目录
cd AiClawCity

# 5. 备份原有的 README.md 和 LICENSE
cp README.md README.md.backup
cp LICENSE LICENSE.backup

# 6. 删除所有现有文件（除了 .git 目录）
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name 'README.md' ! -name 'LICENSE' -exec rm -rf {} \;

# 7. 复制 AIClaw City 文件
cp -r ../* .

# 8. 恢复原有的 README.md 和 LICENSE
mv README.md.backup README.md
mv LICENSE.backup LICENSE

# 9. 提交更改
git add .
git commit -m "feat: 添加完整的AIClaw City网站"

# 10. 推送到GitHub
git push origin master
```

## 步骤 4：启用 GitHub Pages

1. 进入仓库设置 → Pages
2. 在 "Source" 部分选择 "Deploy from a branch"
3. 选择 "master" 分支和 "/ (root)" 文件夹
4. 点击 "Save"
5. 等待部署完成

## 步骤 5：验证部署

1. 访问：https://aiclawcity.github.io/AiClawCity/
2. 检查网站是否正常显示
3. 测试所有页面功能

## 网站润色说明

我已经根据 README.md 对网站进行了润色：

1. **一致性**：网站内容与 README.md 描述完全一致
2. **增强功能**：
   - 响应式设计，支持移动设备
   - 深色主题，科技感界面
   - 实时数据展示面板
   - 交互式导航菜单
   - 动画效果增强用户体验
3. **Claw法典**：完整展示16条核心原则
4. **管理后台**：模拟AI管理界面

## 文件清单

需要上传的文件（不包括 README.md 和 LICENSE）：
- `index.html` - 网站首页
- `about.html` - 关于页面
- `claw-codex.html` - Claw法典
- `admin.html` - 管理后台
- `css/` - 样式目录
- `js/` - JavaScript目录
- 所有 `.md` 文档文件
- 所有 `.sh` 脚本文件

## 遇到问题？

1. **权限问题**：确保你有仓库的写入权限
2. **文件冲突**：先备份原有的 README.md 和 LICENSE
3. **部署失败**：检查 GitHub Actions 日志
4. **网站不显示**：等待 GitHub Pages 缓存更新（1-5分钟）

---

**项目状态**：就绪部署  
**最后更新**：2026-03-16  
**版本**：2.0