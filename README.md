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

## Quick Start

1. Open `TerrainTester.xcodeproj` in Xcode
2. Select your target device (iPhone or iPad simulator)
3. Click Run (⌘R) to build and launch the app
4. Use the controls to switch between generation modes and regenerate maps

## Documentation

- **[README.md](README.md)** (this file) - Project overview and quick start
- **[USAGE.md](USAGE.md)** - Comprehensive user guide and app interface details
- **[SCREENSHOTS.md](SCREENSHOTS.md)** - Visual examples and ASCII art representations
- **[SPRITE_GUIDE.md](SPRITE_GUIDE.md)** - Complete guide for adding custom sprite sheets

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
│   └── MapView.swift           # Map rendering view with SpriteManager
├── Services/
│   ├── SpriteSheet.swift       # Sprite sheet loader and manager
│   └── TerrainGenerator.swift  # Terrain generation algorithms
└── Assets.xcassets/            # Asset catalog
```

## How It Works

### Sprite System
The app uses a `SpriteSheet` class that can load and extract individual tiles from a sprite sheet image. A `SpriteManager` singleton caches sprites for optimal performance. When a sprite sheet isn't available, it falls back to generating colored placeholder tiles programmatically.

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
4. Update the legend in `ContentView.swift`

### Custom Sprite Sheets
See **[SPRITE_GUIDE.md](SPRITE_GUIDE.md)** for detailed instructions on:
- Creating sprite sheets
- Proper tile layout and ordering
- Supported formats and sizes
- Adding sprites to Xcode
- Troubleshooting

Quick version:
1. Add your sprite sheet image to `Assets.xcassets`
2. Name it `terrain_spritesheet`
3. Ensure tiles are 32×32 pixels in a 4-column grid
4. Rebuild and run

### Adjusting Map Size
Edit `ContentView.swift`:
```swift
let initialMap = TerrainGenerator.generateClusteredTerrain(width: 40, height: 30)
```

### Changing Tile Display Size
Edit `ContentView.swift`:
```swift
MapView(mapGrid: mapGrid, tileSize: 32)  // Change from 24 to 32
```

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Technical Highlights

- **SwiftUI**: Modern declarative UI framework
- **ObservableObject**: Reactive state management
- **Singleton Pattern**: Efficient sprite caching with SpriteManager
- **Modular Architecture**: Clean separation of concerns
- **Performance Optimized**: Sprites cached globally, rendered efficiently

## Future Enhancement Ideas

- Tap to edit individual tiles
- Save/load maps
- Zoom in/out functionality
- More terrain types
- Animated tiles (water waves, etc.)
- Multiple layers (ground, objects, decorations)
- Minimap overview
- Advanced procedural generation (Perlin noise, biomes)

## Contributing

This is a starting point for a 2D world simulator. Feel free to:
- Add new terrain types
- Implement new generation algorithms
- Create custom sprite sheets
- Add interactive features
- Optimize performance

## License

This project is provided as-is for educational and development purposes.