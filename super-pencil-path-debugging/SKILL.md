---
name: super-pencil-path-debugging
description: Use when Pencil MCP path renders in wrong position or strokes appear detached
---

# Super Pencil Path Debugging

## Overview

Diagnose and fix path rendering issues where strokes appear in wrong positions despite correct-looking JSON.

## Quick Reference

| Symptom | Cause | Fix |
|---------|-------|-----|
| Stroke off-position | Geometry uses global coords | Rewrite with local `M0 0` |
| Detached anchors | Nested frame offsets | Move to direct child |
| Split across canvas | Double offset | Use single top-card |
| Floating elements | Bounds mismatch | Match geometry to width/height |

## When to Use

- Path stroke renders far from expected position
- Mouth arc floating away from face
- Nose appearing off to the side
- Face strokes split across canvas
- Strokes detached from anchors

## The Problem

Path `geometry` coordinates are interpreted relative to board/root-space, not local SVG group space. This causes double offsets when:

- `x/y` says one thing
- `width/height` says another
- `geometry` describes different bounding area

## Diagnosis Steps

### Step 1: Screenshot the isolated frame

```json
{
  "filePath": "<path>",
  "nodeId": "problematicFrameId"
}
```

### Step 2: Read node with geometry

```json
{
  "filePath": "<path>",
  "nodeIds": ["pathNodeId"],
  "includePathGeometry": true,
  "resolveVariables": true
}
```

### Step 3: Check consistency

Verify:
- Does `x/y` match expected position?
- Does `width/height` match geometry span?
- Is geometry using local or global coordinates?

## The Fix

### Unstable pattern (avoid)

```javascript
I("nestedFrame",{
  type:"path",
  x:45, y:35,
  width:175, height:30,
  geometry:"M100 115q88 60 175 0"
})
```

**Why unstable:**
- `x/y` is local
- `geometry` looks like global coordinates
- Bounding assumptions drift

### Stable pattern (use)

```javascript
I("topCard",{
  type:"path",
  x:96, y:110,
  width:188, height:58,
  geometry:"M0 8Q94 64 188 8",
  stroke:{thickness:5,cap:"round",fill:"#000000"}
})
```

**Why stable:**
- Path starts near local origin
- Geometry span matches node width/height
- Less ambiguity between bounds and drawing

## Restructuring Strategy

If patching doesn't work, rebuild structure:

1. Stop patching old nested structure
2. Create single top-card frame with `clip:true`
3. Put background and strokes as direct children
4. Rewrite paths with simple local geometry
5. Validate via isolated screenshots

## Safe Path Rules

1. **Match bounds:** `geometry` span should match `width/height`
2. **Use local coords:** Start near `M0 0` or local origin
3. **Avoid nested offsets:** Don't use complex absolute coordinates in nested frames
4. **Consistent bounding:** Node bounds = drawing bounds

## Example: Face Illustration

```javascript
// Container
U("pageFrame",{placeholder:true})
U("topCard",{
  x:0, y:0,
  width:390, height:500,
  clip:true
})

// Background
U("faceBg",{
  x:55, y:130,
  width:280, height:280
})

// Direct-child strokes
I("topCard",{
  type:"path",
  name:"face-head-arc",
  x:96, y:110,
  width:188, height:58,
  geometry:"M0 8Q94 64 188 8",
  stroke:{thickness:5,cap:"round",fill:"#000000"}
})
```

## Verification

After fixing:
1. Screenshot isolated frame
2. Compare with expected result
3. Check all paths align correctly
4. Remove placeholder when done

## Related Skills

- **Core workflow:** Use `super-pencil-core` for standard editing
- **Antipatterns:** Use `super-pencil-antipatterns` to avoid common mistakes
- **Troubleshooting:** Use `super-pencil-troubleshooting` for MCP errors
