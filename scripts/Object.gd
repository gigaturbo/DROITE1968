extends Node2D

signal selected

const SELECT_TIME = 1

var state = 0

enum NamedEnum {MATRAQUE, MEGAPHONE, COLLAGE, TRACT}
@export var OBJ_NAME: NamedEnum

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = SELECT_TIME
	$Timer.stop()
	$TextureButton.scale = Vector2(1,1)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		var percent_proc = 1.0 - ($Timer.time_left / SELECT_TIME)
		var scale =  (1.0 + 0.3 * percent_proc)
		$TextureButton.scale = Vector2(1,1) * scale
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
	print("Selected a ", OBJ_NAME)
	selected.emit()
	
