extends Node

signal interaction_prompt_changed(text: String)
signal player_health_changed(current: float, maximum: float)
signal player_energy_changed(current: float, maximum: float)
signal weapon_ammo_changed(in_magazine: int, reserve: int)
signal weapon_reload_changed(is_reloading: bool)
signal hit_confirmed(applied_damage: float)
signal objective_changed(text: String)
signal notification_requested(text: String)
signal ability_used(ability_id: StringName)
