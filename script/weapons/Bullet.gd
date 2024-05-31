extends CharacterBody2D

var projectile_speed
var attack_damage
var attack_range
var spread
var spread_range
var spread_angle
var bullets_spread
var knockback
var weapon_type

func _ready():
	attack_damage = get_parent().get_parent().get_node('Objects/' + weapon_type).attack_damage

func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * projectile_speed)
	
func _on_hitbox_body_entered(body):
	if body.has_method('mob'):
		if body.get_node('HealthComponent').has_method('damage'):
			body.get_node('HealthComponent').damage(attack_damage, knockback)
			queue_free()
		queue_free()
