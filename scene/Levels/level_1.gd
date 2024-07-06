extends Node2D
var skilltree = preload ("res://scene/UI/skill_tree.tscn").instantiate()
var playerPath = preload('res://scene/Entities/player.tscn')
var player 
var player_pos 
var process = false
var notes = preload("res://scene/Notes/note1.tscn").instantiate()
func startup():
	process = true
	# Makes player node in tutorial
	player = playerPath.instantiate()
	add_child(player)
	player = $Player
	
	player_pos = Vector2(250, 150)
	player.set_position(player_pos)
	
	# Add mobs and other items here

func end():
	process = false
	get_node('player').queue_free()
	
func _process(delta):
	if process:
		player.movement(delta)
		player.input(delta)
		
	if Input.is_action_just_pressed("skill_tree"):
		get_tree().root.add_child(skilltree)
		queue_free()
		Global.level_status = 'Level1'
	if Input.is_action_just_pressed('notes'):
		get_tree().root.add_child(notes)
		queue_free()
