import Foundation

/// Manages the 2D grid of tiles that make up the world map
class MapGrid: ObservableObject {
    @Published var tiles: [[Tile]]
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        // Initialize with empty grass tiles
        self.tiles = []
        for y in 0..<height {
            var row: [Tile] = []
            for x in 0..<width {
                row.append(Tile(x: x, y: y, terrainType: .grass))
            }
            self.tiles.append(row)
        }
    }
    
    /// Get tile at specific coordinates
    func getTile(x: Int, y: Int) -> Tile? {
        guard x >= 0 && x < width && y >= 0 && y < height else {
            return nil
        }
        return tiles[y][x]
    }
    
    /// Set terrain type for a specific tile
    func setTerrain(x: Int, y: Int, terrainType: TerrainType) {
        guard x >= 0 && x < width && y >= 0 && y < height else {
            return
        }
        tiles[y][x].terrainType = terrainType
    }
    
    /// Get all tiles as a flat array
    func getAllTiles() -> [Tile] {
        return tiles.flatMap { $0 }
    }
}
