extends Node2D

signal endTuto

var histState = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	histState = -1

func startTuto():
	$tuto.hide()
	$Bureau.show()
	$contexte.show()
	
	if get_tree().root.get_node("Main").adminSkip:
		histState = 0
	else:
		await get_tree().create_timer(2).timeout
		histState = 0
		

func _input(event):
	if histState == 0 and event is InputEventMouseButton:
		if event.is_pressed():
			$tuto.modulate = Color.WHITE
			$tuto.show()
			$Bureau.hide()
			$contexte.hide()
			histState = 1


func _on_jouer_pressed() -> void:
	if histState == 1:
		endTuto.emit()
		histState = 2 # Avoid other tuto launch later
