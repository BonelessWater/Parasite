extends Node2D

# Make an instance of weapon and remember to set the desired texture path
const bulletPath = preload('res://scene/bullet.tscn')
var game_node
var level

var bullet_spawn_from_player := 25

@export var attack_damage := 10.0
@export var attack_speed := 0.1
@export var attack_range := 10.0
@export var projectile_speed := 500.0
@export var knockback := 10.0

# Shotgun/special weapon
@export var spread := 10.0
@export var spread_range := 10.0
@export var spread_angle := PI/4
@export var bullets_spread := 3

var weapon_type = 'Pistol'

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
		
		# Spread logic will be dealt with later
		bullet.spread = spread
		bullet.spread_range = spread_range
		bullet.spread_angle = spread_angle
		bullet.bullets_spread = bullets_spread
		
		# Define weapon type as attribute of the bullet
		bullet.weapon_type = weapon_type
		
		game_node.get_node(level).add_child(bullet)
		
		var player = game_node.get_node(level + '/Player')
		var aim = Vector2.ZERO

		match player.curr_direction:
			'right':
				aim.x = 1
			'left':
				aim.x = -1
			'back':
				aim.y = -1
			'forward':
				aim.y = 1
		
		bullet.position = player.position + aim * bullet_spawn_from_player
		
		bullet.velocity = aim * projectile_speed
		
		if bullet.velocity.x > 0:
			bullet.rotation = atan(bullet.velocity.y / bullet.velocity.x)
		else:
			bullet.rotation = atan(bullet.velocity.y / bullet.velocity.x) + PI
