extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(1,1,1,0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_mouse_entered() -> void:
	modulate = Color(1,1,1,1)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	modulate = Color(1,1,1,0.5)
	pass # Replace with function body.
