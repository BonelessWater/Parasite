extends Node2D

var ability_name = 'Bulldozer'


func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		Global.abilities[ability_name] = true
		queue_free()
		

