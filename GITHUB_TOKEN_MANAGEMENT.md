# GitHub Token 管理指南

## 📅 Token 更新记录

### 当前Token信息
- **Token:** `ghp_********...******` (已配置)
- **用户:** AiClawCity
- **设置时间:** 2026-04-09 09:18
- **设置者:** 白泽助手 ([听歌])
- **有效期:** 未知（建议定期检查）
- **状态:** ✅ 有效（已通过API验证）

### 历史Token
1. **`ghp_********...******`** (初始token)
   - 设置时间: 2026-04-08
   - 状态: ⚠️ 即将过期（约30天有效期）
   - 备注: 初始token，用于项目初始化

## 🔧 管理工具

### 1. Token配置脚本
```bash
# 设置新Token
./github-token-config.sh -t YOUR_NEW_TOKEN

# 检查当前Token有效性
./github-token-config.sh -c

# 交互式更新Token
./github-token-config.sh -u

# 显示帮助
./github-token-config.sh -h
```

### 2. 安全推送脚本
```bash
# 使用配置的Token推送
./push-with-token.sh
```

## 📁 文件说明

### 安全文件（不提交到版本控制）
- **`.github-token.local`** - Token配置文件（已添加到.gitignore）
  ```bash
  GITHUB_TOKEN="ghp_********...******"  # 实际Token存储在本地文件
  ```

### 工具文件（提交到版本控制）
- **`github-token-config.sh`** - Token管理工具
- **`push-with-token.sh`** - 安全推送脚本
- **`GITHUB_TOKEN_MANAGEMENT.md`** - 本管理文档

## 🔒 安全策略

### 1. Token存储
- ✅ 存储在本地文件 `.github-token.local`
- ✅ 已添加到 `.gitignore`，不会提交到版本控制
- ✅ 文件权限设置为 `600`（仅所有者可读写）

### 2. 使用安全
- ✅ 推送时自动隐藏Token输出
- ✅ 定期检查Token有效性
- ✅ 支持Token格式验证

### 3. 泄露处理
如果Token意外泄露：
1. **立即撤销Token：** 访问 GitHub → Settings → Developer settings → Personal access tokens
2. **生成新Token：** 创建新的Personal Access Token
3. **更新配置：** 运行 `./github-token-config.sh -t NEW_TOKEN`
4. **检查影响：** 验证所有使用该Token的服务

## 🚀 使用流程

### 日常推送
```bash
# 1. 提交更改
git add .
git commit -m "提交说明"

# 2. 使用安全脚本推送
./push-with-token.sh
```

### Token更新流程
```bash
# 1. 生成新Token（GitHub网站）
#    - 访问: https://github.com/settings/tokens
#    - 权限: repo (全选)
#    - 有效期: 建议90天

# 2. 更新本地配置
./github-token-config.sh -t ghp_xxxxxxxxxxxxx

# 3. 验证新Token
./github-token-config.sh -c

# 4. 测试推送
./push-with-token.sh
```

## 📊 Token权限要求

### 最小必要权限
- **repo** - 完全控制仓库
  - `public_repo` - 访问公共仓库
  - `repo:status` - 访问提交状态
  - `repo_deployment` - 访问部署状态
  - `public_repo` - 访问公共仓库
  - `repo:invite` - 邀请协作者

### 推荐权限
- **repo** (全选) - 完整仓库访问
- **workflow** - GitHub Actions（如需）

## ⏰ 维护计划

### 定期检查
- **每周:** 检查Token有效性 (`./github-token-config.sh -c`)
- **每月:** 检查Token剩余有效期
- **每季度:** 考虑更新Token（安全最佳实践）

### 过期处理
1. **提前30天:** 开始准备新Token
2. **提前7天:** 必须更新Token
3. **过期当天:** 撤销旧Token，确保使用新Token

## 🔍 故障排除

### 常见问题

#### 1. Token无效
```bash
# 症状: 推送失败，认证错误
# 解决:
./github-token-config.sh -c  # 检查有效性
./github-token-config.sh -u  # 更新Token
```

#### 2. 权限不足
```bash
# 症状: 某些操作被拒绝
# 解决:
# 1. 检查Token权限范围
# 2. 在GitHub上更新Token权限
# 3. 重新配置Token
```

#### 3. 推送被拒绝
```bash
# 症状: 推送时被GitHub阻止
# 解决:
# 1. 检查仓库是否存在
# 2. 检查是否有推送权限
# 3. 检查网络连接
```

## 🌐 GitHub API 集成

### 测试Token
```bash
# 使用curl测试（替换YOUR_TOKEN为实际Token）
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/user
```

### 获取仓库信息
```bash
# 获取仓库列表
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/user/repos
```

## 📝 最佳实践

### 1. Token生成
- 使用描述性名称，如 "AiClawCity-Deploy-2026-Q2"
- 设置合适的有效期（不超过90天）
- 仅授予必要的最小权限

### 2. 本地管理
- 不要硬编码Token到脚本中
- 使用环境变量或配置文件
- 定期轮换Token

### 3. 团队协作
- 每个成员使用自己的Token
- 不要共享Token
- 使用机器用户账户进行自动化

### 4. 监控审计
- 定期检查Token使用日志
- 监控异常访问
- 及时撤销未使用的Token

## 🆘 紧急响应

### Token泄露应急流程
1. **立即行动:**
   - 在GitHub上撤销泄露的Token
   - 通知相关团队成员
   - 检查是否有异常活动

2. **恢复操作:**
   - 生成新Token
   - 更新所有使用该Token的系统
   - 验证所有服务正常运行

3. **事后分析:**
   - 调查泄露原因
   - 加强安全措施
   - 更新安全策略

---

**最后更新:** 2026-04-09 09:18  
**维护者:** 白泽助手 ([听歌])  
**GitHub用户:** AiClawCity  

**重要提醒:** 定期更新Token是保障项目安全的重要措施！