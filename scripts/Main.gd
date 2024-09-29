extends Node2D

enum EnumMissions{A, B, C, D, E,
				  F, G, H, I, J,
				  K, L, M, N, O} # n=15
enum EnumMilitants{M1, M2, M3, M4, M5} # n=5
enum EnumContexts{C1, C2, C3, C4, C5} # n=5

var allDays = [{"contexts": [EnumContexts.C1],
				"militants": [EnumMilitants.M1],
				"missions": [[EnumMissions.A, EnumMissions.B, EnumMissions.C]]},
			   {"contexts": [EnumContexts.C2, EnumContexts.C3],
				"militants": [EnumMilitants.M2, EnumMilitants.M3],
				"missions": [[EnumMissions.D, EnumMissions.E, EnumMissions.F],
							 [EnumMissions.G, EnumMissions.H, EnumMissions.I]]},
				{"contexts": [EnumContexts.C4, EnumContexts.C5],
				"militants": [EnumMilitants.M4, EnumMilitants.M5],
				"missions": [[EnumMissions.J, EnumMissions.K, EnumMissions.L],
							 [EnumMissions.M, EnumMissions.N, EnumMissions.O]]}]

var presentations = [["Salut, moi c'est Raymond. Charcutier à Levallois. C'est ici qu'on signe ou quoi ?"],
					 ["Bonjour Monsieur, je m’appelle Nicolas. Je suis en deuxième année de droit à Assas et je voudrais m'engager pour Monsieur Prairie.",
					  "Bonjour Monsieur, je suis Marielle, championne d’escrime. J’ai l’habitude de me battre pour ce en quoi je crois, et je suis prête à m’engager ici, sans attendre. Donnez-moi du travail, je veux être utile."],
					 ["Roger. De Bordeaux. On m’a dit qu’il y avait besoin de renforts ici. C’est pas sérieux ce qu’il se passe en ce moment, on doit remettre de l’ordre. Tu me dis quoi faire, et je le fais. Simple.",
					  "Cher Monsieur, je suis Jacques, médecin. Je pense sincèrement que la situation en France est bien plus grave qu'on ne le pense… Il est urgent de réagir, et je suis prêt à défendre notre pays."]]

var questions = [[["Pourquoi tu milites, toi ?",
				   "Et t'es bon à quoi ?"]],
				 [["Pourquoi maintenant, gamin ?",
				   "Et tu sais faire quoi ?"],
				  ["C’est bien, mon petit, mais pourquoi es-tu là ?",
				   "Et elle sait faire quoi la championne ?"]],
				 [["(sa motivation n'est pas à questionner)",
				   "Bien, sur quoi on peut compter avec toi ?"],
				  ["Qu’est-ce qui vous motive, Monsieur ?",
				   "Et pourquoi vous ?"]]]

var reponses = [[["C’est simple... J’en ai ras-le-bol de ces p’tits jeunes gauchistes qui foutent le bordel partout. Ces chevelus, là, qui traînent dans les rues. Prairie, lui, au moins, il va les remettre à leur place. C’est un type avec du cran, vous voyez ? Comme dans les films d’espionnage que j’aime bien, où y'a toujours un gars qui règle les choses à sa façon. Moi, j’suis pour ça, pour l’ordre.",
				  "Judo, karaté, boxe française. J'pense me mettre à la lutte bretonne. C’est bon pour vous ?"]],
				 [["Monsieur, je réponds à l'appel du Général. Je crois qu’il est de notre devoir de jeunes Français de se lever et de participer à l'action civique.",
				   "Je suis très discret, Monsieur, on me remarque pas… Mais je suis prêt à… à \"casser des gueules\", s'il le faut ! Enfin… je veux dire, je suis prêt à me faire respecter, à montrer que je suis un homme !"],
				  ["Je n’aime pas le bazar que ces gens de gauche mettent. Le désordre, ça me fait peur. Moi, je crois en une droite sociale, mais bien ordonnée, comme celle du Général et de Monsieur Prairie. C’est pour ça que je veux m’engager.",
				   "Je suis audacieuse et volontaire. Quand il y a du travail à faire, je ne recule jamais. Et puis, je suis sportive. L'effort, la discipline, ça me connaît. Vous pouvez compter sur moi."]],
				 [["/",
				   "Moi, je suis un homme de terrain. Simple. J’ai l’habitude d’encadrer des gars, je sais comment les mettre au maille... les faire bosser, quoi. Mais ici, c’est pas comme chez nous, hein... C’est un peu la jungle, si tu vois ce que je veux dire."],
				  ["Le Général et ses compagnons… ils sont les seuls à saisir l’ampleur réelle de la situation. Leur vision dépasse celle des autres. Ils savent ce qui est en jeu, ils comprennent les forces qui menacent notre nation. Je suis convaincu qu’eux seuls peuvent guider la France avec la sagesse et la fermeté nécessaires.",
				   "Je suis avant tout quelqu’un de réfléchi, capable d’analyser les choses avec clarté. Je ne prétends pas être parfait, mais je sais que je peux prendre les décisions nécessaires quand d’autres hésiteraient. Et quand il faut agir, je ne recule devant rien. C’est une question de devoir, et je suis prêt à tout."]]]


