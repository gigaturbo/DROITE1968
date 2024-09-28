extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Titre.show()
	$Tuto.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_titre_start_button_pressed():
	$Titre.hide()
	$Tuto.show()
	
	pass # Replace with function body.
