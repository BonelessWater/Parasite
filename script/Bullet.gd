extends CharacterBody2D

var projectile_speed
var attack_damage
var attack_range
var spread
var spread_range
var spread_angle
var bullets_spread
var knockback



func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * projectile_speed)
	
func _on_hitbox_body_entered(body):
	if body.has_method('damage'):
		body.damage(attack_damage, knockback)
		queue_free()
	queue_free()
