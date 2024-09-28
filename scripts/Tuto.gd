extends Node2D

signal endTuto

@onready var part1 = $Part1
@onready var eteindre = $ButtonEnteindreTV

var histState = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	histState = -1
	eteindre.hide()

func startTuto():
	histState = 0

func _input(event):
	if histState == 0 and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				endTuto.emit()
				histState = 2 # Avoid other tuto launch later
						


