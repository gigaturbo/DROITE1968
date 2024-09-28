extends Node2D

enum EnumMissions{A, B, C, D, E, F, G, H, I, J}
enum EnumMilitants{M1, M2, M3, M4, M5, M6}
enum EnumContexts{C1, C2, C3}

var J1 = {"context": EnumContexts.C1,
		  "militant": EnumMilitants.M1,
		  "missions": [EnumMissions.A, EnumMissions.B, EnumMissions.C]}

var J2 = {"context": EnumContexts.C2,
		  "militant": EnumMilitants.M2,
		  "missions": [EnumMissions.D, EnumMissions.E, EnumMissions.F]}


var dayMissions = []
#	militant = []
var answers = []

# Called when the node enters the scene tree for the first time.
func _ready():

	$MusiqueTitre.play()
	$Titre.show()
	$Tuto.hide()


func getMission(mission : EnumMissions):
	match mission:
		EnumMissions.A:
			return {"scn": preload("res://scenes/elements/objets/ObjCollage.tscn"),
					"data": {}}
		EnumMissions.B:
			return {"scn": preload("res://scenes/elements/objets/ObjMatraque.tscn"),
					"data": {}}
		EnumMissions.C:
			return {"scn": preload("res://scenes/elements/objets/ObjMegaphone.tscn"),
					"data": {}}
		EnumMissions.D:
			return {"scn": preload("res://scenes/elements/objets/ObjTract.tscn"),
					"data": {}}            
	

func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	
	$Titre.hide()
	$Tuto.show()
	$Tuto.startTuto()
	

func _on_tuto_end_tuto():
	$Tuto.hide()
	# START OF THE GAME
	startDays()
	
func startDays():
	
	# LOAD BG1
	var bg = preload("res://scenes/elements/Background1.tscn").instantiate()
	add_child(bg)
	
	# Instanciate day missions
	for i in J1["missions"].size():
		var mis = getMission(J1["missions"][i]).scn.instantiate()
		mis.e_mission = J1["missions"][i]
		dayMissions.append(mis)
		mis.selected.connect(_mission_selected)
		mis.position = Vector2(300*(i+1) - 650,300)	
		add_child(mis)
		mis.show()
		
	
# Handle mission selection
func _mission_selected(obj):
	for mission in dayMissions:
		if mission.e_mission == obj.e_mission:
			mission.get_selected()
			#TODO save which one was selected
		else:
			mission.go_away()	
	
