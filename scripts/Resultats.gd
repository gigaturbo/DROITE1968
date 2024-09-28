extends Node2D


var etape = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	etape = -1
	self.hide()
	
func startResultats(results):
	etape = 0
	self.show()
	
	


const testLines: Array[String] = [
	"Hiiiii, how are you?", 
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et posuere magna. Nulla eget finibus nibh. Pellentesque libero elit, malesuada ac nisl a, pharetra bibendum ligula.",
	"I am speaking alone..."
	]

func _unhandled_input(event):
	if event.is_action_pressed("A_button"):
		DialogManager.start_dialog($TextPosition_corner.position, testLines, Vector2(0,0))





