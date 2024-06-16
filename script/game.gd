extends Node2D

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
