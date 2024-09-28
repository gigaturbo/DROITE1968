extends Node2D

signal finJour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_obj_tract_selected(objet):
	print(objet.OBJ_NAME)
	print(objet.ObjEnum)
	print("you-ve got tracted")
	$Objets/ObjTract.get_selected()
	$Objets/ObjMegaphone.go_away()
	$Objets/ObjMatraque.go_away()

func _on_obj_matraque_selected():
	print("you-ve got matraqued")
	$Objets/ObjMatraque.get_selected()
	$Objets/ObjMegaphone.go_away()
	$Objets/ObjTract.go_away()

func _on_obj_megaphone_selected():
	print("you-ve got megaphoned")
	$Objets/ObjMegaphone.get_selected()
	$Objets/ObjMatraque.go_away()
	$Objets/ObjTract.go_away()


const testLines: Array[String] = [
	"Hiiiii, how are you?", 
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et posuere magna. consectetur adipiscing elit. Donec et posuere magna. consectetur adipiscing elit. Donec et posuere magna. Nulla eget finibus nibh. Pellentesque libero elit, malesuada ac nisl a, pharetra bibendum ligula.",
	"I am speaking alone..."
	]
	

func _unhandled_input(event):
	if event.is_action_pressed("A_button"):
		DialogManager.start_dialog($TextPosition_corner.position, 
				Vector2(0,0), 
				DialogManager.TextBoxTypes.REPONSE,
				testLines)

	if event.is_action_pressed("B_button"):
		DialogManager.start_dialog($TextPosition_corner.position, 
				Vector2(720,200), 
				DialogManager.TextBoxTypes.REPONSE,
				testLines)
