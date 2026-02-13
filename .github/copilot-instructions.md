# Pixel World Simulator (iOS)

A 2D pixel-art world simulation game for iPhone using Swift/SpriteKit. Think Dwarf Fortress meets Stardew Valley in visual style.

## Tech Stack

- **Language**: Swift
- **Framework**: SpriteKit (for 2D rendering and game loop)
- **ML Framework**: CoreML (for on-device inference in later phases)
- **Platform**: iOS (iPhone)
- **Architecture**: Modular, data-driven simulation engine separated from rendering

## Project Phases

### Phase 1 — Foundation (Current Phase)

Build the basic world and NPC systems:

- Tile-based 2D world with procedural terrain generation (grass, water, trees, stone)
- Camera system with pan/zoom for touch input
- Basic day/night cycle
- Sprite-based NPCs that can move around the world, pathfind (A*), and interact with objects
- Simple needs system (hunger, rest, social) driving NPC behavior via behavior trees

### Phase 2 — Intelligence Layer

Replace simple systems with learning-based AI:

- Replace behavior trees with a neural network-based decision system per NPC
- NPCs learn from their environment and outcomes (reinforcement learning)
- Persistent memory per NPC (experiences shape future decisions)
- Emergent social dynamics: NPCs form opinions of each other based on interactions

### Phase 3 — Emergent Complexity

Enable sophisticated emergent behaviors:

- NPCs develop distinct personalities over time through learned weights
- Language/communication system between NPCs
- Long-term goal formation and planning
- Self-organizing social structures (trade, alliances, conflict)

## Architecture Guidelines

### Core Principles

- **Separation of Concerns**: Keep the simulation engine cleanly separated from rendering. Game logic should not depend on SpriteKit view code.
- **Modular NPC Brains**: Design NPC "brains" as a modular, swappable component from day one. Even if Phase 1 uses simple behavior trees, the interface should anticipate neural network replacement.
- **Data-Driven Design**: NPC state, world state, and interactions should all be logged in a way that can serve as training data later. Use structured data formats (JSON, Core Data, or similar).
- **On-Device ML**: Use CoreML for on-device inference when the ML layer is introduced. Design with performance constraints in mind.

### Code Organization

```
/Engine          # Simulation engine (model layer)
  /World         # World generation, tile management
  /NPCs          # NPC state, AI, pathfinding
  /Systems       # Day/night, needs, interactions
/Rendering       # SpriteKit views and rendering
/AI              # Behavior trees (Phase 1) → Neural nets (Phase 2+)
/Data            # Logging, persistence, training data
```

### Coding Conventions

- Use Swift's modern concurrency features (async/await) for simulation updates
- Follow Swift API Design Guidelines for naming
- Prefer protocols and dependency injection for swappable components (especially AI)
- Use value types (structs) for world/NPC state where appropriate
- Document complex algorithms (pathfinding, behavior trees, RL) with inline comments
- Keep game loop at consistent 60 FPS; offload heavy computation to background threads

### NPC AI Interface

From the start, design NPC brains with this contract:

```swift
protocol NPCBrain {
    func decide(for npc: NPC, in world: World) -> Action
    func learn(from outcome: Outcome, for npc: NPC)
}
```

Phase 1 implements with behavior trees; Phase 2+ replaces with neural networks.

### Data Logging

Log all significant events for future training:

- NPC decisions and outcomes
- Social interactions
- Resource consumption
- World changes
- Time-series data for learning

## Testing Priorities

- Unit test world generation algorithms
- Test pathfinding correctness and performance
- Test NPC behavior tree logic
- Test day/night cycle timing
- Validate rendering performance on target devices
- Profile memory usage for large NPC populations

## Common Patterns

### Procedural Generation

Use seeded random number generators for reproducible terrain generation.

### Pathfinding

Implement A* with a priority queue. Cache paths where appropriate. Consider hierarchical pathfinding for large maps.

### State Machines

Use enums with associated values for NPC states:

```swift
enum NPCState {
    case idle
    case moving(to: TilePosition)
    case interacting(with: WorldObject)
    case sleeping(duration: TimeInterval)
}
```

### Performance

- Use spatial partitioning (quadtree or grid) for NPC queries
- Batch SpriteKit updates where possible
- Profile regularly on actual devices
- Consider LOD (level of detail) for distant NPCs

## Getting Started

Start with Phase 1. Get a walkable world with NPCs that feel alive through simple systems first, then layer intelligence on top.

Focus on:
1. Solid foundation with clean architecture
2. Separation of simulation and rendering
3. Modular AI interface ready for future enhancement
4. Data collection infrastructure for later ML phases
