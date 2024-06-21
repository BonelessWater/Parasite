extends Node2D

# Make an instance of weapon and remember to set the desired texture path
const bulletPath = preload('res://scene/bullet.tscn')

var bullet_spawn_from_player := 25

var attack_damage
var attack_speed
var attack_range
var projectile_speed
var knockback

# Shotgun/special weapon
var spread_range := 0.0 # when the bullet will split, zero by default
var spread_angle := 0.0
var num_bullets := 1.0

var timer
var attacking = false

func set_up(): # define variables here
	
	if Global.weapon_name == 'Pistol':
		attack_damage = Global.pistol_damage
		attack_speed = Global.pistol_firerate
		attack_range = Global.pistol_range
		projectile_speed = Global.pistol_speed
		knockback = Global.pistol_knockback
	elif Global.weapon_name == 'Shotgun':
		attack_damage = Global.shotgun_damage
		attack_speed = Global.shotgun_firerate
		attack_range = Global.shotgun_range
		projectile_speed = Global.shotgun_speed
		knockback = Global.shotgun_knockback
		
		spread_angle = Global.shotgun_spread_angle
		num_bullets = Global.shotgun_num_bullets
	
	if num_bullets == TYPE_NIL:
		num_bullets = 1
	if spread_angle == TYPE_NIL:
		spread_angle = 0
	
	timer = get_node('Timer')
	timer.set_wait_time(attack_speed)
	timer.set_autostart(false)
	timer.set_one_shot(true)

func use(_delta):
	if Global.set_gun_timer == true:
		set_up()
		Global.set_gun_timer = false
	
	if timer.time_left == 0:
		timer.start()
		
		var aim_offset
		if spread_angle == 0:
			aim_offset = 0
		else:
			aim_offset = spread_angle / (num_bullets - 1)
		
		for i in range (num_bullets):
			var bullet_offset = -spread_angle/2 + i * aim_offset
			var bullet = bulletPath.instantiate()
			
			# Give bullet variable properties
			bullet.attack_damage = attack_damage
			bullet.attack_range = attack_range
			bullet.projectile_speed = projectile_speed
			bullet.knockback = knockback
		
			# Define weapon type as attribute of the bullet
			bullet.weapon_name = Global.weapon_name
			
			get_parent().get_parent().get_node(Global.level_status).add_child(bullet)
		
			var player = get_parent().get_parent().get_node(Global.level_status + '/Player')
			var aim_angle

			match player.curr_direction:
				'right':
					aim_angle = 0 + bullet_offset
				'left':
					aim_angle = PI + bullet_offset 
				'forward':
					aim_angle = PI/2 + bullet_offset
				'back':
					aim_angle = PI * 3/2 + bullet_offset
			var aim := Vector2(cos(aim_angle), sin(aim_angle))
			bullet.position = player.position + aim * bullet_spawn_from_player
			
			bullet.velocity = aim * projectile_speed
			
			if bullet.velocity.x > 0:
				bullet.rotation = atan(bullet.velocity.y / bullet.velocity.x)
			else:
				bullet.rotation = atan(bullet.velocity.y / bullet.velocity.x) + PI
