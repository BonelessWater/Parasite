extends Node2D

# Just change these varaibles when making a new drop
@export var ability_name := 'Dash'
@export var consumable := false

# Give player the drop
func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		Global.abilities[ability_name] = true
		
		if consumable == true and ability_name == 'totem':
			Global.consumables[ability_name] = true
			Global.consumable_amount_totem += 1
		queue_free()
