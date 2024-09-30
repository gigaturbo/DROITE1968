extends Node2D

signal exitCredits

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.hide()
	$TextureButton.hide()

func init():
	$Sprite2D.show()
	$TextureButton.show()

func _on_texture_button_pressed():
	$Sprite2D.hide()
	$TextureButton.hide()
	exitCredits.emit()
