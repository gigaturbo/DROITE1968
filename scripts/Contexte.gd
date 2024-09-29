extends Node2D

signal contextEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer.hide()
	$MyMissionLabel.hide()
	$MarginContainer/MarginContainer/Label.set_text($MyMissionLabel.text)
	
func startContext():
	$MarginContainer.show()
	var t1 = get_tree().create_timer(0.5)
	await t1.timeout
	$MarginContainer.hide()
	
	contextEnded.emit()



