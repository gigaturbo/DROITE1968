extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initial state
	$MusiqueTitre.play()
	$Titre.show()
	$Tuto.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	$Titre.hide()
	$Tuto.show()
	
	pass # Replace with function body.
