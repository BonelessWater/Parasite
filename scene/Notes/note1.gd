extends Control

var x = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.note1 == true:
		$"VBoxContainer/Note 1".visible = true


func _on_note_1_pressed():
	x +=1
	if x%2 == 0:
		$"VBoxContainer/Note 1/Label".visible = true
		$"VBoxContainer/Note 1/Label/Panel".visible = true
	else:
		$"VBoxContainer/Note 1/Label".visible = false
		$"VBoxContainer/Note 1/Label/Panel".visible = false
