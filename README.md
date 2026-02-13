# Terrain-Tester

A 2D world simulator iPhone app with pixelated terrain, built using SwiftUI. The app renders tile-based maps using sprite sheets, similar in style to games like Dwarf Fortress and Stardew Valley.

## Features

- **Sprite Sheet Based Rendering**: Uses sprite sheets to render terrain tiles efficiently
- **Multiple Terrain Types**: Supports grass, water, dirt, stone, sand, and forest tiles
- **Terrain Generation**: Multiple terrain generation algorithms:
  - Test Pattern: Displays all terrain types in a diagonal pattern for testing
  - Random: Generates completely random terrain
  - Clustered: Creates more realistic terrain with water bodies, forests, and patches
- **Interactive Map**: Scrollable map view with regeneration controls
- **Responsive Design**: Works on both iPhone and iPad in landscape and portrait modes

## Project Structure

```
TerrainTester/
├── TerrainTesterApp.swift      # App entry point
├── ContentView.swift            # Main view with controls
├── Models/
│   ├── Tile.swift              # Individual tile model
│   ├── TerrainType.swift       # Terrain type enumeration
│   └── MapGrid.swift           # 2D grid management
├── Views/
│   └── MapView.swift           # Map rendering view
├── Services/
│   ├── SpriteSheet.swift       # Sprite sheet loader and manager
│   └── TerrainGenerator.swift  # Terrain generation algorithms
└── Assets.xcassets/            # Asset catalog
```

## Building and Running

1. Open `TerrainTester.xcodeproj` in Xcode
2. Select your target device (iPhone or iPad simulator)
3. Click Run (⌘R) to build and launch the app

## How It Works

### Sprite System
The app uses a `SpriteSheet` class that can load and extract individual tiles from a sprite sheet image. When a sprite sheet isn't available, it falls back to generating colored placeholder tiles programmatically.

### Map Rendering
The `MapView` uses SwiftUI to render a 2D grid of tiles. Each tile displays a sprite based on its terrain type. The map is scrollable to accommodate larger worlds.

### Terrain Generation
Three generation modes are available:
- **Test Pattern**: Shows all terrain types in sequence for debugging
- **Random**: Each tile is randomly assigned a terrain type
- **Clustered**: Creates more natural-looking terrain with grouped features like lakes and forests

## Customization

### Adding New Terrain Types
1. Add a new case to the `TerrainType` enum in `TerrainType.swift`
2. Update the sprite index mapping
3. Add the corresponding sprite to your sprite sheet or update placeholder colors

### Custom Sprite Sheets
To use custom sprite sheets:
1. Add your sprite sheet image to `Assets.xcassets`
2. Name it `terrain_spritesheet` or update the image name in `MapView.swift`
3. Ensure tiles are arranged in a grid with consistent tile sizes

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later