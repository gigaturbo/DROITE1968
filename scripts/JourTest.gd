extends Node2D

signal finJour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_obj_tract_selected():
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
