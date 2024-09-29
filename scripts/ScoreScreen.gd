extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$win.hide()
	$loose.hide()
	$perfect.hide()

func init(score, _scoreState):
	$win.hide()
	$loose.hide()
	$perfect.hide()
	
	get_node("../Musiques/Musique1Radio").stop()
	get_node("../Musiques/Musique1").stop()
	
	if score < 6:
		$loose.show()
		get_node("../Musiques/MarseillaiseFluteBad").play()
	elif score < 12:
		$win.show()
		get_node("../Musiques/MarseillaisePianoGood").play()
	elif score == 12:
		$perfect.show()
		get_node("../Musiques/MarseillaisePianoGood").play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
