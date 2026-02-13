import Foundation

/// Represents different types of terrain in the 2D world
enum TerrainType: Int, CaseIterable {
    case grass = 0
    case water = 1
    case dirt = 2
    case stone = 3
    case sand = 4
    case forest = 5
    
    /// Returns the sprite index in the sprite sheet for this terrain type
    var spriteIndex: Int {
        return self.rawValue
    }
    
    /// Returns a description of the terrain type
    var description: String {
        switch self {
        case .grass: return "Grass"
        case .water: return "Water"
        case .dirt: return "Dirt"
        case .stone: return "Stone"
        case .sand: return "Sand"
        case .forest: return "Forest"
        }
    }
}