var day = allDays[0]
var dayMissions = []
var	militant = []
var	contexts = []
var answers = []

signal anyMissionSelected
signal anyDialogAnswered

var res = preload("res://scenes/ResultsMission.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():

	$MusiqueTitre.play()
	$Titre.show()
	$Tuto.hide()


func getMission(mmis : EnumMissions):
	match mmis:
		EnumMissions.A:
			return {"scn": preload("res://scenes/elements/missions/MissionA.tscn"),
					"data": {}}
		EnumMissions.B:
			return {"scn": preload("res://scenes/elements/missions/MissionB.tscn"),
					"data": {}}
		EnumMissions.C:
			return {"scn": preload("res://scenes/elements/missions/MissionC.tscn"),
					"data": {}}
		EnumMissions.D:
			return {"scn": preload("res://scenes/elements/missions/MissionD.tscn"),
					"data": {}}            
		EnumMissions.E:
			return {"scn": preload("res://scenes/elements/missions/MissionE.tscn"),
					"data": {}}
		EnumMissions.F:
			return {"scn": preload("res://scenes/elements/missions/MissionF.tscn"),
					"data": {}}
		EnumMissions.G:
			return {"scn": preload("res://scenes/elements/missions/MissionG.tscn"),
					"data": {}}
		EnumMissions.H:
			return {"scn": preload("res://scenes/elements/missions/MissionH.tscn"),
					"data": {}}
		EnumMissions.I:
			return {"scn": preload("res://scenes/elements/missions/MissionI.tscn"),
					"data": {}} 
	# TODO ADD ALL / CHANGE

func getMilitant(mmil : EnumMilitants):
		match mmil:
			EnumMilitants.M1:
				return {"scn": preload("res://scenes/elements/militants/Militant1.tscn"),
						"data": {}}
			EnumMilitants.M2:
				return {"scn": preload("res://scenes/elements/militants/Militant2.tscn"),
						"data": {}}
			EnumMilitants.M3:
				return {"scn": preload("res://scenes/elements/militants/Militant3.tscn"),
						"data": {}}
			EnumMilitants.M4:
				return {"scn": preload("res://scenes/elements/militants/Militant4.tscn"),
						"data": {}}
			EnumMilitants.M5:
				return {"scn": preload("res://scenes/elements/militants/Militant5.tscn"),
						"data": {}}

	# TODO ADD ALL

func getContext(mcont : EnumContexts):
		match mcont:
			EnumContexts.C1:
				return {"scn": preload("res://scenes/elements/contexts/Contexte1.tscn"),
						"data": {}}
			EnumContexts.C2:
				return {"scn": preload("res://scenes/elements/contexts/Contexte2.tscn"),
						"data": {}}
			EnumContexts.C3:
				return {"scn": preload("res://scenes/elements/contexts/Contexte3.tscn"),
						"data": {}}
			EnumContexts.C4:
				return {"scn": preload("res://scenes/elements/contexts/Contexte4.tscn"),
						"data": {}}
			EnumContexts.C5:
				return {"scn": preload("res://scenes/elements/contexts/Contexte5.tscn"),
						"data": {}}
						

	# TODO ADD ALL

func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	$Titre.hide()
	$Tuto.show()
	$Tuto.startTuto()
	
func _on_tuto_end_tuto():
	$Titre.hide()
	$Tuto.hide()
	startDays() # START OF THE FUN
	
func startDays():
	
	# Clear everything before instanciating new things
	if militant:
		militant.queue_free()
	for m in dayMissions:
		m.queue_free()
	
	# LOAD BG1 (Generic)
	var bg = preload("res://scenes/elements/Background1.tscn").instantiate()
	add_child(bg)
	
	# Loop all days
	for i_day in allDays.size():
		var day = allDays[i_day]
		
		# Instanciate militants of the day, and  contexts
		for i_mil in day["militants"].size():
			
#			# Context sequence before militant
			var	con = getContext(day["contexts"][i_mil]).scn.instantiate()
			add_child(con)
			con.position = $ContexteLocation.position
			con.startContext()
			await con.contextEnded
			con.hide()
			
			# Here come militants
			var mil = getMilitant(day["militants"][i_mil]).scn.instantiate()
			mil.e_militant = day["militants"][0]
			militant = mil
			add_child(mil)
			mil.show()
			mil.come_in($DoorLocation.position, $MilitantLocation.position)
			await mil.iAmReady
			print("MILITANT ", mil.e_militant, " arrived")
			
			await get_tree().create_timer(0.2).timeout
			
			# Militant present him/herself
			await DialogManager.start_dialog($ResponseLocation.position, 
				Vector2(500,100), 
				DialogManager.TextBoxTypes.MILITANT,
				[presentations[i_day][i_mil]]).inputFinished
			
	
#			DialogManager.start_dialog(Vector2(200, 300), 
#				Vector2(500,150), 
#				DialogManager.TextBoxTypes.REPONSE,
#				[questions[i_day][i_mil][0]],
#				0)
#			DialogManager.buttonPressed.connect(reponse)
#
#			DialogManager2.start_dialog(Vector2(200, 300) + Vector2(0, 300), 
#				Vector2(500,150), 
#				DialogManager2.TextBoxTypes.REPONSE,
#				0,
#				1)
			
			for i_qr in range(0, 1):
				# Question
				await DialogManager.start_dialog($AnswerLocation.position, 
					Vector2(500,150), 
					DialogManager.TextBoxTypes.REPONSE,
					[questions[i_day][i_mil][i_qr]]).inputFinished
				
				# Reponse
				await DialogManager.start_dialog($ResponseLocation.position,
					Vector2(500,100), 
					DialogManager.TextBoxTypes.MILITANT,
					[reponses[i_day][i_mil][i_qr]]).inputFinished
				
			# Now instanciate day missions
			for i in day["missions"][0].size():
				var mis = getMission(day["missions"][0][i]).scn.instantiate()
				mis.e_mission = day["missions"][0][i]
				dayMissions.append(mis)
				mis.selected.connect(_mission_selected)
				mis.position = Vector2(200*(i+1) + 200, 700)	
				add_child(mis)
				mis.show()
			
			# Await a mission select, then fire militant
			var ms = await self.anyMissionSelected
			
			print("MISSION ", ms.e_mission, " selected")
			for mission in dayMissions:
				if mission.e_mission == ms.e_mission:
					mission.get_selected()
					answers.append({"militant": militant.e_militant,
									"mission": ms.e_mission})
					print("SAVED ", answers)
				else:
					mission.go_away()

			await get_tree().create_timer(1.0).timeout
			militant.come_out($MilitantLocation.position, $DoorLocation.position)
			
			await mil.byeBye
			
			# Mission results
			res.reset()
			res.show()
			add_child(res)
			bg.hide()
			await res.showPanel().finished
			await res.set_text("Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer Ok zoomer ")
			res.charlesGood()
			await res.quitResults
			res.hide()
			remove_child(res)
			
			bg.show()
			# To next cycle
	
	
# Handle mission selection
func _mission_selected(obj):
	anyMissionSelected.emit(obj)
	
func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
#	
#


## a virer plus tard
#func _unhandled_input(event):
#	if event.is_action_pressed("A_button"):
#
#		DialogManager.start_dialog(Vector2(200, 300), 
#			Vector2(500,150), 
#			DialogManager.TextBoxTypes.REPONSE,
#			["t'es qui ?"],
#			0)
#		DialogManager.buttonPressed.connect(reponse)
#
#		DialogManager2.start_dialog(Vector2(200, 300) + Vector2(0, 300), 
#			Vector2(500,150), 
#			DialogManager2.TextBoxTypes.REPONSE,
#			["test ^^"],
#			1)
#		DialogManager2.buttonPressed.connect(reponse)
#
#func reponse(oneDialogManager):
#	print(oneDialogManager.text_box.text)
#	print(oneDialogManager.id)
#	DialogManager.text_box.queue_free()
#	DialogManager2.text_box.queue_free()
#

func _dialog_manager_response(cdialog):
	var answered = cdialog.id
	DialogManager.text_box.queue_free()
	DialogManager2.text_box.queue_free()
	anyDialogAnswered.emit(answered)


