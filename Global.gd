extends Node
@export var movement_speed := 15000.0
@export var stamina := 5
@export var max_sprint := 2
var health = 100
var max_health := 100.0
var simultaneous_scene2 = preload("res://scene/skill_tree.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
