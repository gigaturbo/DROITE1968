extends Node2D

@export var mainScene : PackedScene

signal startButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_texture_buttoncustom_pressed():
	startButtonPressed.emit()
	pass # Replace with function body.



# a virer plus tard
func _unhandled_input(event):
	if event.is_action_pressed("A_button"):
		
		DialogManager.start_dialog(Vector2(200, 300), 
			Vector2(500,150), 
			DialogManager.TextBoxTypes.REPONSE,
			["t'es qui ?"])
		DialogManager.buttonPressed.connect(reponse)
		
		DialogManager2.start_dialog(Vector2(200, 300) + Vector2(0, 300), 
			Vector2(500,150), 
			DialogManager2.TextBoxTypes.REPONSE,
			["test ^^"])
		DialogManager2.buttonPressed.connect(reponse)

func reponse(oneDialogManager):
	print(oneDialogManager.text_box.text)


