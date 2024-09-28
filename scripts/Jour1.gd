extends Node2D

signal finJour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


const lines: Array[String] = [
	"Hiiiii, how are you?", 
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et posuere magna. Nulla eget finibus nibh. Pellentesque libero elit, malesuada ac nisl a, pharetra bibendum ligula. Donec dapibus eget purus id convallis. Suspendisse lacus arcu, interdum ac ex sed, feugiat volutpat enim.",
	"I am speaking alone..."
	]

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		DialogManager.start_dialog($TextPosition_corner.position, lines, Vector2(0,0))

	if event.is_action_pressed("right_click"):
		DialogManager.start_dialog($TextPosition_corner.position, lines, Vector2(720,200))
