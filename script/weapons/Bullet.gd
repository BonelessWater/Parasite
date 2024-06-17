extends CharacterBody2D

var projectile_speed
var attack_damage
var attack_range
var spread
var spread_range
var spread_angle
var bullets_spread
var knockback := 1000000
var weapon_name
var bullet_dir

func _ready():
	attack_damage = get_parent().get_parent().get_node('Objects/' + weapon_name).attack_damage

func _physics_process(delta):
	var _collision_info = move_and_collide(velocity.normalized() * delta * projectile_speed)
	
func _on_hitbox_body_entered(body):
	if body.has_method('mob'):
		if body.get_node('HealthComponent').has_method('damage'):
			bullet_dir = velocity.normalized()
			body.get_node('HealthComponent').damage(attack_damage, knockback, bullet_dir)
			queue_free()
	if body.has_method('wall'):
		queue_free()
	if body.has_method('door'):
		queue_free()
