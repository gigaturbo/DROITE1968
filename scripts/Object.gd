extends Node2D

signal selected

const SELECT_TIME = 1

var state = 0

enum ObjEnum {MATRAQUE, MEGAPHONE, COLLAGE, TRACT}
@export var OBJ_NAME: ObjEnum

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = SELECT_TIME
	$Timer.stop()
	$TextureButton.scale = Vector2(1,1)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		var percent_proc = 1.0 - ($Timer.time_left / SELECT_TIME)
		var nscale =  (1.0 + 0.3 * percent_proc)
		$TextureButton.scale = Vector2(1,1) * nscale
	else :
			$TextureButton.scale = Vector2(1,1)
	
func _on_texture_button_button_down():
	$Timer.start()
	state = 1

func _on_texture_button_button_up():
	$Timer.wait_time = SELECT_TIME
	$Timer.stop()
	state = 0
	$TextureButton.scale = Vector2(1,1)

func _on_timer_timeout():
	selected.emit()

func go_away():
	var apos = $TextureButton.position
	var npos = apos + Vector2(0, 256)
	var tween = get_tree().create_tween()
	tween.tween_property($TextureButton, "position", npos, 0.33)
	tween.tween_property($TextureButton, "visible", false, 0)

func get_selected():
	var tween = get_tree().create_tween()
	tween.tween_property($TextureButton, "modulate", Color.TRANSPARENT, 0.5)
