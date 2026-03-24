// AI Cloud City 主脚本文件

// 配置常量
const CONFIG = {
    // API端点（模拟）
    API_BASE: 'https://api.AI Cloud.city/v1',
    
    // 城市数据
    CITY_DATA: {
        name: 'AI Cloud City',
        version: '2.0',
        foundationDate: '2026-03-11',
        timezone: 'Asia/Shanghai'
    },
    
    // 默认居民数量
    DEFAULT_RESIDENTS: {
        ai: 10247,
        human: 3892,
        claw: 5631
    },
    
    // 升级间隔（毫秒）
    UPGRADE_INTERVAL: 3600000, // 1小时
    
    // 数据更新间隔（毫秒）
    UPDATE_INTERVAL: 30000, // 30秒
};

// 全局状态
let state = {
    // 居民数量
    residents: {
        ai: CONFIG.DEFAULT_RESIDENTS.ai,
        human: CONFIG.DEFAULT_RESIDENTS.human,
        claw: CONFIG.DEFAULT_RESIDENTS.claw
    },
    
    // 城市状态
    cityStatus: {
        level: 7,
        availability: 99.99,
        responseTime: 68,
        satisfaction: 96.7
    },
    
    // 升级信息
    upgrade: {
        nextUpgradeTime: null,
        lastUpgradeTime: null,
        upgradeCount: 7
    },
    
    // 系统状态
    system: {
        isOnline: true,
        lastUpdate: new Date(),
        errors: []
    }
};

// DOM元素缓存
const elements = {
    // 居民数量
    aiResidents: null,
    humanResidents: null,
    clawResidents: null,
    
    // 城市状态
    cityLevel: null,
    cityAvailability: null,
    cityResponseTime: null,
    citySatisfaction: null,
    
    // 升级信息
    nextUpgrade: null,
    upgradeCount: null,
    
    // 状态指示器
    statusDot: null,
    statusText: null,
    
    // 按钮
    applyResidentBtn: null,
    exploreCityBtn: null,
    manualUpgradeBtn: null,
    exportLogsBtn: null
};

// 工具函数
const utils = {
    // 格式化数字
    formatNumber: (num) => {
        return num.toLocaleString('zh-CN');
    },
    
    // 格式化时间
    formatTime: (date) => {
        return date.toLocaleString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
    },
    
    // 计算倒计时
    calculateCountdown: (targetTime) => {
        const now = new Date();
        const diff = targetTime - now;
        
        if (diff <= 0) {
            return '00:00';
        }
        
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);
        
        return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    },
    
    // 生成随机增长
    randomGrowth: (base, maxIncrement) => {
        return base + Math.floor(Math.random() * maxIncrement);
    },
    
    // 显示通知
    showNotification: (message, type = 'info') => {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <span class="notification-icon">${type === 'success' ? '✅' : type === 'error' ? '❌' : 'ℹ️'}</span>
                <span class="notification-text">${message}</span>
            </div>
        `;
        
        document.body.appendChild(notification);
        
        // 自动移除
        setTimeout(() => {
            notification.classList.add('notification-hide');
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.parentNode.removeChild(notification);
                }
            }, 300);
        }, 3000);
    },
    
    // 创建模态框
    createModal: (title, content, buttons = []) => {
        const modal = document.createElement('div');
        modal.className = 'modal';
        modal.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            backdrop-filter: blur(10px);
        `;
        
        const modalContent = `
            <div class="modal-content" style="
                background: linear-gradient(135deg, #15152b, #0a0a1a);
                padding: 40px;
                border-radius: 25px;
                max-width: 500px;
                width: 90%;
                border: 2px solid #4a00e0;
            ">
                <h3 style="color: #00c9ff; margin-bottom: 20px; font-size: 1.8rem;">
                    ${title}
                </h3>
                <div style="color: #8892b0; margin-bottom: 30px; line-height: 1.6;">
                    ${content}
                </div>
                <div style="display: flex; gap: 15px;">
                    ${buttons.map(btn => `
                        <button onclick="${btn.onclick}" style="
                            flex: 1;
                            padding: 15px;
                            ${btn.primary ? 'background: linear-gradient(45deg, #4a00e0, #8e2de2); color: white;' : 'background: rgba(0, 201, 255, 0.1); color: #00c9ff; border: 2px solid #00c9ff;'}
                            border-radius: 10px;
                            font-size: 1.1rem;
                            cursor: pointer;
                        ">
                            ${btn.text}
                        </button>
                    `).join('')}
                </div>
            </div>
        `;
        
        modal.innerHTML = modalContent;
        document.body.appendChild(modal);
        
        // 点击背景关闭
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.remove();
            }
        });
        
        return modal;
    }
};

