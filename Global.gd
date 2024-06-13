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

# abilities

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

@export var health := 100
