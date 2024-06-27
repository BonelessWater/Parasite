extends Node
# player
var movement_speed := 30000.0
var max_health := 50.0
var stamina := 5
var max_sprint := 2
var player_radius := 19 # radius of player hitbox
var player_height := 52
@onready var player_hitbox_r = player_radius
@onready var player_hitbox_h = player_height
var last_vel
var invul := false # abreviation for invulnerable: if the player is not able to take damage
var wall_col
var door_col

# WEAPONS
var weapon_name
var weapons = {'Pistol': false, 'Shotgun': false, 'Rifle': false}
var set_gun_timer := false

# pistol
var pistol_damage := 10.0
var pistol_firerate := 0.1
var pistol_range := 10.0
var pistol_speed := 500.0
var pistol_knockback := 10.0

# shotgun
var shotgun_damage := 10.0
var shotgun_firerate := 0.1
var shotgun_range := 10.0
var shotgun_speed := 500.0
var shotgun_knockback := 10.0

var shotgun_spread_angle := PI/15
var shotgun_num_bullets := 3

# abiabilities
var abilities := {'Dash': false, 'AOE': false, 'Bubble': false, 'Ram': false, 'Bulldozer': false, 'SlowTime': false, 'Emp': false}

# dash
var is_dashing := false
var max_dash_speed := 40.0
var dash_length := 0.075
var dash_cooldown := 1
var dash_speed := 1

# bubble
var bubble_on := false
var give_bubble_health := false
var bubble_health := 30
var bubble_cooldown := 10
var bubble_duration := 5
var bubble_radius := 100

# ram
var is_ramming := false 
var ram_vel
var ram_speed := 10.0
var ram_damage := 10.0
var ram_cooldown := 1
var ram_duration := 0.3
var ram_knockback := 50

#bulldozer
var is_bulldozer := false
var bulldozer_health := 15
var bulldozer_speed := 7500
var bulldozer_wait := 5
var old_health := 50
var old_speed : = 30000
var bulldozer_cooldown := 15
var reinhartd := false

#Slowtime
var slow_time := false
var player_speed_multiplier := 4
var player_speed_mobs :=4
var slow_time_duration := 5
var slow_time_cooldown := 15

#emp
var emp_active :=false
var emp_stun := 0
var emp_cooldown := 10
var emp_duration := 3
var emp_throw := false

#consumables
var consumables :=  {'totem': false, 'Splashpot': false}
var consumable_amount_totem := 0 
var consumable_amount_splashpot := 0

#totem
var totem_active := false
var totem_health := 100
var totem := false

# Splashpot
var splashpot_health := 10

# MOBS

# mob1; we can rename the mob and the variables after we have better designs
var mob1_max_health := 50
var mob1_speed := 10000
var mob1_attack_damage := 10.0
var mob1_attack_speed := 1.0
var mob1_knockback := 25

var tutorial
var level1
var level2
var level3
var change_level = true
var level_status
