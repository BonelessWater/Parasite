extends Node2D

var hitbox
var bubble_radius
var player_radius
var player_height
var player_hitbox_r
var player_hitbox_h
var bubble_on := false
var bubble_cooldown
var bubble_duration

@onready var cooldown = get_parent().get_parent().get_parent().get_node('Abilities/Bubble/Cooldown')
@onready var duration = get_parent().get_parent().get_parent().get_node('Abilities/Bubble/Duration')

func _ready():
	# Setting up timer
	bubble_cooldown = Global.bubble_cooldown
	cooldown.set_wait_time(bubble_cooldown)
	cooldown.set_one_shot(true)
	# Setting up timer
	bubble_duration = Global.bubble_duration
	duration.set_wait_time(bubble_duration)
	duration.set_one_shot(true)
	
func _process(_delta):
	if Global.bubble_on and cooldown.time_left <= 0.05:
		Global.give_bubble_health = true
		
		cooldown.start()
		duration.start()
		
	if duration.time_left >= 0.10:
		Global.player_hitbox_r = Global.bubble_radius
		Global.player_hitbox_h = Global.bubble_radius
	else:
		Global.player_hitbox_r = Global.player_radius
		Global.player_hitbox_h = Global.player_height
		Global.bubble_on = false
