class_name DamagePacket
extends RefCounted

enum DamageType {
	KINETIC,
	ELECTRIC,
	FIRE,
	EXPLOSIVE,
	MELEE,
}

var amount: float = 0.0
var damage_type: int = DamageType.KINETIC
var source: Node
var hit_position: Vector3 = Vector3.ZERO
var hit_normal: Vector3 = Vector3.ZERO


func _init(
	p_amount: float = 0.0,
	p_damage_type: int = DamageType.KINETIC,
	p_source: Node = null,
	p_hit_position: Vector3 = Vector3.ZERO,
	p_hit_normal: Vector3 = Vector3.ZERO
) -> void:
	amount = maxf(0.0, p_amount)
	damage_type = p_damage_type
	source = p_source
	hit_position = p_hit_position
	hit_normal = p_hit_normal
