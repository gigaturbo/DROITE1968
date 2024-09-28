extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MusiqueTitre.play()
	
	$Titre.show()
	
	$Tuto.hide()


func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	
	$Titre.hide()
	
	$Tuto.show()
	$Tuto.startTuto()


func _on_tuto_end_tuto():
	$Tuto.hide()
