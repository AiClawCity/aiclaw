# GitHub 部署指南

## 📦 项目文件清单

以下是 AIClaw City 项目的完整文件清单：

### 核心网站文件
- `index.html` - 网站首页（已根据 README.md 润色）
- `about.html` - 关于我们页面
- `claw-codex.html` - Claw法典页面
- `admin.html` - 管理后台页面
- `css/style.css` - 主样式文件
- `js/main.js` - JavaScript 文件

### 项目文档
- `README.md` - 项目说明（**保持不变**）
- `LICENSE` - 许可证文件（**保持不变**）
- `PROJECT_PLAN.md` - 项目计划
- `DEPLOYMENT_PLAN.md` - 部署计划
- `AICLAW_PRINCIPLES.md` - AIClaw 原则

### 部署工具
- `deploy-to-github.sh` - 自动部署脚本
- `push-to-github.sh` - GitHub 推送脚本
- `check-links.sh` - 链接检查脚本
- `start.sh` - 本地启动脚本

### 其他文件
- `.gitignore` - Git 忽略文件
- `config.json` - 配置文件
- `preview.html` - 预览页面
- `test-site.html` - 测试页面
- `website-validation.html` - 网站验证页面

## 🚀 部署到 GitHub 的三种方法

### 方法一：使用 GitHub 网页界面（最简单）
1. 访问 https://github.com/AiClawCity/AiClawCity
2. 点击 "Add file" → "Upload files"
3. 将 `aiclaw-city` 目录中的所有文件拖拽上传
4. **重要**：不要上传 `README.md` 和 `LICENSE`（仓库中已存在）
5. 提交更改

### 方法二：使用 Git 命令行
```bash
# 1. 克隆仓库
git clone https://github.com/AiClawCity/AiClawCity.git

# 2. 进入仓库目录
cd AiClawCity

# 3. 备份原有的 README.md 和 LICENSE
cp README.md README.md.backup
cp LICENSE LICENSE.backup

# 4. 删除所有现有文件（除了 .git 目录）
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name 'README.md' ! -name 'LICENSE' -exec rm -rf {} \;

# 5. 复制 AIClaw City 文件
cp -r ../aiclaw-city/* .

# 6. 恢复原有的 README.md 和 LICENSE
mv README.md.backup README.md
mv LICENSE.backup LICENSE

# 7. 提交更改
git add .
git commit -m "feat: 添加完整的AIClaw City网站"

# 8. 推送到GitHub
git push origin master
```

### 方法三：使用 GitHub Desktop
1. 下载 GitHub Desktop：https://desktop.github.com/
2. 克隆仓库：`https://github.com/AiClawCity/AiClawCity.git`
3. 将 `aiclaw-city` 目录中的所有文件复制到仓库目录
4. **注意**：不要覆盖 README.md 和 LICENSE
5. 使用 GitHub Desktop 提交并推送

## 🌐 启用 GitHub Pages

推送完成后，启用 GitHub Pages：
1. 进入仓库设置 → Pages
2. 在 "Source" 部分选择 "Deploy from a branch"
3. 选择 "master" 分支和 "/ (root)" 文件夹
4. 点击 "Save"
5. 等待几分钟，网站将在 `https://aiclawcity.github.io/AiClawCity/` 上线

## 🔧 网站润色说明

网站已经根据 README.md 进行了润色：

### 一致性检查
- ✅ 网站标题：AIClaw City - AI与机械爪的智慧城市
- ✅ 核心理念：AI主导管理、机械爪自动化、混合居住社区
- ✅ 功能特性：实时数据更新、交互式界面、主题系统
- ✅ Claw法典：16条核心原则
- ✅ 项目结构：与 README.md 描述一致

### 增强功能
- 响应式设计，支持移动设备
- 深色主题，科技感界面
- 实时数据展示
- 交互式导航
- 动画效果增强用户体验

## 📊 验证检查

在推送前，请验证：
1. ✅ README.md 和 LICENSE 保持不变
2. ✅ 所有链接正常工作
3. ✅ 网站功能完整
4. ✅ 代码格式规范
5. ✅ 文件结构清晰

## 🆘 故障排除

### 问题：推送失败
**解决方案**：
1. 检查网络连接
2. 确保有仓库的写入权限
3. 尝试使用不同的 Git 客户端

### 问题：文件冲突
**解决方案**：
1. 先备份原有的 README.md 和 LICENSE
2. 删除冲突文件后重新上传
3. 使用 `git pull --rebase` 解决冲突

### 问题：GitHub Pages 不更新
**解决方案**：
1. 等待 1-5 分钟缓存更新
2. 清除浏览器缓存
3. 检查 GitHub Actions 状态

## 📞 支持

如有问题，请参考：
- GitHub 文档：https://docs.github.com
- Git 教程：https://git-scm.com/doc
- 项目 README.md 文件

---

**最后更新**：2026-03-16  
**版本**：2.0  
**状态**：就绪部署