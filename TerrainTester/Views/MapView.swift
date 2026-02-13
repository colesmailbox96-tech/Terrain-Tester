import SwiftUI

/// Manages sprite loading and caching for the entire app
class SpriteManager {
    static let shared = SpriteManager()
    private var cache: [CGFloat: [TerrainType: UIImage]] = [:]
    
    private init() {}
    
    func getSprites(tileSize: CGFloat) -> [TerrainType: UIImage] {
        // Return cached sprites if available
        if let cachedSprites = cache[tileSize] {
            return cachedSprites
        }
        
        // Try to load sprite sheet, fall back to placeholder sprites
        let spriteSheet = SpriteSheet(
            imageName: "terrain_spritesheet",
            tileSize: CGSize(width: tileSize, height: tileSize),
            tilesPerRow: 4
        )
        
        let sprites: [TerrainType: UIImage]
        if let spriteSheet = spriteSheet {
            // Load sprites from sprite sheet
            var loadedSprites: [TerrainType: UIImage] = [:]
            for terrainType in TerrainType.allCases {
                if let sprite = spriteSheet.getTileForTerrain(terrainType) {
                    loadedSprites[terrainType] = sprite
                }
            }
            sprites = loadedSprites.isEmpty ? 
                SpriteSheet.getPlaceholderSprites(tileSize: CGSize(width: tileSize, height: tileSize)) : 
                loadedSprites
        } else {
            // Use placeholder sprites
            sprites = SpriteSheet.getPlaceholderSprites(
                tileSize: CGSize(width: tileSize, height: tileSize)
            )
        }
        
        // Cache the sprites
        cache[tileSize] = sprites
        return sprites
    }
}

/// SwiftUI view that renders the 2D tile-based map using sprites
struct MapView: View {
    @ObservedObject var mapGrid: MapGrid
    let tileSize: CGFloat
    let spriteCache: [TerrainType: UIImage]
    
    init(mapGrid: MapGrid, tileSize: CGFloat = 24) {
        self.mapGrid = mapGrid
        self.tileSize = tileSize
        self.spriteCache = SpriteManager.shared.getSprites(tileSize: tileSize)
    }
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: 0) {
                ForEach(0..<mapGrid.height, id: \.self) { y in
                    HStack(spacing: 0) {
                        ForEach(0..<mapGrid.width, id: \.self) { x in
                            if let tile = mapGrid.getTile(x: x, y: y),
                               let sprite = spriteCache[tile.terrainType] {
                                Image(uiImage: sprite)
                                    .resizable()
                                    .frame(width: tileSize, height: tileSize)
                                    .border(Color.black.opacity(0.1), width: 0.5)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.black)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let testMap = TerrainGenerator.generateTestPattern(width: 20, height: 15)
        MapView(mapGrid: testMap, tileSize: 32)
    }
}
