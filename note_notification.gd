extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.note1:
		$RichTextLabel.visible = true
		
		


func _on_timer_timeout():
	$RichTextLabel.visible = false
