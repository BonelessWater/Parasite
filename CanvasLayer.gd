extends CanvasLayer

# Variable to track whether the menu is active
var menu_active = true

var game_scene = preload("res://scene/game.tscn")
var event = false
func _ready():
	# Initially hide the menu
	hide()
	
	# Connect buttons to their functions
	#$MenuControl/ResumeButton.callable("pressed", self, "_on_ResumeButton_pressed")
	#$MenuControl/OptionsButton.callable("pressed", self, "_on_OptionsButton_pressed")
	#$MenuControl/ExitButton.callable("pressed", self, "_on_ExitButton_pressed")

# Function to toggle the menu
func toggle_menu():
	if menu_active:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
	menu_active = !menu_active

# Button pressed functions
func _on_ResumeButton_pressed():
	toggle_menu()

func _on_OptionsButton_pressed():
	# Open options menu (implement your options logic here)
	print("Opening options...")

func _on_ExitButton_pressed():
	# Exit to main menu or quit the game
	get_tree().quit()

func _on_resume_pressed():
	toggle_menu()

func _on_quit_pressed():
	get_tree().quit()
# Handle input for toggling the menu
func _input(event):
	if Input.is_action_just_pressed("menusito"):  # Assuming 'ui_cancel' is mapped to the key you want to use
		toggle_menu()
