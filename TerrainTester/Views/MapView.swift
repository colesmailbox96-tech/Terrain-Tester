import SwiftUI

/// SwiftUI view that renders the 2D tile-based map using sprites
struct MapView: View {
    @ObservedObject var mapGrid: MapGrid
    let tileSize: CGFloat
    let spriteCache: [TerrainType: UIImage]
    
    init(mapGrid: MapGrid, tileSize: CGFloat = 32) {
        self.mapGrid = mapGrid
        self.tileSize = tileSize
        
        // Try to load sprite sheet, fall back to placeholder sprites
        let spriteSheet = SpriteSheet(
            imageName: "terrain_spritesheet",
            tileSize: CGSize(width: tileSize, height: tileSize),
            tilesPerRow: 4
        )
        
        if let spriteSheet = spriteSheet {
            // Load sprites from sprite sheet
            var cache: [TerrainType: UIImage] = [:]
            for terrainType in TerrainType.allCases {
                if let sprite = spriteSheet.getTileForTerrain(terrainType) {
                    cache[terrainType] = sprite
                }
            }
            self.spriteCache = cache.isEmpty ? 
                SpriteSheet.getPlaceholderSprites(tileSize: CGSize(width: tileSize, height: tileSize)) : 
                cache
        } else {
            // Use placeholder sprites
            self.spriteCache = SpriteSheet.getPlaceholderSprites(
                tileSize: CGSize(width: tileSize, height: tileSize)
            )
        }
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
