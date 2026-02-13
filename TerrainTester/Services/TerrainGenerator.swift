import Foundation

/// Generates terrain for the map using various algorithms
class TerrainGenerator {
    
    /// Generate a simple random terrain map
    static func generateRandomTerrain(width: Int, height: Int) -> MapGrid {
        let map = MapGrid(width: width, height: height)
        
        for y in 0..<height {
            for x in 0..<width {
                // Random terrain selection
                let randomValue = Double.random(in: 0...1)
                let terrainType: TerrainType
                
                if randomValue < 0.4 {
                    terrainType = .grass
                } else if randomValue < 0.5 {
                    terrainType = .water
                } else if randomValue < 0.7 {
                    terrainType = .dirt
                } else if randomValue < 0.85 {
                    terrainType = .forest
                } else if randomValue < 0.95 {
                    terrainType = .sand
                } else {
                    terrainType = .stone
                }
                
                map.setTerrain(x: x, y: y, terrainType: terrainType)
            }
        }
        
        return map
    }
    
    /// Generate terrain with simple noise-like clustering
    static func generateClusteredTerrain(width: Int, height: Int) -> MapGrid {
        let map = MapGrid(width: width, height: height)
        
        // Create some water bodies
        let numWaterBodies = 3
        for _ in 0..<numWaterBodies {
            let centerX = Int.random(in: 0..<width)
            let centerY = Int.random(in: 0..<height)
            let radius = Int.random(in: 2...5)
            
            for y in max(0, centerY - radius)..<min(height, centerY + radius) {
                for x in max(0, centerX - radius)..<min(width, centerX + radius) {
                    let distance = sqrt(pow(Double(x - centerX), 2) + pow(Double(y - centerY), 2))
                    if distance < Double(radius) {
                        map.setTerrain(x: x, y: y, terrainType: .water)
                    }
                }
            }
        }
        
        // Add some forests
        let numForests = 4
        for _ in 0..<numForests {
            let centerX = Int.random(in: 0..<width)
            let centerY = Int.random(in: 0..<height)
            let radius = Int.random(in: 2...4)
            
            for y in max(0, centerY - radius)..<min(height, centerY + radius) {
                for x in max(0, centerX - radius)..<min(width, centerX + radius) {
                    if map.getTile(x: x, y: y)?.terrainType != .water {
                        let distance = sqrt(pow(Double(x - centerX), 2) + pow(Double(y - centerY), 2))
                        if distance < Double(radius) {
                            map.setTerrain(x: x, y: y, terrainType: .forest)
                        }
                    }
                }
            }
        }
        
        // Add some dirt patches
        let numDirtPatches = 5
        for _ in 0..<numDirtPatches {
            let x = Int.random(in: 0..<width)
            let y = Int.random(in: 0..<height)
            if map.getTile(x: x, y: y)?.terrainType == .grass {
                map.setTerrain(x: x, y: y, terrainType: .dirt)
            }
        }
        
        // Add some stone outcrops
        let numStoneOutcrops = 3
        for _ in 0..<numStoneOutcrops {
            let x = Int.random(in: 0..<width)
            let y = Int.random(in: 0..<height)
            map.setTerrain(x: x, y: y, terrainType: .stone)
        }
        
        return map
    }
    
    /// Generate a simple test pattern for debugging
    static func generateTestPattern(width: Int, height: Int) -> MapGrid {
        let map = MapGrid(width: width, height: height)
        
        for y in 0..<height {
            for x in 0..<width {
                let terrainType: TerrainType
                
                // Create a diagonal pattern
                let sum = (x + y) % 6
                switch sum {
                case 0: terrainType = .grass
                case 1: terrainType = .water
                case 2: terrainType = .dirt
                case 3: terrainType = .stone
                case 4: terrainType = .sand
                default: terrainType = .forest
                }
                
                map.setTerrain(x: x, y: y, terrainType: terrainType)
            }
        }
        
        return map
    }
}
