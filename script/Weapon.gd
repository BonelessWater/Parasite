extends Node2D

# Make an instanse of weapon and remember to set the desired texture path
const bulletPath = preload('res://scene/bullet.tscn')
var game_node
var level

var aim: Vector2
var bullet_spawn_from_player := 50

var attack_damage := 10.0
var attack_speed := 0.1
var attack_range := 10.0
var projectile_speed := 100.0
var knockback := 10.0

# Shotgun/special weapon
var spread := 10.0
var spread_range := 10.0
var spread_angle := PI/4
var bullets_spread := 3

var timer
var attacking = false

func _ready():
	timer = get_node('Timer')
	timer.set_wait_time(attack_speed)
	timer.set_autostart(false)
	timer.set_one_shot(true)
	
	game_node = get_parent().get_parent()
	# This is broken, please fix
	level = game_node.level_status
	level = 'Tutorial'

func use(_delta):
	if timer.time_left == 0:
		timer.start()
		
		var bullet = bulletPath.instantiate()
		
		# Give bullet variable properties
		bullet.attack_damage = attack_damage
		bullet.attack_range = attack_range
		bullet.projectile_speed = projectile_speed
		bullet.knockback = knockback
		
		# Spread logic will be dealth with later
		bullet.spread = spread
		bullet.spread_range = spread_range
		bullet.spread_angle = spread_angle
		bullet.bullets_spread = bullets_spread
		
		game_node.get_node(level).add_child(bullet)
		aim = (get_global_mouse_position() - game_node.get_node(level + '/Player').position)
		aim = aim.normalized()
		bullet.position = game_node.get_node(level + '/Player').position + aim * bullet_spawn_from_player
		
		
		bullet.velocity = get_global_mouse_position() - bullet.position
		
		if bullet.velocity.x > 0:
			bullet.rotation = atan(bullet.velocity.y/bullet.velocity.x)
		else:
			bullet.rotation = atan(bullet.velocity.y/bullet.velocity.x) + PI
		
