extends Node
# player
@export var movement_speed := 30000.0
@export var max_health := 50.0
@export var stamina := 5
@export var max_sprint := 2
@export var player_radius := 19 # radius of player hitbox
@export var player_height := 52
@onready var player_hitbox_r = player_radius
@onready var player_hitbox_h = player_height
var last_vel
var invul := false # abreviation for invulnerable: if the player is not able to take damage
var wall_col
var door_col

# WEAPONS
var weapon_name
var set_gun_timer := false
# pistol
@export var pistol_damage := 10.0
@export var pistol_firerate := 0.1
@export var pistol_range := 10.0
@export var pistol_speed := 500.0
@export var pistol_knockback := 10.0

# shotgun
@export var shotgun_damage := 10.0
@export var shotgun_firerate := 0.1
@export var shotgun_range := 10.0
@export var shotgun_speed := 500.0
@export var shotgun_knockback := 10.0

@export var shotgun_spread_angle := PI/5 
@export var shotgun_num_bullets := 3




# abilities
var abilities := {'Dash': false, 'AOE': false, 'Bubble': false, 'Ram': false, 'Bulldozer': false, 'SlowTime': false}
# dash
var is_dashing := false
@export var max_dash_speed := 40.0
@export var dash_length := 0.075
@export var dash_cooldown := 1
var dash_speed := 1

# bubble
var bubble_on := false
var give_bubble_health := false
@export var bubble_health := 30
@export var bubble_cooldown := 10
@export var bubble_duration := 5
@export var bubble_radius := 100

# ram
var is_ramming := false 
var ram_vel
@export var ram_speed := 10.0
@export var ram_damage := 10.0
@export var ram_cooldown := 1
@export var ram_knockback := 50


#bulldozer
var is_bulldozer := false
var bulldozer_health := 15
var bulldozer_speed := 7500
var bulldozer_wait := 5
var old_health 
var old_speed 
var bulldozer_cooldown := 15

#Slowtime
var slow_time := false
var player_speed_multiplier := 2
var player_speed_mobs :=4
var slow_time_duration := 5
var slow_time_cooldown := 15
var THEWORLD := false
# MOBS

# mob1; we can rename the mob and the variables after we have better designs
@export var mob1_max_health := 50
@export var mob1_speed := 10000
@export var mob1_attack_damage := 10.0
@export var mob1_attack_speed := 1.0
@export var mob1_knockback := 25

var tutorial
var level1
var level2
var level3
var change_level = true
var level_status


