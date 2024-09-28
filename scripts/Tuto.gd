extends Node2D

signal endTuto

@onready var bubble = $SpeechBubble
@onready var part1 = $Part1


var histState = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	bubble.hide()
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	match histState:
		0:
			if event is InputEventMouseButton:
				if event.is_pressed():
					if event.button_index == 1:
						part1.hide()
						bubble.show()
						bubble.set_text("Voici le context, blablabla\nblablelble\nkzzdz")
						histState = 1
		1:
			if event is InputEventMouseButton:
				if event.is_pressed():
					if event.button_index == 1:
						endTuto.emit()
		
