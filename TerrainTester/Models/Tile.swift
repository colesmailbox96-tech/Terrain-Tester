import Foundation

/// Represents a single tile in the 2D world map
struct Tile: Identifiable {
    let id = UUID()
    let x: Int
    let y: Int
    var terrainType: TerrainType
    
    init(x: Int, y: Int, terrainType: TerrainType) {
        self.x = x
        self.y = y
        self.terrainType = terrainType
    }
}
