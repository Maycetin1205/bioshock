# Architecture

## Goal

Build a maintainable first-person immersive sim whose placeholder level and visuals can be replaced without rewriting gameplay code.

## Rules

1. **Composition over inheritance.** Health, energy and future status effects are reusable child components.
2. **Scenes own presentation.** Scripts expose behavior; production meshes, sounds and animation belong in scenes and resources.
3. **No direct UI dependencies.** Gameplay publishes state through `GameEvents`; the HUD subscribes to it.
4. **Small interaction contract.** An interactable implements `get_interaction_prompt(actor)` and `interact(actor)`.
5. **Damage contracts are explicit.** Actors expose methods such as `apply_damage` and `apply_electric_hit` instead of depending on concrete enemy classes.
6. **Prototype generation stays isolated.** `src/prototype/prototype_level.gd` creates the current greybox and may later be deleted without changing core systems.
7. **Input actions are stable identifiers.** `InputBootstrap` supplies defaults while later settings UI can remap the same actions.

## Main modules

- `src/core`: cross-cutting signals and startup configuration
- `src/components`: reusable stateful building blocks
- `src/player`: locomotion and interaction targeting
- `src/abilities`: player powers and their resource costs
- `src/world`: reusable interactive level objects
- `src/enemies`: enemy behavior built against public player contracts
- `src/ui`: event-driven presentation
- `src/prototype`: temporary greybox content only

## Next architectural additions

- data-driven ability resources (`AbilityDefinition`)
- damage types and status-effect components
- save-game IDs and versioned save data
- inventory and weapon slots
- NavigationServer-based enemy movement
- audio event service and subtitle pipeline
- automated headless smoke test in CI
