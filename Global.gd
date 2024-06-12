extends Node
# player
@export var movement_speed := 30000.0
@export var max_health := 100.0
@export var stamina := 5
@export var max_sprint := 2

# abilities

# dash
var is_dashing := false
@export var max_dash_speed := 40.0
@export var dash_length := 0.075
@export var dash_cooldown := 1
var dash_speed := 1

# bubble
var bubble_on := false
@export var bubble_health := 30
@export var bubble_cooldown := 1
@export var bubble_radius := 50 # not used but is an interesing balancing point


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
