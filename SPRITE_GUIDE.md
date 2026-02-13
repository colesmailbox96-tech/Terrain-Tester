# Adding Custom Sprite Sheets

This guide explains how to add your own sprite sheet to replace the placeholder colored tiles with actual pixel art.

## Quick Start

1. Create or obtain a sprite sheet image (PNG format)
2. Add it to the Xcode project
3. Name it `terrain_spritesheet` in Assets.xcassets
4. The app will automatically use it

## Sprite Sheet Requirements

### Image Format
- **Format**: PNG (recommended for transparency)
- **Color Mode**: RGBA (24-bit RGB + 8-bit Alpha)
- **File Size**: Keep under 2MB for best performance

### Layout Requirements
- **Tile Size**: 32×32 pixels (recommended)
- **Grid Layout**: 4 tiles per row (configurable)
- **Spacing**: No spacing between tiles
- **Padding**: No padding around the edges

### Example Layout for 32×32 tiles:
```
Total Image Size: 128×64 pixels (4 columns × 2 rows)

Row 1: Grass | Water | Dirt  | Stone
Row 2: Sand  | Forest| Empty | Empty
```

## Tile Ordering (Important!)

Tiles MUST be in this exact order:

| Index | Terrain Type | Position        |
|-------|-------------|-----------------|
| 0     | Grass       | Row 0, Column 0 |
| 1     | Water       | Row 0, Column 1 |
| 2     | Dirt        | Row 0, Column 2 |
| 3     | Stone       | Row 0, Column 3 |
| 4     | Sand        | Row 1, Column 0 |
| 5     | Forest      | Row 1, Column 1 |

## Step-by-Step: Adding Your Sprite Sheet

### 1. Prepare Your Sprite Sheet

Create a sprite sheet with the specifications above. Here's a sample layout:

```
┌────────┬────────┬────────┬────────┐
│ 32×32  │ 32×32  │ 32×32  │ 32×32  │
│ Grass  │ Water  │ Dirt   │ Stone  │
│   🌱   │   💧   │   🟫   │   🗻   │
├────────┼────────┼────────┼────────┤
│ 32×32  │ 32×32  │        │        │
│ Sand   │ Forest │        │        │
│   🏖️   │   🌲   │        │        │
└────────┴────────┴────────┴────────┘
```

### 2. Add to Xcode Project

#### Option A: Drag and Drop
1. Open your Xcode project
2. Select `Assets.xcassets` in the project navigator
3. Drag your PNG file into the asset catalog
4. Rename it to `terrain_spritesheet`

#### Option B: Manual Import
1. Open `Assets.xcassets` folder in Finder
2. Create a new folder: `terrain_spritesheet.imageset`
3. Copy your PNG file into this folder
4. Create a `Contents.json` file (see below)

#### Contents.json template:
```json
{
  "images" : [
    {
      "filename" : "your_sprite_sheet.png",
      "idiom" : "universal",
      "scale" : "1x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```

### 3. Verify and Test

1. Build and run the app
2. Select "Test Pattern" mode
3. All 6 terrain types should display in sequence
4. Verify each sprite loads correctly

## Using Different Tile Sizes

If your sprites are not 32×32, update the `MapView.swift` file:

```swift
// In ContentView.swift, change the tileSize parameter:
MapView(mapGrid: mapGrid, tileSize: 16)  // For 16×16 tiles
```

Also update the SpriteSheet initialization if needed:

```swift
// In MapView.swift, SpriteManager class:
let spriteSheet = SpriteSheet(
    imageName: "terrain_spritesheet",
    tileSize: CGSize(width: 16, height: 16),  // Change here
    tilesPerRow: 4
)
```

## Using Different Grid Layouts

If your sprite sheet has a different number of tiles per row:

```swift
// In MapView.swift, SpriteManager class:
let spriteSheet = SpriteSheet(
    imageName: "terrain_spritesheet",
    tileSize: CGSize(width: 32, height: 32),
    tilesPerRow: 6  // Change to your layout (e.g., 6 tiles in a row)
)
```

## Art Style Recommendations

For a Dwarf Fortress / Stardew Valley style:

### Pixel Art Guidelines
- **Resolution**: Keep it low (16×16 or 32×32)
- **Color Palette**: Limited colors (8-16 colors per tile)
- **Outlines**: Optional dark outlines for clarity
- **Style**: Consistent style across all tiles

### Terrain Characteristics
- **Grass**: Bright green with texture, maybe small flowers
- **Water**: Blue with light reflections or waves
- **Dirt**: Brown with rough texture
- **Stone**: Gray with cracks or mineral veins
- **Sand**: Yellow/tan with granular texture
- **Forest**: Dark green with tree shapes

### Example Color Palettes

#### Bright and Cheerful (Stardew Valley style)
- Grass: `#7CFC00` (bright green)
- Water: `#1E90FF` (dodger blue)
- Dirt: `#8B4513` (saddle brown)
- Stone: `#696969` (dim gray)
- Sand: `#F4A460` (sandy brown)
- Forest: `#228B22` (forest green)

#### Dark and Moody (Dwarf Fortress style)
- Grass: `#4A7023` (dark green)
- Water: `#003366` (dark blue)
- Dirt: `#5C4033` (dark brown)
- Stone: `#3C3C3C` (dark gray)
- Sand: `#C2B280` (muted sand)
- Forest: `#1B4D1B` (very dark green)

## Creating Animated Tiles (Advanced)

For animated effects like water waves:

1. Create multiple frames of each tile
2. Store them as separate images
3. Modify `SpriteSheet.swift` to support animation frames
4. Use SwiftUI animations to cycle through frames

This would require extending the current implementation.

## Free Sprite Resources

Some free resources for pixel art sprite sheets:
- **OpenGameArt.org**: Free game assets
- **itch.io**: Many free and paid sprite packs
- **Kenney.nl**: Free game assets including tiles
- **Create Your Own**: Use Aseprite, GIMP, or Photoshop

## Troubleshooting

### Sprites Not Loading
- Verify the image name is exactly `terrain_spritesheet`
- Check the image is in Assets.xcassets
- Ensure the image format is PNG
- Build and clean (Product > Clean Build Folder)

### Sprites Look Wrong
- Verify tile order matches the expected layout
- Check that `tilesPerRow` matches your image
- Ensure tile size is correct
- Verify no spacing between tiles

### Performance Issues
- Reduce sprite sheet file size
- Use smaller tile sizes (16×16 instead of 32×32)
- Optimize PNG with tools like TinyPNG

### Placeholders Still Showing
If placeholders appear instead of your sprites:
1. Check the image name and location
2. Verify the SpriteSheet class can find the image
3. Look for console errors in Xcode
4. Try re-adding the image to Assets.xcassets

## Example: Creating a Simple Sprite Sheet

Using any pixel art editor:

1. **Create a 128×64 pixel canvas** (for 32×32 tiles)
2. **Draw your first tile (Grass)** in the top-left 32×32 area
3. **Draw Water** in the next 32×32 area to the right
4. **Continue for all 6 terrain types**
5. **Export as PNG**
6. **Add to Xcode**

Even simple colored squares with patterns work well for a retro aesthetic!

## Next Steps

After adding your sprite sheet:
1. Experiment with different terrain generation modes
2. Adjust tile sizes for your preferred look
3. Consider adding more terrain types
4. Explore animation for special tiles

Happy sprite making! 🎨