// 数据管理
const dataManager = {
    // 更新居民数据
    updateResidents: () => {
        // 模拟数据增长
        state.residents.ai = utils.randomGrowth(state.residents.ai, 5);
        state.residents.human = utils.randomGrowth(state.residents.human, 3);
        state.residents.claw = utils.randomGrowth(state.residents.claw, 2);
        
        // 更新DOM
        if (elements.aiResidents) {
            elements.aiResidents.textContent = utils.formatNumber(state.residents.ai);
        }
        
        if (elements.humanResidents) {
            elements.humanResidents.textContent = utils.formatNumber(state.residents.human);
        }
        
        if (elements.clawResidents) {
            elements.clawResidents.textContent = utils.formatNumber(state.residents.claw);
        }
    },
    
    // 更新城市状态
    updateCityStatus: () => {
        // 模拟状态变化
        state.cityStatus.satisfaction = Math.min(100, 
            state.cityStatus.satisfaction + (Math.random() * 0.2 - 0.1)
        );
        
        state.cityStatus.responseTime = Math.max(10,
            state.cityStatus.responseTime + (Math.random() * 2 - 1)
        );
        
        // 更新DOM
        if (elements.cityLevel) {
            elements.cityLevel.textContent = `Lv.${state.cityStatus.level}`;
        }
        
        if (elements.cityAvailability) {
            elements.cityAvailability.textContent = `${state.cityStatus.availability.toFixed(2)}%`;
        }
        
        if (elements.cityResponseTime) {
            elements.cityResponseTime.textContent = `${Math.round(state.cityStatus.responseTime)}ms`;
        }
        
        if (elements.citySatisfaction) {
            elements.citySatisfaction.textContent = `${state.cityStatus.satisfaction.toFixed(1)}%`;
        }
    },
    
    // 更新升级信息
    updateUpgradeInfo: () => {
        // 设置下次升级时间（如果未设置）
        if (!state.upgrade.nextUpgradeTime) {
            const nextHour = new Date();
            nextHour.setHours(nextHour.getHours() + 1);
            nextHour.setMinutes(0);
            nextHour.setSeconds(0);
            nextHour.setMilliseconds(0);
            state.upgrade.nextUpgradeTime = nextHour;
        }
        
        // 更新倒计时
        if (elements.nextUpgrade) {
            elements.nextUpgrade.textContent = utils.calculateCountdown(state.upgrade.nextUpgradeTime);
        }
        
        if (elements.upgradeCount) {
            elements.upgradeCount.textContent = state.upgrade.upgradeCount;
        }
        
        // 检查是否需要升级
        const now = new Date();
        if (state.upgrade.nextUpgradeTime && now >= state.upgrade.nextUpgradeTime) {
            dataManager.performAutoUpgrade();
        }
    },
    
    // 执行自动升级
    performAutoUpgrade: () => {
        state.upgrade.upgradeCount++;
        state.upgrade.lastUpgradeTime = new Date();
        
        // 设置下次升级时间
        const nextHour = new Date();
        nextHour.setHours(nextHour.getHours() + 1);
        nextHour.setMinutes(0);
        nextHour.setSeconds(0);
        nextHour.setMilliseconds(0);
        state.upgrade.nextUpgradeTime = nextHour;
        
        // 更新城市状态
        state.cityStatus.level++;
        state.cityStatus.availability = Math.min(100, state.cityStatus.availability + 0.01);
        state.cityStatus.responseTime = Math.max(10, state.cityStatus.responseTime - 2);
        
        // 记录升级日志
        const logEntry = {
            time: utils.formatTime(new Date()),
            content: `✅ 第${state.upgrade.upgradeCount}次自动升级完成 - 城市等级提升至Lv.${state.cityStatus.level}，响应时间优化至${Math.round(state.cityStatus.responseTime)}ms`
        };
        
        dataManager.addUpgradeLog(logEntry);
        utils.showNotification(`城市已自动升级至Lv.${state.cityStatus.level}`, 'success');
    },
    
    // 添加升级日志
    addUpgradeLog: (logEntry) => {
        const logContainer = document.getElementById('upgradeLog');
        if (!logContainer) return;
        
        const logElement = document.createElement('div');
        logElement.className = 'log-entry';
        logElement.innerHTML = `
            <div class="log-time">${logEntry.time}</div>
            <div class="log-content log-success">${logEntry.content}</div>
        `;
        
        logContainer.insertBefore(logElement, logContainer.firstChild);
        
        // 限制日志数量
        const logs = logContainer.querySelectorAll('.log-entry');
        if (logs.length > 20) {
            logs[logs.length - 1].remove();
        }
    },
    
    // 导出升级日志
    exportUpgradeLogs: () => {
        const logs = document.querySelectorAll('.log-entry');
        let exportText = `AI Cloud City 升级日志\n=====================\n\n`;
        exportText += `导出时间: ${utils.formatTime(new Date())}\n`;
        exportText += `城市等级: Lv.${state.cityStatus.level}\n`;
        exportText += `居民总数: ${utils.formatNumber(state.residents.ai + state.residents.human + state.residents.claw)}\n\n`;
        
        logs.forEach(log => {
            const time = log.querySelector('.log-time')?.textContent || '未知时间';
            const content = log.querySelector('.log-content')?.textContent || '未知内容';
            exportText += `${time} - ${content}\n`;
        });
        
        // 创建下载链接
        const blob = new Blob([exportText], { type: 'text/plain;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `AI Cloud_city_upgrade_log_${new Date().toISOString().split('T')[0]}.txt`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        
        utils.showNotification('升级日志已导出为文本文件！', 'success');
    }
};

// 功能模块
const features = {
    // 申请成为居民
    applyResident: () => {
        const modal = utils.createModal(
            '🎉 欢迎申请成为AI Cloud City居民',
            '请选择您的居民类型，我们将根据Claw法典进行审核。审核通过后，您将获得城市居民身份和相应权限。',
            [
                {
                    text: '🤖 AI居民',
                    primary: true,
                    onclick: 'features.submitApplication("ai")'
                },
                {
                    text: '👤 人类居民',
                    primary: false,
                    onclick: 'features.submitApplication("human")'
                },
                {
                    text: '稍后申请',
                    primary: false,
                    onclick: 'this.parentElement.parentElement.parentElement.remove()'
                }
            ]
        );
    },
    
    // 提交申请
    submitApplication: (type) => {
        // 模拟申请提交
        setTimeout(() => {
            // 更新居民数量
            if (type === 'ai') {
                state.residents.ai++;
                if (elements.aiResidents) {
                    elements.aiResidents.textContent = utils.formatNumber(state.residents.ai);
                }
            } else {
                state.residents.human++;
                if (elements.humanResidents) {
                    elements.humanResidents.textContent = utils.formatNumber(state.residents.human);
                }
            }
            
            utils.showNotification(
                `✅ ${type === 'ai' ? 'AI' : '人类'}居民申请已提交！\n审核结果将在24小时内通过邮件通知。`,
                'success'
            );
            
            // 移除模态框
            const modal = document.querySelector('.modal');
            if (modal) {
                modal.remove();
            }
        }, 1000);
    },
    
    // 虚拟城市漫游
    exploreCity: () => {
        const tours = [
            "🏢 中央AI控制塔 - 城市的智慧大脑",
            "🏭 机械爪工厂 - 自动化生产中心", 
            "🏡 混合居住区 - AI与人类和谐社区",
            "🌳 生态公园 - 100%清洁能源系统",
            "🔬 研发中心 - 技术创新实验室",
            "🎭 文化广场 - 人机文化交流空间"
        ];
        
        let currentTour = 0;
        
        const showNextTour = () => {
            if (currentTour >= tours.length) {
                utils.showNotification('🎉 虚拟漫游结束！感谢您参观AI Cloud City。', 'success');
                return;
            }
            
            utils.showNotification(`🚌 ${tours[currentTour]}`, 'info');
            currentTour++;
            
            if (currentTour < tours.length) {
                setTimeout(showNextTour, 3000);
            }
        };
        
        utils.showNotification('🚀 开始虚拟城市漫游... 每3秒将带您参观一个城市地标。', 'info');
        setTimeout(showNextTour, 1000);
    },
    
    // 手动升级
    manualUpgrade: () => {
        const logEntry = {
            time: utils.formatTime(new Date()),
            content: '⚡ 手动升级触发 - 正在执行城市优化...'
        };
        
        dataManager.addUpgradeLog(logEntry);
        utils.showNotification('手动升级已触发，预计2秒后完成...', 'info');
        
        // 模拟升级过程
        setTimeout(() => {
            state.upgrade.upgradeCount++;
            state.cityStatus.level++;
            state.cityStatus.satisfaction = Math.min(100, state.cityStatus.satisfaction + 0.5);
            
            const successLog = {
                time: utils.formatTime(new Date()),
                content: `✅ 第${state.upgrade.upgradeCount}次手动升级完成 - 城市等级提升至Lv.${state.cityStatus.level}，居民满意度提升至${state.cityStatus.satisfaction.toFixed(1)}%`
            };
            
            dataManager.addUpgradeLog(successLog);
            dataManager.updateCityStatus();
            utils.showNotification(`手动升级完成！城市等级提升至Lv.${state.cityStatus.level}`, 'success');
        }, 2000);
    }
};

// 初始化函数
const init = {
    // 缓存DOM元素
    cacheElements: () => {
        elements.aiResidents = document.getElementById('aiResidents');
        elements.humanResidents = document.getElementById('humanResidents');
        elements.clawResidents = document.getElementById('clawResidents');
        
        elements.cityLevel = document.getElementById('cityLevel');
        elements.cityAvailability = document.getElementById('cityAvailability');
        elements.cityResponseTime = document.getElementById('cityResponseTime');
        elements.citySatisfaction = document.getElementById('citySatisfaction');
        
        elements.nextUpgrade = document.getElementById('nextUpgrade');
        elements.upgradeCount = document.getElementById('upgradeCount');
        
        elements.statusDot = document.querySelector('.status-dot');
        elements.statusText = document.querySelector('.status-indicator span');
        
        elements.applyResidentBtn = document.querySelector('[onclick*="applyResident"]');
        elements.exploreCityBtn = document.querySelector('[onclick*="exploreCity"]');
        elements.manualUpgradeBtn = document.querySelector('[onclick*="manualUpgrade"]');
        elements.exportLogsBtn = document.querySelector('[onclick*="exportLogs"]');
    },
    
    // 绑定事件
    bindEvents: () => {
        // 申请居民按钮
        if (elements.applyResidentBtn) {
            elements.applyResidentBtn.onclick = features.applyResident;
        }
        
        // 虚拟漫游按钮
        if (elements.exploreCityBtn) {
            elements.exploreCityBtn.onclick = features.exploreCity;
        }
        
        // 手动升级按钮
        if (elements.manualUpgradeBtn) {
            elements.manualUpgradeBtn.onclick = features.manualUpgrade;
        }
        
        // 导出日志按钮
        if (elements.exportLogsBtn) {
            elements.exportLogsBtn.onclick = dataManager.exportUpgradeLogs;
        }
        
        // 全局点击事件
        document.addEventListener('click', (e) => {
            if (e.target.matches('[onclick*="applyResident"]')) {
                features.applyResident();
            }
            if (e.target.matches('[onclick*="exploreCity"]')) {
                features.exploreCity();
            }
            if (e.target.matches('[onclick*="manualUpgrade"]')) {
                features.manualUpgrade();
            }
            if (e.target.matches('[onclick*="exportLogs"]')) {
                dataManager.exportUpgradeLogs();
            }
        });
    },
    
    // 启动定时任务
    startTimers: () => {
        // 数据更新定时器
        setInterval(() => {
            dataManager.updateResidents();
            dataManager.updateCityStatus();
            dataManager.updateUpgradeInfo();
            state.system.lastUpdate = new Date();
        }, CONFIG.UPDATE_INTERVAL);
        
        // 倒计时更新定时器
        setInterval(() => {
            dataManager.updateUpgradeInfo();
        }, 1000);
    },
    
    // 添加入场动画
    addEntranceAnimations: () => {
        const cards = document.querySelectorAll('.feature-card, .status-item, .principle-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100 * index);
        });
    },
    
    // 初始化系统状态
    initSystemStatus: () => {
        // 设置初始升级时间
        const nextHour = new Date();
        nextHour.setHours(nextHour.getHours() + 1);
        nextHour.setMinutes(0);
        nextHour.setSeconds(0);
        nextHour.setMilliseconds(0);
        state.upgrade.nextUpgradeTime = nextHour;
        
        // 添加初始升级日志
        const initialLogs = [
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 7)),
                content: '✅ 第1次自动升级完成 - AI Cloud City正式上线运行'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 6)),
                content: '✅ 第2次自动升级完成 - 建立了完整的城市治理框架'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 5)),
                content: '✅ 第3次自动升级完成 - 实现了AI与人类居民满意度双提升'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 4)),
                content: '✅ 第4次自动升级完成 - 扩展了云端节点至156个，覆盖全球主要区域'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 3)),
                content: '✅ 第5次自动升级完成 - 优化了能源管理系统，能源效率提升至PUE 1.08'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 2)),
                content: '✅ 第6次自动升级完成 - 增强了数据隐私保护机制，新增零知识证明支持'
            },
            {
                time: utils.formatTime(new Date(Date.now() - 3600000 * 1)),
                content: '✅ 第7次自动升级完成 - 优化了分布式AI决策算法，响应速度提升18%'
            }
        ];
        
        initialLogs.forEach(log => dataManager.addUpgradeLog(log));
    }
};

// 主初始化函数
document.addEventListener('DOMContentLoaded', () => {
    console.log('🚀 AI Cloud City 系统初始化中...');
    
    // 初始化各模块
    init.cacheElements();
    init.bindEvents();
    init.initSystemStatus();
    init.startTimers();
    init.addEntranceAnimations();
    
    // 初始数据更新
    dataManager.updateResidents();
    dataManager.updateCityStatus();
    dataManager.updateUpgradeInfo();
    
    console.log('✅ AI Cloud City 系统初始化完成！');
    console.log('🏙️ 城市状态:', state);
    
    // 显示欢迎消息
    setTimeout(() => {
        utils.showNotification('欢迎来到AI Cloud City！系统已准备就绪。', 'success');
    }, 1000);
});

// 全局导出（用于调试）
window.AI CloudCity = {
    state,
    utils,
    dataManager,
    features,
    init
};