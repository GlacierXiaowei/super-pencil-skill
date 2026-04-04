---
name: super-pencil
description: Use when using Pencil MCP - loads core workflow and dispatches to specialized skills as needed
---

# Super Pencil

## Overview

Master skill for using Pencil MCP. Load this first, then load specialized skills based on the task.

## Loading Strategy

```
1. Load `super-pencil` (this skill) ← Always load first
       │
       ├─→ Normal editing? → Load `super-pencil-core`
       ├─→ Review design? → Load `super-pencil-antipatterns`
       ├─→ Path issues? → Load `super-pencil-path-debugging`
       └─→ Errors? → Load `super-pencil-troubleshooting`
```

## Quick Reference

| If you need... | Load this skill |
|----------------|-----------------|
| Step-by-step workflow | `super-pencil-core` |
| Avoid mistakes before editing | `super-pencil-antipatterns` |
| Fix path rendering issues | `super-pencil-path-debugging` |
| Diagnose MCP errors | `super-pencil-troubleshooting` |

## Core Rules (Always Follow)

1. **Load schema first** → `get_editor_state(include_schema=true)`
2. **Read nodes before editing** → `batch_get`
3. **Use placeholder** → Set `true` during work, `false` when done
4. **Small batches** → Max 25 operations per `batch_design`
5. **Screenshot after edits** → Validate visually

## When to Load Sub-Skills

### super-pencil-core
Load when: Starting any Pencil editing task
Provides: Complete 8-step workflow with code examples

### super-pencil-antipatterns
Load when: 
- Before complex edits
- Reviewing design decisions
- Want to avoid common mistakes

### super-pencil-path-debugging
Load when:
- Path stroke in wrong position
- Strokes detached from anchors
- Need to fix path geometry

### super-pencil-troubleshooting
Load when:
- MCP returns errors (null or vague)
- `batch_design` fails
- Edits do nothing
- Text disappears

## Quick Start

```
1. Open file → open_document
2. Load schema → get_editor_state(include_schema=true)
3. Read nodes → batch_get
4. Set placeholder → U("frameId",{placeholder:true})
5. Edit → batch_design (max 25 ops)
6. Screenshot → get_screenshot
7. Debug if needed → Load related skill
8. Remove placeholder → U("frameId",{placeholder:false})
```

## Related Skills

- `super-pencil-core` - Detailed workflow
- `super-pencil-antipatterns` - Common mistakes
- `super-pencil-path-debugging` - Path issues
- `super-pencil-troubleshooting` - Error diagnosis
