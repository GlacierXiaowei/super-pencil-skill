# Super Pencil

Master skill for using Pencil MCP - loads core workflow and dispatches to specialized skills for editing `.pen` files safely.

## Installation

### Option 1: Install via npm

```bash
npm install -g super-pencil
```

### Option 2: Manual Installation

Copy the skill folder to your OpenCode skills directory:

**Windows:**
```powershell
# Clone or download this repository
# Then copy to skills directory
Copy-Item -Path "<path-to-super-pencil>" -Destination "$env:USERPROFILE\.config\opencode\skills\super-pencil" -Recurse -Force
```

**macOS/Linux:**
```bash
# Clone or download this repository
# Then copy to skills directory
cp -r <path-to-super-pencil> ~/.config/opencode/skills/super-pencil
```

### Option 3: Use install.sh script

```bash
./install.sh
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
