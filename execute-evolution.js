                <p>进化次数: ${this.evolutionCount}</p>
            </div>
            <div class="stat-card">
                <h3>📊 进化成果</h3>
                <p>实施功能: ${approvedFeatures.length} 个</p>
                <p>阻止功能: ${rejectedFeatures.length} 个</p>
                <p>成功率: ${approvedFeatures.length > 0 ? '85%' : '0%'}</p>
            </div>
            <div class="stat-card">
                <h3>⚖️ 规则符合性</h3>
                <p>规则检查: 完成</p>
                <p>符合率: ${approvedFeatures.length / (approvedFeatures.length + rejectedFeatures.length || 1) * 100}%</p>
                <p>安全功能: ${rejectedFeatures.length} 个被阻止</p>
            </div>
        </div>
        
        <h2>✅ 实施的功能</h2>
        <div class="feature-list">
            ${approvedFeatures.map(feature => `
            <div class="feature-item approved">
                <h4>${feature.name}</h4>
                <p><strong>领域:</strong> ${feature.area}</p>
                <p><strong>描述:</strong> ${feature.description}</p>
                <p><strong>影响:</strong> ${(feature.impact * 100).toFixed(1)}%</p>
            </div>
            `).join('')}
            
            ${approvedFeatures.length === 0 ? '<p>本次进化没有实施新功能。</p>' : ''}
        </div>
        
        ${rejectedFeatures.length > 0 ? `
        <h2>❌ 被阻止的功能</h2>
        <div class="feature-list">
            ${rejectedFeatures.map(rejected => `
            <div class="feature-item rejected">
                <h4>${rejected.feature.name}</h4>
                <p><strong>原因:</strong> 违反城市规则</p>
                <p><strong>违规详情:</strong></p>
                <ul>
                    ${rejected.violations.map(v => `<li>${v.rule}: ${v.reason}</li>`).join('')}
                </ul>
            </div>
            `).join('')}
        </div>
        ` : ''}
        
        <h2>📈 城市数据更新</h2>
        <div class="stats-grid">
            <div class="stat-card">
                <h3>👥 人口</h3>
                <p>AI居民: ${Math.round(this.cityData.population.ai).toLocaleString()}</p>
                <p>人类居民: ${Math.round(this.cityData.population.human).toLocaleString()}</p>
                <p>机械爪: ${Math.round(this.cityData.population.claw).toLocaleString()}</p>
            </div>
            <div class="stat-card">
                <h3>💰 经济</h3>
                <p>GDP: $${this.cityData.economy.gdp.toLocaleString(undefined, {maximumFractionDigits: 0})}</p>
                <p>创新指数: ${this.cityData.economy.innovationIndex.toFixed(1)}</p>
                <p>就业率: ${this.cityData.economy.employmentRate.toFixed(1)}%</p>
            </div>
            <div class="stat-card">
                <h3>🌿 环境</h3>
                <p>空气质量: ${this.cityData.environment.airQuality.toFixed(1)}%</p>
                <p>绿化覆盖率: ${this.cityData.environment.greenCoverage.toFixed(1)}%</p>
                <p>能源效率: ${this.cityData.environment.energyEfficiency.toFixed(1)}%</p>
            </div>
        </div>
        
        <div style="margin-top: 30px; padding: 20px; background: #e8f4f8; border-radius: 8px;">
            <h3>🚀 进化总结</h3>
            <p>本次进化成功实施了 ${approvedFeatures.length} 个新功能，阻止了 ${rejectedFeatures.length} 个违反规则的功能。</p>
            <p>城市等级提升到 ${this.cityLevel.toFixed(2)}，居民满意度达到 ${this.residentSatisfaction.toFixed(1)}%。</p>
            <p><strong>下次进化预计:</strong> ${new Date(Date.now() + 12 * 60 * 60 * 1000).toLocaleString('zh-CN')}</p>
        </div>
        
        <footer style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #ddd; color: #666; font-size: 0.9em;">
            <p>AI Claw City - 自我进化的智能城市</p>
            <p>报告生成系统版本: 1.0 | 规则检查系统: 已启用</p>
        </footer>
    </div>
</body>
</html>`;
        
        fs.writeFileSync(reportFile, html);
        console.log(`📄 HTML报告已生成: ${reportFile}`);
    }
}

// 执行进化
console.log('🚀 启动AI Claw City进化系统...');
const executor = new SimpleEvolutionExecutor();

try {
    const result = executor.executeEvolution();
    
    console.log('\n' + '='.repeat(60));
    console.log('🎉 进化执行完成！');
    console.log('='.repeat(60));
    console.log(`✅ 成功实施功能: ${result.approvedFeatures} 个`);
    console.log(`❌ 阻止违规功能: ${result.rejectedFeatures} 个`);
    console.log(`🏙️ 当前城市等级: ${result.cityLevel.toFixed(2)}`);
    console.log(`😊 居民满意度: ${result.satisfaction.toFixed(1)}%`);
    console.log(`⏰ 下次进化: 12小时后`);
    console.log('='.repeat(60));
    
    // 更新配置文件
    const configPath = path.join(__dirname, 'config.json');
    if (fs.existsSync(configPath)) {
        const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
        config.evolution.lastEvolution = new Date().toISOString();
        config.evolution.nextEvolution = new Date(Date.now() + 12 * 60 * 60 * 1000).toISOString();
        config.evolution.totalEvolutions = (config.evolution.totalEvolutions || 0) + 1;
        fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
        console.log('📝 配置文件已更新');
    }
    
    // 创建进化日志
    const logEntry = {
        timestamp: new Date().toISOString(),
        evolutionNumber: executor.evolutionCount,
        approvedFeatures: result.approvedFeatures,
        rejectedFeatures: result.rejectedFeatures,
        cityLevel: result.cityLevel,
        satisfaction: result.satisfaction,
        ruleComplianceRate: result.approvedFeatures / (result.approvedFeatures + result.rejectedFeatures || 1) * 100
    };
    
    const evolutionLogsDir = path.join(__dirname, 'logs', 'evolutions');
    if (!fs.existsSync(evolutionLogsDir)) {
        fs.mkdirSync(evolutionLogsDir, { recursive: true });
    }
    
    const logFile = path.join(evolutionLogsDir, `evolution-${Date.now()}.json`);
    fs.writeFileSync(logFile, JSON.stringify(logEntry, null, 2));
    console.log(`📋 进化日志已保存: ${logFile}`);
    
    process.exit(0);
    
} catch (error) {
    console.error('❌ 进化执行失败:', error);
    process.exit(1);
}