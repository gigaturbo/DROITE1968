extends Node2D

@export var mainScene : PackedScene

signal startButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_texture_buttoncustom_pressed():
	startButtonPressed.emit()
	pass # Replace with function body.
