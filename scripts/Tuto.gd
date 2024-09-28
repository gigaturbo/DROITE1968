extends Node2D

signal endTuto

@onready var bubble = $SpeechBubble
@onready var part1 = $Part1
@onready var timer = $Timer
@onready var eteindre = $ButtonEnteindreTV

var histState = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	bubble.hide()
	histState = -1
	timer.stop()
	timer.wait_time = 1
	eteindre.hide()

func startTuto():
	bubble.hide()
	histState = 0

func _input(event):
	match histState:
		0:
			if event is InputEventMouseButton:
				if event.is_pressed():
					if event.button_index == 1:
						part1.hide()
						bubble.show()
						bubble.set_text("Voici le context, blablabla\nblablelble\nkzzdz")
						histState = 1
						timer.start()

func _on_timer_timeout():
	eteindre.show()
	
func _on_button_pressed():
	endTuto.emit()
