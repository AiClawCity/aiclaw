# AI Cloud City 快速部署指南

## 🚀 一键部署命令

复制以下命令到终端执行：

```bash
# 1. 进入项目目录
cd /path/to/AI Cloud-city

# 2. 设置Git配置（如果未设置）
git config user.email "deploy@AI Cloud.city"
git config user.name "AI Cloud City Deploy"

# 3. 初始化Git仓库（如果未初始化）
git init

# 4. 添加所有文件
git add .

# 5. 提交更改
git commit -m "feat: 部署AI Cloud City网站 v2.0"

# 6. 设置远程仓库（选择一种方式）

# 方式A: 使用HTTPS（需要GitHub用户名和密码/token）
git remote add origin https://github.com/AI Cloud-city/AI Cloud-city.git

# 方式B: 使用SSH（需要配置SSH密钥）
git remote add origin git@github.com:AI Cloud-city/AI Cloud-city.git

# 7. 推送到GitHub
git push -u origin main

# 如果main分支不存在，使用master
git push -u origin master
```

## 📋 手动部署步骤

### 第一步：在GitHub创建仓库
1. 访问 https://github.com/new
2. 输入仓库名: `AI Cloud-city`
3. 描述: "AI Cloud City - AI与机械爪的智慧城市"
4. 选择: Public（公开）
5. **不要**初始化README、.gitignore或license
6. 点击"Create repository"

### 第二步：推送代码
复制GitHub提供的命令：
```bash
git remote add origin https://github.com/你的用户名/AI Cloud-city.git
git branch -M main
git push -u origin main
```

### 第三步：验证部署
1. 访问 https://github.com/AI Cloud-city/AI Cloud-city
2. 确认所有文件已上传
3. 点击文件查看内容是否正确

## 🛠️ 故障排除

### 问题1: 认证失败
```bash
# 使用GitHub Token代替密码
git remote set-url origin https://你的token@github.com/AI Cloud-city/AI Cloud-city.git
```

### 问题2: 仓库不存在
```bash
# 先创建仓库，再推送
# 或者使用强制推送（谨慎）
git push -f origin main
```

### 问题3: 分支名称问题
```bash
# 重命名分支
git branch -M main
# 或者使用master分支
git push -u origin master
```

## 🔗 验证链接

部署成功后，可以访问：
- GitHub仓库: https://github.com/AI Cloud-city/AI Cloud-city
- 网站测试: 打开 `test-site.html`
- 部署报告: 查看 `DEPLOYMENT_REPORT.md`

## 📞 快速帮助

如果遇到问题，执行：
```bash
# 运行自动部署脚本
bash deploy-to-github.sh

# 或查看详细文档
cat GITHUB_DEPLOYMENT.md
```

## ✅ 部署检查清单

- [ ] GitHub仓库已创建
- [ ] 所有文件已提交
- [ ] 远程仓库已配置
- [ ] 代码已推送
- [ ] 仓库页面可访问
- [ ] 文件内容正确

---

**状态**: 🟢 就绪部署  
**时间**: 2026-03-14 16:45  
**版本**: 2.0  

只需5分钟即可完成部署！ 🚀