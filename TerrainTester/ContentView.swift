import SwiftUI

struct ContentView: View {
    @StateObject private var mapGrid: MapGrid
    @State private var generationMode: GenerationMode = .clustered
    
    enum GenerationMode: String, CaseIterable {
        case testPattern = "Test Pattern"
        case random = "Random"
        case clustered = "Clustered"
    }
    
    init() {
        // Initialize with a default map
        let initialMap = TerrainGenerator.generateClusteredTerrain(width: 30, height: 20)
        _mapGrid = StateObject(wrappedValue: initialMap)
    }
    
    var body: some View {
        VStack {
            // Title and controls
            HStack {
                Text("Terrain Tester")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Picker("Generation Mode", selection: $generationMode) {
                    ForEach(GenerationMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(maxWidth: 300)
                
                Button("Regenerate") {
                    regenerateMap()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            
            // Map view
            MapView(mapGrid: mapGrid, tileSize: 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Legend
            HStack(spacing: 20) {
                ForEach(TerrainType.allCases, id: \.self) { terrainType in
                    HStack(spacing: 4) {
                        Rectangle()
                            .fill(colorForTerrain(terrainType))
                            .frame(width: 20, height: 20)
                            .border(Color.black, width: 1)
                        
                        Text(terrainType.description)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
    
    private func regenerateMap() {
        let newMap: MapGrid
        switch generationMode {
        case .testPattern:
            newMap = TerrainGenerator.generateTestPattern(width: 30, height: 20)
        case .random:
            newMap = TerrainGenerator.generateRandomTerrain(width: 30, height: 20)
        case .clustered:
            newMap = TerrainGenerator.generateClusteredTerrain(width: 30, height: 20)
        }
        
        // Update the map
        for y in 0..<mapGrid.height {
            for x in 0..<mapGrid.width {
                if let newTile = newMap.getTile(x: x, y: y) {
                    mapGrid.setTerrain(x: x, y: y, terrainType: newTile.terrainType)
                }
            }
        }
    }
    
    private func colorForTerrain(_ terrainType: TerrainType) -> Color {
        switch terrainType {
        case .grass: return Color(red: 0.2, green: 0.8, blue: 0.2)
        case .water: return Color(red: 0.2, green: 0.4, blue: 0.9)
        case .dirt: return Color(red: 0.6, green: 0.4, blue: 0.2)
        case .stone: return Color(red: 0.5, green: 0.5, blue: 0.5)
        case .sand: return Color(red: 0.9, green: 0.8, blue: 0.5)
        case .forest: return Color(red: 0.1, green: 0.5, blue: 0.1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
