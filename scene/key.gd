extends Area2D


func _on_body_entered(body):
	if body.has_method('player'):
		body.keyObtained = true
		queue_free()
