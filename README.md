# Abyssal Protocol

A modular Godot 4 first-person immersive-sim prototype inspired by the systemic design of games such as *BioShock*, while using an original setting, story, characters, art and audio.

## Current vertical slice

- first-person movement, sprinting, jumping and mouse capture
- reusable health and energy components
- interaction ray with contextual prompts
- hitscan sidearm with ammunition, reload timing, recoil and hit confirmation
- electric ability that consumes energy, damages and stuns targets
- shared typed damage packets for weapons, abilities and enemy attacks
- enemy state machine with idle, suspicious, chase, attack, stun and death states
- powered door, power switch and ammunition pickup gameplay objects
- event-driven HUD for health, energy, ammunition, objectives and notifications
- generated greybox encounter requiring no external assets

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
| Fire sidearm | Left mouse button |
| Electric burst | Right mouse button |
| Reload | R |
| Release/capture mouse | Escape |

## Architecture

The prototype level is disposable; the gameplay modules are not. Systems communicate through components, small public methods, typed damage packets and the `GameEvents` signal bus. See [`docs/architecture.md`](docs/architecture.md) before extending the project.

## Originality requirement

Do not copy BioShock names, characters, story, levels, logos, audio, models, textures or other protected assets. The project should retain only broad genre ideas such as immersive-sim interaction, environmental storytelling and combinations of weapons, powers and world systems.
