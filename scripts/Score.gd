extends Node2D

@onready var _rs : Array[AnimatedSprite2D] = [$calepin/result1, 
											  $calepin/result2,
											  $calepin/result3,
											  $calepin/result4,
											  $calepin/result5]


signal rejouerPressed
signal menuPressed


func _ready():
	reset()

func reset():
	$win.hide()
	$loose.hide()
	$calepin.hide()
	$letter.hide()
	$calepin.position = Vector2(1300,413)
	$letter.position = Vector2(233,1000)
	$buttons.modulate = Color.TRANSPARENT
	for r in _rs:
		r.modulate = Color.TRANSPARENT

func init(score, answers):
	reset()
	
	#get_node("../Musiques/Musique1Radio").stop()
	#get_node("../Musiques/Musique1").stop()
	
	var tween = get_tree().create_tween()
	
	if score < 6:
		$loose.show()
		#get_node("../Musiques/MarseillaiseFluteBad").play()
	elif score <= 12:
		$win.show()
		#get_node("../Musiques/MarseillaisePianoGood").play()

	$calepin.show()
	tween.parallel().tween_property($calepin, "position", $calepin_pos.position, 2).set_trans(Tween.TRANS_ELASTIC)
	
	var ans = null
	for i_ans in answers.size():
		ans = answers[i_ans]["hum"]
		_rs[i_ans].frame = 0 if ans < 0 else (1 if ans == 0 else 2)
		tween.tween_property(_rs[i_ans], "modulate", Color.WHITE, 0.333)

	if score == 12:
		$letter.show()
		tween.tween_property($letter, "position", $letter_pos.position, 2).set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_property($buttons, "modulate", Color.WHITE, 0.5)

func _on_rejouer_pressed() -> void:
	rejouerPressed.emit()


func _on_menu_pressed() -> void:
	menuPressed.emit()
