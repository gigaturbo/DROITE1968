extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$win.hide()
	$loose.hide()
	$perfect.hide()
	init(12, {})

func init(score, scoreState):
	$win.hide()
	$loose.hide()
	$perfect.hide()
	
	if score < 6:
		$loose.show()
	elif score < 12:
		$win.show()
	elif score == 12:
		$perfect.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
