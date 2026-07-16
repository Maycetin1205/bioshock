# Architecture

## Goal

Build a maintainable first-person immersive sim whose placeholder level and visuals can be replaced without rewriting gameplay code.

## Rules

1. **Composition over inheritance.** Health, energy and future status effects are reusable child components.
2. **Scenes own presentation.** Scripts expose behavior; production meshes, sounds and animation belong in scenes and resources.
3. **No direct UI dependencies.** Gameplay publishes state through `GameEvents`; the HUD subscribes to it.
4. **Small interaction contract.** An interactable implements `get_interaction_prompt(actor)` and `interact(actor)`.
5. **Typed damage contract.** Weapons, abilities and enemies exchange `DamagePacket` objects. `apply_damage` remains only as a compatibility entrypoint.
6. **Prototype generation stays isolated.** `src/prototype/prototype_level.gd` creates the current greybox and may later be deleted without changing core systems.
7. **Input actions are stable identifiers.** `InputBootstrap` supplies defaults while a later settings UI can remap the same actions.
8. **State transitions are explicit.** Enemy behavior changes through one state setter, making animation, audio and debugging hooks straightforward to add.

## Main modules

- `src/core`: cross-cutting signals and startup configuration
- `src/components`: reusable stateful building blocks
- `src/combat`: damage packets and weapons
- `src/player`: locomotion and interaction targeting
- `src/abilities`: player powers and their resource costs
- `src/world`: reusable interactive level objects and pickups
- `src/enemies`: state-driven enemy behavior built against public player contracts
- `src/ui`: event-driven presentation
- `src/prototype`: temporary greybox content only

## Combat flow

1. An attack creates a `DamagePacket` with amount, damage type, source and optional hit data.
2. The receiver handles `apply_damage_packet(packet)` without knowing the concrete weapon or attacker class.
3. Health remains a generic component and reports state changes or death.
4. Presentation events such as ammunition, reload state and hit confirmation travel through `GameEvents`.

This keeps future resistances, armor, critical hits and status effects out of weapon-specific code.

## Next architectural additions

- resistance and armor components keyed by damage type
- data-driven weapon and ability definitions
- save-game IDs and versioned save data
- inventory and weapon slots
- NavigationServer-based enemy movement
- audio event service and subtitle pipeline
- objective graph and checkpoint service
