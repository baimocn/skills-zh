# 🧠 核心技能库 (Skills ZH)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Skills](https://img.shields.io/badge/Skills-180+-green.svg)](基础技能/)
[![Platforms](https://img.shields.io/badge/Platforms-6+-purple.svg)](#兼容性)

> 🚀 **可移植的 AI 编码技能集合** —— 支持 Claude Code / Cursor / Windsurf / Copilot / Codex 一键安装

一个精心设计的中文 AI 编码技能库，包含 **180+ 个独立技能**和 **7 个智能激活器**，覆盖从品牌设计到项目管理的完整开发工作流。

---

## ✨ 亮点

- 🎨 **71 个品牌设计系统** - Airbnb、Apple、Stripe 等全球顶级品牌设计语言
- 🏗️ **80+ 项目管理技能** - 完整的 GSD 生命周期：计划 → 执行 → 发布 → 归档
- ⚡ **7 个智能激活器** - 自动检测意图，主动讨论方案，而非被动加载
- 🔧 **全栈工具链** - DevOps、数据库、API、内容创作一应俱全
- 🌏 **中文优先** - 所有技能描述和文档均为中文
- 📦 **一键安装** - 一行命令部署到任意 AI 编码工具

---

## 🚀 快速开始

### 一键安装

```bash
# 安装到 Claude Code
bash install.sh claude

# 安装到 Cursor
bash install.sh cursor

# 同时安装到多个工具
bash install.sh claude cursor windsurf

# 安装到所有支持的工具
bash install.sh all

# 查看所有技能列表
bash install.sh list

# 查看帮助
bash install.sh help
```

### 自定义路径

```bash
SKILLS_INSTALL_PATH=/path/to/skills bash install.sh custom
```

---

## 📁 项目结构

```
核心技能库/
├── install.sh              ← 一键安装脚本
├── README.md               ← 本文件
├── 集成技能/                ← 7 个智能激活器
│   ├── design-activator/       → 品牌设计路由 (71 品牌)
│   ├── gsap-activator/         → 动画路由 (8 技能)
│   ├── gsd-activator/          → 项目管理路由 (80+ 流程)
│   ├── devops-activator/       → DevOps 路由 (7 技能)
│   ├── data-activator/         → 数据层路由 (6 技能)
│   ├── content-activator/      → 内容创作路由 (9 技能)
│   └── research-activator/     → 研究分析路由 (10 技能)
└── 基础技能/                ← 180+ 个独立技能
    ├── design-*/               → 71 个品牌设计系统
    ├── gsap-*/                 → 8 个 GSAP 动画技能
    ├── gsd-*/                  → 80+ 个项目管理工作流
    ├── docker/ci/infra/*       → DevOps 工具链
    ├── db/orm/api/*            → 数据层工具链
    └── pptx/slides/prd/*       → 内容创作工具
```

---

## 🧠 集成技能 — 智能激活器

集成技能是整个系统的「大脑」。它们不等用户点名，而是：

1. **🔍 主动检测** — 扫描代码、文件名、依赖、用户意图中的信号
2. **💬 发起讨论** — 交付评估简报，提出 2-3 个方向及权衡分析
3. **🤝 共同决策** — 追问、迭代、展示预览，直到达成共识
4. **⚡ 路由执行** — 将决定落地到具体的子技能执行

| 激活器 | 管理技能数 | 触发场景 |
|--------|-----------|---------|
| **design-activator** | 71 | UI/前端/颜色/排版/组件 |
| **gsap-activator** | 8 | 动画/滚动/过渡/UI 动效 |
| **gsd-activator** | 80+ | 项目规划/执行/调试/发布 |
| **devops-activator** | 7 | Docker/CI-CD/监控/部署 |
| **data-activator** | 6 | 数据库/ORM/API/查询 |
| **content-activator** | 9 | 文档/PPT/PRD/博客 |
| **research-activator** | 10 | 调研/对比/复盘/探索 |

### 跨激活器联动示例

```
用户: "做一个带动画的 SaaS landing page"
  ↓
design-activator  → 讨论品牌方向 (Stripe? Vercel?)
gsap-activator    → 匹配动画调性
content-activator → 讨论页面结构
gsd-activator     → 规划执行里程碑
devops-activator  → 讨论部署方案
data-activator    → 讨论后端数据模型
```

---

## 📦 基础技能分类

### 🎨 品牌设计系统 (71)

全球顶级品牌的设计语言，包括色彩、字体、间距、组件规范：

<details>
<summary>点击查看所有品牌</summary>

Airbnb, Airtable, Apple, Binance, BMW, Bugatti, Cal, Claude, Clay, ClickHouse, Cohere, Coinbase, Composio, Cursor, ElevenLabs, Expo, Ferrari, Figma, Framer, HashiCorp, IBM, Intercom, Kraken, Lamborghini, Linear, Lovable, Mastercard, Meta, MiniMax, Mintlify, Miro, Mistral, MongoDB, Nike, Notion, NVIDIA, Ollama, OpenCode, Pinterest, PlayStation, PostHog, Raycast, Renault, Replicate, Resend, Revolut, RunwayML, Sanity, Sentry, Shopify, Slack, SpaceX, Spotify, Starbucks, Stripe, Supabase, Superhuman, Tesla, The Verge, Together.ai, Uber, Vercel, Vodafone, VoltAgent, Warp, Webflow, Wired, Wise, x.ai, Zapier

</details>

### ✨ GSAP 动画 (8)

- Core, Frameworks, Performance, Plugins, React, ScrollTrigger, Timeline, Utils

### 🏗️ GSD 项目管理 (80+)

完整的项目生命周期管理：

```
New Project → Discuss → Plan → Execute → Verify → Ship → Review → Archive
```

### 🔧 DevOps 工具链 (6)

Docker Compose、CI/CD Pipeline、Infrastructure-as-Code、Monitoring、Logging、Distributed Tracing

### 💾 数据层工具 (6)

Schema Designer、ORM Generator、Query Optimizer、REST API Generator、Schema Validator、DB Sync

### 📄 内容创作 (6)

PPTX、Scientific Slides、PRD、Ralph、Khazix Writer、Baimo

### 🎨 设计工具 (7)

CKM Banner/Brand/Design/Design-System/Slides/UI-Styling, UI-UX-Pro-Max

### 🔍 研究分析 (3)

AI Hot、HV Analysis、Devil's Advocate

### 🛠️ 工具类 (4)

Find Skills、Skill Creator、Web Access、Neat Freak

---

## ⚙️ 兼容性

每个技能是一个标准文件夹，内含 `SKILL.md`（Markdown + YAML frontmatter），兼容所有支持 Markdown 技能的 AI 编码工具：

| 工具 | 安装路径 | 支持状态 |
|------|---------|---------|
| **Claude Code** | `~/.claude/skills/` | ✅ 完整支持 |
| **Cursor** | `~/.cursor/skills/` | ✅ |
| **Windsurf** | `~/.windsurf/skills/` | ✅ |
| **GitHub Copilot** | `~/.copilot/skills/` | ✅ |
| **OpenAI Codex** | `~/.codex/skills/` | ✅ |
| **Amp** | `~/.amp/skills/` | ✅ |

---

## 📋 添加自定义技能

1. 创建文件夹 `my-skill/`
2. 写入 `SKILL.md`（含 YAML frontmatter）
3. 放入 `基础技能/` 或 `集成技能/`
4. 重新运行 `bash install.sh <tool>`

### SKILL.md 模板

```markdown
---
name: my-skill
description: 一句话描述技能功能和触发场景
license: MIT
---

# 技能名称

## 什么时候用

描述触发条件...

## 怎么用

具体操作步骤...
```

---

## 🤝 贡献

欢迎提交 PR 添加新的技能！

1. Fork 本仓库
2. 创建你的技能文件夹
3. 提交 PR 并说明技能用途

---

## 📄 许可证

MIT License - 自由使用、修改和分发

---

## 🔗 相关链接

- [Claude Code](https://claude.ai/code)
- [Cursor](https://cursor.sh)
- [Windsurf](https://windsurf.ai)

---

<p align="center">
  Made with ❤️ for AI-powered development
</p>
