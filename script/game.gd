extends Node2D

# BALANCING VARIABLES

# player
@export var movement_speed := 15000.0
@export var max_health := 100.0
@export var stamina := 5
@export var max_sprint := 2

# abilities
var is_dashing := false
@export var max_dash_speed := 20.0
@export var dash_length := 0.15
@export var dash_cooldown := 1

var dash_speed := 1

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

func _ready():
	tutorial = get_node('Tutorial')
	level1 = get_node('Level1')
	level2 = get_node('Level2')
	level3 = get_node('Level3')
	
	menu_ui()

func menu_ui():
	# Causes tutorial to be run first
	# Later I can add menu UI to do this
	level_status = 'Tutorial'
	
func _process(_delta):

	if change_level:
		if level_status == 'Tutorial':
			tutorial.startup()
			
			change_level = false
		# add if statements for other levels
