extends Node2D

# Give player the drop
func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		body.weapons['Pistol'] = true
		queue_free()
