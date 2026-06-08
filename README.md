# The Haunted Cabin

A 3D horror game built with Godot where a group of friends must solve a ghost's mystery to survive the night.

## Story

You and your friends have stayed in an old cabin in the woods for the weekend. But the cabin holds a dark secret - it's haunted by the ghost of a previous occupant. To survive the night and escape the haunting, you must:

1. **Find clues** scattered throughout the cabin
2. **Solve puzzles** that reveal the ghost's tragic story
3. **Uncover the mystery** before dawn breaks

The longer you stay, the angrier the ghost becomes. Manage your sanity and courage as supernatural events unfold around you.

## Features

- **3D First-Person Horror Experience**: Explore a detailed cabin environment
- **Ghost AI System**: Dynamic ghost appearances and haunting events
- **Puzzle System**: Multi-step puzzles to uncover the mystery
- **Sanity/Scare System**: Player fear level affects gameplay
- **Environmental Storytelling**: Clues hidden throughout the cabin
- **Multiple Endings**: Based on whether you solve the mystery

## Game Mechanics

### Player Controls
- **WASD**: Move around the cabin
- **Mouse**: Look around
- **Shift**: Run (uses stamina)
- **Space**: Jump
- **E**: Interact with objects/clues
- **ESC**: Pause/Exit

### Core Systems

1. **Ghost Manager**: Controls supernatural events, appearances, and scare tactics
2. **Puzzle System**: Three main puzzles to solve the mystery
3. **Game Manager**: Tracks time, mystery progress, and game state
4. **HUD**: Displays time remaining and scare level

## Project Structure

```
haunt-cabin/
├── scenes/
│   ├── main/
│   │   └── main.tscn          # Main game scene
│   ├── player/
│   │   └── player.tscn        # Player character
│   ├── cabin/
│   │   └── cabin.tscn         # Cabin environment
│   └── ghost/
│       └── ghost.tscn         # Ghost character
├── scripts/
│   ├── player/
│   │   └── player_controller.gd
│   ├── ghost/
│   │   └── ghost_manager.gd
│   ├── game/
│   │   └── game_manager.gd
│   ├── puzzles/
│   │   └── puzzle_system.gd
│   └── ui/
│       └── hud.gd
├── assets/
│   ├── audio/
│   ├── models/
│   └── textures/
└── project.godot
```

## Getting Started

1. Install [Godot 4.0+](https://godotengine.org/download)
2. Clone this repository
3. Open the project in Godot
4. Press F5 to run the game

## Development Roadmap

- [ ] Build cabin 3D environment
- [ ] Implement player character
- [ ] Add ghost character with animations
- [ ] Create puzzle scenes
- [ ] Add audio (ambient, jump scares, music)
- [ ] Implement HUD and UI
- [ ] Add multiple endings
- [ ] Polish and playtesting

## Horror Design Philosophy

- **Atmosphere over action**: Dread comes from immersion and sound
- **Player vulnerability**: Limited resources and no combat
- **The unknown**: Suggestion is scarier than showing everything
- **Pacing**: Quiet moments followed by sudden scares
- **Environmental storytelling**: World tells the story

## License

MIT License
