extends Node2D

var playerPath = preload('res://scene/player.tscn')
var player 
var player_pos 
var begin_process := false

func startup():
	begin_process = true
	# Makes player node in tutorial
	player = playerPath.instantiate()
	add_child(player)
	player = $Player
	
	player_pos = Vector2(250, 150)
	player.set_position(player_pos)
	
func _process(delta):
	if begin_process:
		player.movement(delta)
		player.input(delta)
