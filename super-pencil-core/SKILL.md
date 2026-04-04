---
name: super-pencil-core
description: Use when using Pencil MCP to edit .pen files, prevent errors and rendering issues
---

# Super Pencil Core

## Overview

Core workflow for using Pencil MCP safely. Follow this every time you edit a `.pen` file to prevent errors and rendering issues.

## Quick Reference

| Step | Action | Command |
|------|--------|---------|
| 1 | Open file | `open_document` |
| 2 | Load schema | `get_editor_state(include_schema=true)` |
| 3 | Read nodes | `batch_get` with patterns |
| 4 | Set placeholder | `U("frameId",{placeholder:true})` |
| 5 | Edit batches | `batch_design` (max 25 ops) |
| 6 | Screenshot | `get_screenshot` |
| 7 | Debug | See related skills |
| 8 | Remove placeholder | `U("frameId",{placeholder:false})` |

## Core Workflow

Follow these 8 steps in order:

1. **Open the file**
   ```json
   {"filePathOrTemplate": "<absolute path to .pen file>"}
   ```

2. **Load schema**
   ```json
   {"include_schema": true}
   ```
   Confirm: file path is correct, top-level frame IDs visible.

3. **Read target nodes**
   ```json
   {"filePath": "<path>", "patterns": [{"name": "target-name"}], "readDepth": 2, "searchDepth": 4, "includePathGeometry": true, "resolveVariables": true}
   ```

4. **Set placeholder**
   ```javascript
   U("frameId",{placeholder:true})
   ```

5. **Edit in small batches**
   - Max 25 operations per `batch_design` call
   - Separate structure from visual edits
   - Use fresh binding names every call

6. **Screenshot immediately**
   ```json
   {"filePath": "<path>", "nodeId": "frameId"}
   ```

7. **Debug if needed**
   - Path renders wrong → `super-pencil-path-debugging`
   - Error occurs → `super-pencil-troubleshooting`

8. **Remove placeholder**
   ```javascript
   U("frameId",{placeholder:false})
   ```

## Non-Negotiable Rules

1. **Always load schema first** - skip this = unsafe
2. **Use placeholder flags** - set `true` during work, `false` when done
3. **Keep batches small** - max 25 operations
4. **Validate visually** - screenshot after each change
5. **Prefer simple structures** - copy working patterns over patching broken ones

## Path Safety

For path nodes, ensure:
- `geometry` matches node `width/height`
- Use local coordinates (e.g., `M0 0 ...`)
- Avoid nested frames with complex offsets

## Related Skills

- **Antipatterns:** Use `super-pencil-antipatterns` to avoid common mistakes
- **Path debugging:** Use `super-pencil-path-debugging` when path renders in wrong position
- **Troubleshooting:** Use `super-pencil-troubleshooting` when MCP returns errors

## Common Mistakes

- Editing without reading nodes first
- Using large absolute path geometry in nested containers
- Leaving finished frames in placeholder mode
- Too many operations in one batch
