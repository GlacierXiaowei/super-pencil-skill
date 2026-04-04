---
name: super-pencil-antipatterns
description: Use when you need to avoid common Pencil MCP mistakes or review design decisions
---

# Super Pencil Antipatterns

## Overview

Common mistakes that cause Pencil MCP errors, rendering issues, or vague failures. Review before making edits to avoid problems.

## Quick Reference

| Antipattern | Symptom | Fix |
|-------------|---------|-----|
| No node read | Wrong parent, duplicate edit | Use `batch_get` first |
| Absolute path geometry | Stroke renders off-position | Use local coords `M0 0` |
| Placeholder left on | Document unfinished | Set `placeholder:false` |
| Too many ops | Debug impossible | Split to 25 ops/batch |
| Visual patching | Layout breaks | Screenshot first |
| Wrong frame | Edits not apply | Check `get_editor_state` |
| Reuse bindings | Batch fails | Fresh names per call |
| Geometry mismatch | Bounds drift | Match span to width/height |

## When to Use

- Before starting complex edits
- When reviewing design structure
- After unexpected errors
- When visual output looks wrong

## Antipatterns

### 1. Editing without reading nodes first

**Problem:** Causes wrong parent selection, editing duplicate nodes, broken assumptions.

**Fix:** Always use `batch_get` to inspect target nodes before any edit.

### 2. Large absolute path geometry in nested containers

**Problem:** Main cause of rendering drift. Path strokes appear in wrong position.

**Bad:**
```javascript
I("nestedFrame",{
  type:"path",
  x:45, y:35,
  width:175, height:30,
  geometry:"M100 115q88 60 175 0"
})
```

**Good:**
```javascript
I("topCard",{
  type:"path",
  x:96, y:110,
  width:188, height:58,
  geometry:"M0 8Q94 64 188 8"
})
```

**Rule:** Path geometry should use local coordinates starting near origin.

### 3. Leaving finished frames in placeholder mode

**Problem:** Makes document look unfinished, may confuse future edits.

**Fix:** Always set `placeholder:false` when done.

### 4. Too many unrelated edits in one batch

**Problem:** Makes debugging impossible if result breaks.

**Fix:** Split into smaller batches:
1. Fix container structure
2. Fix shape positions
3. Fix path nodes
4. Fine-tune spacing

### 5. Assuming visual bugs are "just a few pixels off"

**Problem:** Position issues are often:
- Parent mismatch
- Geometry mismatch
- Clipping issue
- Duplicate node issue

**Fix:** Always prove with screenshot before patching.

### 6. Working outside placeholder frame

**Problem:** Edits may not apply to intended target.

**Fix:** Confirm active frame with `get_editor_state` before editing.

### 7. Reusing binding names from old batches

**Problem:** Bindings only work within same `batch_design` call.

**Fix:** Use fresh binding names every call.

### 8. Path geometry inconsistent with bounds

**Problem:** `x/y`, `width/height`, and `geometry` describe different areas.

**Fix:** Ensure geometry span matches node dimensions.

## Red Flags

STOP and check structure if you see:

- Path renders far from expected position
- Strokes appear detached from anchors
- Lines split across canvas
- Text disappears after edit
- Layout breaks after many changes

**Action:** See `super-pencil-path-debugging` for path issues, `super-pencil-troubleshooting` for errors.

## Safer Patterns

### Container structure
```javascript
U("pageFrame",{placeholder:true})
U("topCard",{
  x:0, y:0,
  width:390, height:500,
  clip:true,
  cornerRadius:[0,0,40,40]
})
```

### Direct-child strokes
```javascript
I("topCard",{
  type:"path",
  name:"face-head-arc",
  x:96, y:110,
  width:188, height:58,
  geometry:"M0 8Q94 64 188 8",
  stroke:{thickness:5,cap:"round",fill:"#000000"}
})
```

**Benefits:** Fewer coordinate surprises, easier screenshots, easier debugging.

## Related Skills

- **Core workflow:** Use `super-pencil-core` for standard editing workflow
- **Path debugging:** Use `super-pencil-path-debugging` when path renders wrong
- **Troubleshooting:** Use `super-pencil-troubleshooting` for error diagnosis
