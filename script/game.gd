extends Node2D

var tutorial
var tutorialPath
var level1
var level1Path
var level2
var level3
var change_level = true
var level_status

func _ready():
	tutorialPath = preload('res://scene/Levels/tutorial.tscn')
	level1Path = preload('res://scene/Levels/level_1.tscn')
	
	menu_ui()

func menu_ui():
	# Causes tutorial to be run first
	# Later I can add menu UI to do this
	level_status = 'Tutorial'
	
func _process(_delta):
	if change_level:
		 # makes sure that all the levels have stopped no matter 
		
		if level_status == 'Tutorial':
			tutorial = tutorialPath.instantiate()
			add_child(tutorial)
			tutorial.startup()
			change_level = false
		elif level_status == 'Level1':
			tutorial.end()
			tutorial.queue_free()
			level1.startup()
			change_level = false
	
	
		
