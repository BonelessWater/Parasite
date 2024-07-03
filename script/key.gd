extends Area2D


func _on_body_entered(body):
	if body.has_method('player'):
		Global.key_obtained = true
		Global.key_amount += 1
		queue_free()
