extends Node2D

@export var mainScene : PackedScene

signal startButtonPressed
signal creditButtonPressed
signal quitterButtonPressed
signal histoireButtonPressed

func _on_start_pressed():
	startButtonPressed.emit()

func _on_credits_pressed():
	creditButtonPressed.emit()

func _on_quitter_pressed():
	quitterButtonPressed.emit()
	get_tree().quit()

func _on_histoire_pressed() -> void:
	histoireButtonPressed.emit()
