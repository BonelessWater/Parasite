extends Node2D

# Just change these varaibles when making a new drop
@export var ability_name := 'Dash'

# Give player the drop
func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		body.abilities[ability_name] = true
		queue_free()
