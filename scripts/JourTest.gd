extends Node2D

signal finJour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_obj_tract_selected():
	print("you-ve got tracted")


func _on_obj_matraque_selected():
	print("you-ve got matraqued")


func _on_obj_megaphone_selected():
	print("you-ve got megaphoned")


const testLines: Array[String] = [
	"Hiiiii, how are you?", 
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et posuere magna. Nulla eget finibus nibh. Pellentesque libero elit, malesuada ac nisl a, pharetra bibendum ligula.",
	"I am speaking alone..."
	]
	

func _unhandled_input(event):
	if event.is_action_pressed("A_button"):
		DialogManager.start_dialog($TextPosition_corner.position, testLines, Vector2(0,0))

	if event.is_action_pressed("B_button"):
		DialogManager.start_dialog($TextPosition_corner.position, testLines, Vector2(720,200))
