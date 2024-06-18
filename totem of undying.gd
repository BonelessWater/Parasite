extends Node2D

var consumable_name = 'totem'


func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		Global.consumables[consumable_name] = true
		Global.consumable_amount_totem += 1
		Global
		queue_free()



