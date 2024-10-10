extends Node2D

@onready var _rs : Array[AnimatedSprite2D] = [$calepin/result1, 
											  $calepin/result2,
											  $calepin/result3,
											  $calepin/result4,
											  $calepin/result5]


signal rejouerPressed
signal quitterPressed
signal creditsPressed


func _ready():
	reset()

func reset():
	$win.hide()
	$loose.hide()
	$calepin.hide()
	$letter.hide()
	$letter2.hide()
	$calepin.position = Vector2(1400,413)
	$letter.position = Vector2(233,-100)
	$letter2.position = Vector2(233,-100)
	$buttons.modulate = Color.TRANSPARENT
	for r in _rs:
		r.modulate = Color.TRANSPARENT

func init(score, answers):
	reset()
	
	get_node("../Musiques/Musique1Radio").stop()
	get_node("../Musiques/Musique1").stop()

	var tween = create_tween()
	
	if score < 6:
		$loose.show()
		get_node("../Musiques/MarseillaiseFluteBad").play()
	else :
		$win.show()
		get_node("../Musiques/MarseillaisePianoGood").play()

	$calepin.show()
	tween.parallel().tween_property($calepin, "position", $calepin_pos.position, 2).set_trans(Tween.TRANS_ELASTIC)
	
	var ans = null
	for i_ans in answers.size():
		ans = answers[i_ans]["hum"]
		_rs[i_ans].frame = 0 if ans < 0 else (1 if ans == 0 else 2)
		tween.tween_property(_rs[i_ans], "modulate", Color.WHITE, 0.8)

	if score == 12:
		$letter2.show()
		tween.tween_property($letter2, "position", $letter_pos.position, 2).set_trans(Tween.TRANS_QUINT)
		tween.tween_property($letter2, "visible", false, 0)
		$letter.position = $letter_pos.position
		tween.tween_property($letter, "visible", true, 0)
	
	tween.tween_property($buttons, "modulate", Color.WHITE, 0.5)

func _on_rejouer_pressed() -> void:
	rejouerPressed.emit()


func _on_quitter_pressed() -> void:
	quitterPressed.emit()


func _on_credits_pressed() -> void:
	creditsPressed.emit()
