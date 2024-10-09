extends Node2D

signal retourPressed


func _on_retour_pressed() -> void:
	retourPressed.emit()
