#!/bin/bash
# ============================================================
#  核心技能库 — 一键安装脚本
#  支持: Claude Code / Cursor / Windsurf / Copilot / Codex
#  用法: bash install.sh [工具名...]
#  示例: bash install.sh claude cursor
#        bash install.sh all
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/基础技能"
ACTIVATORS_DIR="$SCRIPT_DIR/集成技能"

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# ── 工具安装路径配置 ──────────────────────────────────────────
declare -A TOOL_PATHS
TOOL_PATHS[claude]="$HOME/.claude/skills"
TOOL_PATHS[cursor]="$HOME/.cursor/skills"
TOOL_PATHS[windsurf]="$HOME/.windsurf/skills"
TOOL_PATHS[copilot]="$HOME/.copilot/skills"
TOOL_PATHS[codex]="$HOME/.codex/skills"
TOOL_PATHS[amp]="$HOME/.amp/skills"
TOOL_PATHS[openagent]="$HOME/.openagent/skills"
# 自定义路径（通过环境变量）
TOOL_PATHS[custom]="${SKILLS_INSTALL_PATH:-}"

# ── 函数 ──────────────────────────────────────────────────────

show_help() {
  echo ""
  echo -e "${CYAN}╔══════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║     核心技能库 — 一键安装脚本              ║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}"
  echo ""
  echo "用法: bash install.sh [选项]"
  echo ""
  echo "选项:"
  echo "  claude      安装到 Claude Code"
  echo "  cursor      安装到 Cursor"
  echo "  windsurf    安装到 Windsurf"
  echo "  copilot     安装到 GitHub Copilot"
  echo "  codex       安装到 OpenAI Codex"
  echo "  amp         安装到 Amp"
  echo "  custom      安装到 \$SKILLS_INSTALL_PATH"
  echo "  all         安装到所有已知工具"
  echo "  list        列出所有技能"
  echo "  help        显示此帮助"
  echo ""
  echo "示例:"
  echo "  bash install.sh claude cursor"
  echo "  bash install.sh all"
  echo "  SKILLS_INSTALL_PATH=/my/path bash install.sh custom"
  echo ""
}

install_to_tool() {
  local tool=$1
  local target_dir="${TOOL_PATHS[$tool]}"

  if [ -z "$target_dir" ]; then
    echo -e "${RED}✗ 未知工具: $tool${NC}"
    return 1
  fi

  echo ""
  echo -e "${CYAN}━━━ 安装到 $tool ($target_dir) ━━━${NC}"

  # 创建目录
  mkdir -p "$target_dir"

  local installed=0
  local skipped=0

  # 安装基础技能
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ ! -d "$skill_dir" ] && continue
    local skill_name=$(basename "$skill_dir")
    local target="$target_dir/$skill_name"

    if [ -e "$target" ]; then
      skipped=$((skipped + 1))
      continue
    fi

    # 优先符号链接（节省空间），失败则复制
    if ln -s "$skill_dir" "$target" 2>/dev/null; then
      :
    else
      cp -r "$skill_dir" "$target"
    fi
    installed=$((installed + 1))
  done

  # 安装集成技能
  for skill_dir in "$ACTIVATORS_DIR"/*/; do
    [ ! -d "$skill_dir" ] && continue
    local skill_name=$(basename "$skill_dir")
    local target="$target_dir/$skill_name"

    if [ -e "$target" ]; then
      skipped=$((skipped + 1))
      continue
    fi

    if ln -s "$skill_dir" "$target" 2>/dev/null; then
      :
    else
      cp -r "$skill_dir" "$target"
    fi
    installed=$((installed + 1))
  done

  echo -e "${GREEN}✓ $tool: 安装 $installed 个技能, 跳过 $skipped 个已存在${NC}"
}

list_skills() {
  echo ""
  echo -e "${CYAN}━━━ 集成技能 (7 个激活器) ━━━${NC}"
  for d in "$ACTIVATORS_DIR"/*/; do
    [ ! -d "$d" ] && continue
    local name=$(basename "$d")
    local desc=$(grep -m1 '^description:' "$d/SKILL.md" 2>/dev/null | sed 's/^description: *//; s/^"//; s/"$//' | cut -c1-70)
    printf "  ${GREEN}%-25s${NC} %s\n" "$name" "$desc"
  done

  echo ""
  echo -e "${CYAN}━━━ 基础技能 (按类别) ━━━${NC}"

  echo ""
  echo -e "${YELLOW}  🎨 品牌设计 (71)${NC}"
  ls -d "$SKILLS_DIR"/design-*/ 2>/dev/null | xargs -I{} basename {} | sed 's/^/    /' | paste -sd'  ' -

  echo ""
  echo -e "${YELLOW}  ✨ GSAP 动画 (8)${NC}"
  ls -d "$SKILLS_DIR"/gsap-*/ 2>/dev/null | xargs -I{} basename {} | sed 's/^/    /'

  echo ""
  echo -e "${YELLOW}  🏗️  项目管理 GSD ($(ls -d "$SKILLS_DIR"/gsd-*/ 2>/dev/null | wc -l))${NC}"
  ls -d "$SKILLS_DIR"/gsd-*/ 2>/dev/null | xargs -I{} basename {} | sed 's/^/    /' | paste -sd'  ' -

  echo ""
  echo -e "${YELLOW}  🔧 DevOps & 基础设施${NC}"
  for s in docker-compose-generator ci-cd-pipeline-builder infrastructure-as-code-generator monitoring-stack-deployer log-aggregation-setup distributed-tracing-setup; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  💾 数据层${NC}"
  for s in database-schema-designer orm-code-generator query-performance-analyzer rest-api-generator api-schema-validator sync-server-db; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  📄 内容创作${NC}"
  for s in pptx scientific-slides prd ralph khazix-writer baimo; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  🔍 研究分析${NC}"
  for s in aihot hv-analysis devils-advocate; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  🎨 设计工具 (CKM + UI)${NC}"
  for s in ckm-banner-design ckm-brand ckm-design ckm-design-system ckm-slides ckm-ui-styling ui-ux-pro-max; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  🛠️  工具类${NC}"
  for s in find-skills skill-creator web-access neat-freak; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  echo -e "${YELLOW}  📦 项目专属${NC}"
  for s in xi-server xi-sync voltagent; do
    [ -d "$SKILLS_DIR/$s" ] && echo "    $s"
  done

  echo ""
  local total=$(ls -d "$SKILLS_DIR"/*/ "$ACTIVATORS_DIR"/*/ 2>/dev/null | wc -l)
  echo -e "${CYAN}  共计: $total 个技能${NC}"
  echo ""
}

# ── 主逻辑 ────────────────────────────────────────────────────

if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

for arg in "$@"; do
  case "$arg" in
    help|-h|--help)
      show_help
      ;;
    list|ls)
      list_skills
      ;;
    all)
      for tool in claude cursor windsurf copilot codex; do
        install_to_tool "$tool"
      done
      ;;
    claude|cursor|windsurf|copilot|codex|amp|openagent|custom)
      install_to_tool "$arg"
      ;;
    *)
      echo -e "${RED}✗ 未知选项: $arg${NC}"
      echo "  运行 bash install.sh help 查看帮助"
      ;;
  esac
done
