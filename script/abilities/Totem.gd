extends Node2D

func _process(_delta):	
	if Global.consumable_amount_totem ==0:
		Global.totem = false
