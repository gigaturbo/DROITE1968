extends Node2D

signal selected

const SELECT_TIME = 1

var state = 0

enum ObjEnum {MATRAQUE, MEGAPHONE, COLLAGE, TRACT}
@export var OBJ_NAME: ObjEnum

var e_mission = -1

var rscale = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$TextureButton.mouse_entered.connect(_on_texture_button_mouse_entered)
	$TextureButton.mouse_exited.connect(_on_texture_button_mouse_exited)
	
	$TextureButton.button_down.connect(_on_texture_button_button_down)
	$TextureButton.button_up.connect(_on_texture_button_button_up)
	
	$MissionText.hide()
	$Timer.wait_time = SELECT_TIME
	$Timer.stop()
	rscale = $TextureButton.scale

func init(itemType: String, missionText:String):
	$TextureButton.set_texture_normal(load("res://assets/image/objets/asset_" + itemType + ".png"))
	$TextureButton.set_texture_pressed(load("res://assets/image/objets/asset_" + itemType + "_highlight" + ".png"))
	$TextureButton.set_texture_hover(load("res://assets/image/objets/asset_" + itemType + "_selected" + ".png"))
	
	$MissionText/MarginContainerText/Label.set_text(missionText)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state == 1:
		var percent_proc = 1.0 - ($Timer.time_left / SELECT_TIME)
		var nscale =  Vector2(1,1) * (1.0 + percent_proc * 0.3)
		$TextureButton.scale = rscale * nscale
	else :
			$TextureButton.scale = rscale
	
func _on_texture_button_button_down():
	$Timer.start()
	state = 1

func _on_texture_button_button_up():
	$Timer.wait_time = SELECT_TIME
	$Timer.stop()
	state = 0
	$TextureButton.scale = rscale

func _on_timer_timeout():
	selected.emit(self)

func go_away():
	var apos = $TextureButton.position
	var npos = apos + Vector2(0, 500)
	var tween = get_tree().create_tween()
	tween.tween_property($TextureButton, "position", npos, 0.33)
	tween.tween_property($TextureButton, "visible", false, 0)


func get_selected():
	var tween = get_tree().create_tween()
	tween.tween_property($TextureButton, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_property($TextureButton, "position", -5000*Vector2(1,1), 0.1)


func _on_texture_button_mouse_entered():
	$MissionText.show()


func _on_texture_button_mouse_exited():
	$MissionText.hide()
