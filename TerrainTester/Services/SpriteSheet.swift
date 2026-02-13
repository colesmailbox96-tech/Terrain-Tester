import UIKit
import SwiftUI

/// Manages sprite sheet loading and tile extraction
class SpriteSheet {
    private let image: UIImage
    private let tileSize: CGSize
    private let tilesPerRow: Int
    
    init?(imageName: String, tileSize: CGSize, tilesPerRow: Int) {
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        self.image = image
        self.tileSize = tileSize
        self.tilesPerRow = tilesPerRow
    }
    
    /// Extract a specific tile from the sprite sheet by index
    func getTile(at index: Int) -> UIImage? {
        let row = index / tilesPerRow
        let col = index % tilesPerRow
        
        let x = CGFloat(col) * tileSize.width
        let y = CGFloat(row) * tileSize.height
        
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let scale = image.scale
        let rect = CGRect(
            x: x * scale,
            y: y * scale,
            width: tileSize.width * scale,
            height: tileSize.height * scale
        )
        
        guard let croppedImage = cgImage.cropping(to: rect) else {
            return nil
        }
        
        return UIImage(cgImage: croppedImage, scale: scale, orientation: image.imageOrientation)
    }
    
    /// Get tile for a specific terrain type
    func getTileForTerrain(_ terrainType: TerrainType) -> UIImage? {
        return getTile(at: terrainType.spriteIndex)
    }
    
    /// Generate a colored square as a placeholder sprite
    static func generatePlaceholderTile(color: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            // Add border
            UIColor.black.setStroke()
            context.stroke(CGRect(origin: .zero, size: size), width: 2)
        }
    }
    
    /// Get placeholder sprites for all terrain types when sprite sheet is not available
    static func getPlaceholderSprites(tileSize: CGSize) -> [TerrainType: UIImage] {
        return [
            .grass: generatePlaceholderTile(color: UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0), size: tileSize),
            .water: generatePlaceholderTile(color: UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1.0), size: tileSize),
            .dirt: generatePlaceholderTile(color: UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0), size: tileSize),
            .stone: generatePlaceholderTile(color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), size: tileSize),
            .sand: generatePlaceholderTile(color: UIColor(red: 0.9, green: 0.8, blue: 0.5, alpha: 1.0), size: tileSize),
            .forest: generatePlaceholderTile(color: UIColor(red: 0.1, green: 0.5, blue: 0.1, alpha: 1.0), size: tileSize)
        ]
    }
}
