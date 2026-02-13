# Terrain Tester - Usage Guide

## Getting Started

### Opening the Project
1. Open `TerrainTester.xcodeproj` in Xcode on a Mac
2. The project will open with all files properly organized:
   - Models folder contains the data structures (Tile, TerrainType, MapGrid)
   - Views folder contains the UI components (MapView)
   - Services folder contains logic (SpriteSheet, TerrainGenerator)

### Running the App
1. Select a simulator target: iPhone 15 Pro, iPad Pro, etc.
2. Press ⌘R or click the Run button
3. The app will launch showing a generated terrain map

## App Interface

### Main Screen Layout
The app displays:
- **Title Bar**: "Terrain Tester" title on the left
- **Generation Mode Selector**: Segmented control to choose between:
  - Test Pattern: Shows all terrain types in a diagonal pattern
  - Random: Completely random terrain distribution
  - Clustered: More realistic terrain with grouped features
- **Regenerate Button**: Blue button to generate a new map
- **Map View**: The main scrollable area displaying the tile-based map
- **Legend**: Bottom bar showing all terrain types with their colors

### Terrain Types
The app supports six terrain types:
1. **Grass** (Bright Green): Common ground terrain
2. **Water** (Blue): Lakes, rivers, and water bodies
3. **Dirt** (Brown): Bare earth patches
4. **Stone** (Gray): Rocky terrain
5. **Sand** (Yellow/Beige): Sandy areas
6. **Forest** (Dark Green): Tree-covered areas

### Controls
- **Scroll**: Drag to pan around the map
- **Regenerate**: Tap to create a new random map with the selected generation mode
- **Mode Selector**: Tap to switch between different generation algorithms

## Generation Modes

### Test Pattern
Creates a diagonal pattern cycling through all terrain types.
- Best for: Verifying all sprites are loading correctly
- Use case: Testing and debugging

### Random
Each tile is randomly assigned a terrain type based on probability weights:
- 40% Grass
- 10% Water
- 20% Dirt
- 15% Forest
- 10% Sand
- 5% Stone

### Clustered (Recommended)
Generates more natural-looking terrain with:
- 3 water bodies with circular shapes
- 4 forest clusters
- Random dirt patches
- Occasional stone outcrops
- Grass as the base terrain

This mode creates the most realistic and visually appealing maps.

## Technical Details

### Map Size
Default map size: 30 tiles wide × 20 tiles high (600 tiles total)

### Tile Size
Default tile size: 24×24 points on screen

### Performance
The app uses SwiftUI's efficient rendering with:
- ObservableObject for state management
- On-demand sprite caching
- Lightweight tile data structures

### Sprite System
The app is designed to work with sprite sheets:
1. If a sprite sheet named `terrain_spritesheet` exists in Assets, it will be used
2. Otherwise, it falls back to programmatically generated colored squares
3. Each terrain type maps to a specific index in the sprite sheet

### Adding Custom Sprites
To add your own sprite sheet:
1. Create a PNG image with tiles arranged in a grid
2. Default configuration: 4 tiles per row
3. Each tile should be the same size (e.g., 32×32 pixels)
4. Add the image to Assets.xcassets as `terrain_spritesheet`
5. Tiles are indexed left-to-right, top-to-bottom starting at 0

Tile mapping:
- Index 0: Grass
- Index 1: Water
- Index 2: Dirt
- Index 3: Stone
- Index 4: Sand
- Index 5: Forest

## Customization

### Changing Map Size
In `ContentView.swift`, modify the initialization:
```swift
let initialMap = TerrainGenerator.generateClusteredTerrain(width: 40, height: 30)
```

### Adjusting Tile Size
In `ContentView.swift`, change the MapView initialization:
```swift
MapView(mapGrid: mapGrid, tileSize: 32)  // Larger tiles
```

### Adding New Terrain Types
1. Edit `TerrainType.swift` and add a new case
2. Update the `spriteIndex` property
3. Add the color in `ContentView.colorForTerrain()`
4. Update placeholder generation in `SpriteSheet.getPlaceholderSprites()`

### Modifying Generation Algorithms
Edit `TerrainGenerator.swift` to:
- Adjust probability weights in `generateRandomTerrain()`
- Change cluster sizes in `generateClusteredTerrain()`
- Create entirely new generation algorithms

## Architecture

### Model Layer
- **Tile**: Represents a single tile with position and terrain type
- **TerrainType**: Enum defining all available terrain types
- **MapGrid**: Manages the 2D array of tiles with getter/setter methods

### View Layer
- **ContentView**: Main app screen with controls and legend
- **MapView**: Renders the tile grid using sprites

### Service Layer
- **SpriteSheet**: Handles sprite loading and extraction from sprite sheets
- **TerrainGenerator**: Contains algorithms for procedural terrain generation

## Future Enhancements

Possible additions to expand the app:
- Tap to edit individual tiles
- Save/load maps
- Zoom in/out functionality
- More terrain types (snow, lava, swamp, etc.)
- Animated tiles (water waves, moving clouds)
- Multiple layers (ground, objects, decorations)
- Minimap overview
- Biome-based generation
- Procedural noise algorithms (Perlin, Simplex)
