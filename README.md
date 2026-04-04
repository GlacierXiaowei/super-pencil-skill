# Super Pencil

Master skill for using Pencil MCP - loads core workflow and dispatches to specialized skills for editing `.pen` files safely.

## Installation

### Option 1: Install via npm

```bash
# Download and extract npm package
npm pack super-pencil
tar -xzf super-pencil-1.0.0.tgz

# Copy to skills directory (Please find the installation location of the skill for your CLI platform by yourself.)
cp -r package ~/.config/opencode/skills/super-pencil
```

### Option 2: Install via GitHub
When running `npx skills add GlacierXiaowei/super-pencil --skill super-pencil`:

1. You'll see a list of AI agents
2. Use `↑↓` to navigate, `Space` to select/deselect
3. **Select only OpenCode** (or your preferred agent)
4. Press `Enter` to confirm

> **Tip:** Press `Space` first to deselect all, then select only OpenCode.


```bash
npx skills add GlacierXiaowei/super-pencil --skill super-pencil
```

### Option 3: Manual Installation

1. Clone or download this repository
2. Copy the skill folder to your AI assistant's skills directory
3. Restart your AI assistant

### Option 4: Localskill Installation

```bash
localskills install super-pencil
```
## Quick Start

Once installed, load the skill in your AI assistant:

```
Load skill: super-pencil
```

The skill will guide you through the 8-step workflow for safe `.pen` file editing.

## Skill Structure

```
super-pencil/
├── SKILL.md                          # Main entry point
├── super-pencil-core/
│   └── SKILL.md                      # Core editing workflow
├── super-pencil-antipatterns/
│   └── SKILL.md                      # Common mistakes to avoid
├── super-pencil-path-debugging/
│   └── SKILL.md                      # Path rendering issues
└── super-pencil-troubleshooting/
    └── SKILL.md                      # Error diagnosis
```

## When to Use Each Skill

| Skill | Use When |
|-------|----------|
| `super-pencil` | Starting any Pencil MCP task (load first) |
| `super-pencil-core` | Need step-by-step editing workflow |
| `super-pencil-antipatterns` | Before complex edits, review design decisions |
| `super-pencil-path-debugging` | Path stroke renders in wrong position |
| `super-pencil-troubleshooting` | MCP returns errors or edits do nothing |

## Core Workflow

1. **Open file** → `open_document`
2. **Load schema** → `get_editor_state(include_schema=true)`
3. **Read nodes** → `batch_get` with patterns
4. **Set placeholder** → `U("frameId",{placeholder:true})`
5. **Edit batches** → `batch_design` (max 25 ops)
6. **Screenshot** → `get_screenshot`
7. **Debug if needed** → Load related skill
8. **Remove placeholder** → `U("frameId",{placeholder:false})`

## Non-Negotiable Rules

1. Always load schema first
2. Use placeholder flags during work
3. Keep batches small (max 25 operations)
4. Validate visually with screenshots
5. Use fresh binding names every batch call

## License

Apache-2.0

## Author

**Glacier Xiaowei**
- GitHub: [@GlacierXiaowei](https://github.com/GlacierXiaowei)
- Email: glacier_xiaowei@163.com

## Related Projects

- [Pencil MCP](https://github.com/pencil-mcp/pencil-mcp) - The MCP server for `.pen` file editing
- [structured-learning-skill](https://github.com/GlacierXiaowei/structured-learning-skill) - Structured learning skill for AI assistants
- [guided-learning-skill](https://github.com/GlacierXiaowei/guided-learning-skill) - Socratic guided learning skill
