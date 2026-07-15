# Abyssal Protocol

A modular Godot 4 first-person immersive-sim prototype inspired by the systemic design of games such as *BioShock*, while using an original setting, story, characters, art and audio.

## Current vertical slice

- first-person movement, sprinting, jumping and mouse capture
- reusable health and energy components
- interaction ray with contextual prompts
- electric ability that consumes energy, damages and stuns targets
- powered door and power switch gameplay objects
- simple enemy detection, chase and melee attack loop
- event-driven HUD for health, energy, objectives and notifications
- generated greybox level requiring no external assets

## Run

1. Install Godot 4.3 or newer.
2. Import `project.godot`.
3. Press **F6/F5** to run the main scene.

### Controls

| Action | Input |
|---|---|
| Move | WASD or arrow keys |
| Sprint | Shift |
| Jump | Space |
| Interact | E |
| Electric burst | Left mouse button |
| Release/capture mouse | Escape |

## Architecture

The prototype level is disposable; the gameplay modules are not. Systems communicate through components, small public methods and the `GameEvents` signal bus. See [`docs/architecture.md`](docs/architecture.md) before extending the project.

## Originality requirement

Do not copy BioShock names, characters, story, levels, logos, audio, models, textures or other protected assets. The project should retain only broad genre ideas such as immersive-sim interaction, environmental storytelling and combinations of weapons, powers and world systems.
