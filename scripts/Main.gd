extends Node2D

enum EnumMissions{A, B, C, D, E,
				  F, G, H, I, J,
				  K, L, M, N, O} # n=15
enum EnumMilitants{M1, M2, M3, M4, M5} # n=5
enum EnumContexts{C1, C2, C3, C4, C5, C6} # n=6

var allDays = [{"militants": [EnumMilitants.M1],
				"missions": [[EnumMissions.A, EnumMissions.B, EnumMissions.C]]},
			   {"militants": [EnumMilitants.M2, EnumMilitants.M3],
				"missions": [[EnumMissions.D, EnumMissions.E, EnumMissions.F],
							 [EnumMissions.G, EnumMissions.H, EnumMissions.I]]},
				{"militants": [EnumMilitants.M4, EnumMilitants.M5],
				"missions": [[EnumMissions.J, EnumMissions.K, EnumMissions.L],
							 [EnumMissions.M, EnumMissions.N, EnumMissions.O]]}]

var presentations = [[["Salut, moi c'est Raymond. Charcutier à Levallois. C'est ici qu'on signe ou quoi ?"]],
					 [["Bonjour Monsieur, je m’appelle Nicolas. Je suis en deuxième année de droit à Assas ",
					   "et je voudrais m'engager pour Monsieur Prairie."],
					  ["Bonjour Monsieur, je suis Marielle, championne d’escrime. J’ai l’habitude de me battre", 
					   "pour ce en quoi je crois, et je suis prête à m’engager ici, sans attendre. Donnez-moi du ",
					   "travail, je veux être utile."]],
					 [["Roger. De Bordeaux. On m’a dit qu’il y avait besoin de renforts ici. C’est pas sérieux ce ",
					   "qu’il se passe en ce moment, on doit remettre de l’ordre. Tu me dis quoi faire, et je le fais. Simple."],
					  ["Cher Monsieur, je suis Jacques, médecin. Je pense sincèrement que la situation en France est bien plus ",
					   "grave qu'on ne le pense… Il est urgent de réagir, et je suis prêt à défendre notre pays."]]]

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

var reponses = [[[["C’est simple... J’en ai ras-le-bol de ces p’tits jeunes gauchistes qui foutent le bordel ",
				   "partout. Ces chevelus, là, qui traînent dans les rues. Prairie, lui, au moins, il va les ",
				   "remettre à leur place. C’est un type avec du cran, vous voyez ? Comme dans les films ",
				   "d’espionnage que j’aime bien, où y'a toujours un gars qui règle les choses à sa façon. Moi, ",
				   "j’suis pour ça, pour l’ordre."],
				  ["Judo, karaté, boxe française. J'pense me mettre à la lutte bretonne. C’est bon pour vous ?"]]],
				 [[["Monsieur, je réponds à l'appel du Général. Je crois qu’il est de notre devoir de jeunes ",
					"Français de se lever et de participer à l'action civique."],
				   ["Je suis très discret, Monsieur, on me remarque pas… Mais je suis prêt à… ",
					"à \"casser des gueules\", s'il le faut ! Enfin… je veux dire, je suis prêt à me faire ",
					"respecter, à montrer que je suis un homme !"]],
				  [["Je n’aime pas le bazar que ces gens de gauche mettent. Le désordre, ça me fait peur. Moi, ",
					"je crois en une droite sociale, mais bien ordonnée, comme celle du Général et de Monsieur Prairie. ",
					"C’est pour ça que je veux m’engager."],
				   ["Je suis audacieuse et volontaire. Quand il y a du travail à faire, je ne recule jamais. ",
					"Et puis, je suis sportive. L'effort, la discipline, ça me connaît. Vous pouvez compter sur moi."]]],
				 [["/",
				   ["Moi, je suis un homme de terrain. Simple. J’ai l’habitude d’encadrer des gars, je sais comment les ",
					"mettre au maille... les faire bosser, quoi. Mais ici, c’est pas comme chez nous, hein... ",
					"C’est un peu la jungle, si tu vois ce que je veux dire."]],
				  [["Le Général et ses compagnons… ils sont les seuls à saisir l’ampleur réelle de la situation. ",
					"Leur vision dépasse celle des autres. Ils savent ce qui est en jeu, ils comprennent les forces ",
					"qui menacent notre nation. Je suis convaincu qu’eux seuls peuvent guider la France avec la ",
					"sagesse et la fermeté nécessaires."],
				   ["Je suis avant tout quelqu’un de réfléchi, capable d’analyser les choses avec clarté. Je ne prétends ",
					"pas être parfait, mais je sais que je peux prendre les décisions nécessaires quand d’autres hésiteraient. ",
					"Et quand il faut agir, je ne recule devant rien. C’est une question de devoir, et je suis prêt à tout."]]]]

var scores = [[[{"text": "Raymond n'a pas tenu. Les discours de ces petits rouges l’ont rendu fou de rage, et il a flanqué une raclée à sept d’entre eux. Il est actuellement entendu par les flics. Ce n’est pas vraiment à notre avantage…",
				 "hum":-1, "score":0},
				{"text": "Raymond a réussi à coller trois affiches avant de tomber sur des cocos. Il n'a pas pu s'empêcher de se battre avec eux... Autant dire que l’efficacité n’était pas au rendez-vous.",
				 "hum":-1, "score":1},
				{"text": "Raymond ne s’est pas contenté de coller des affiches, il a fait le ménage comme jamais. Les cocos ont pris la fuite, et même les passants réclamaient des tracts, de peur de se prendre un gnon. On peut dire qu'il a fait son boulot.",
				 "hum":-1, "score":2}]],
			  [[{"text": "À la première échauffourée, Nicolas a pris peur et s'est enfui. Au final, il n'a réussi à poser que deux affiches et ses compagnons sont à l'hôpital. Une vraie planche pourrie !",
				 "hum":-1, "score":0},
				{"text": "Nicolas a tout entendu, de A à Z, et ce qu'il a découvert l'a glacé d'effroi : ils parlent ouvertement de révolution, et c'est certain, le Grand Soir est pour bientôt, probablement dès demain. Mais c’est quand ils ont commencé à lire à haute voix des passages de Lénine que Nicolas a vraiment senti la terreur monter. Pour lui, c’était la preuve que ces types veulent tout renverser.",
				 "hum":-1, "score":2},
				{"text": "Nicolas a oublié de mettre des gants, et bien sûr, il s'est coupé en collant la première affiche. Résultat : du sang partout sur le visage de Charles Prairie. Pas très propre, mais au moins, ça filera peut-être la trouille aux cocos ?",
				 "hum":-1, "score":1}],
				[{"text": "Marielle ne tape pas vite, fait des fautes, et s’ennuie rapidement... on dirait presque un garçon. Elle en a fait vingt, mais seulement sept seulement sont exploitables. Vraiment décevant.",
				 "hum":-1, "score":1},
				{"text": "Marielle a commencé à préparer à manger, malheureusement à la dixième remarque qu'elle a jugée déplacée, elle a rendu son tablier et a claqué la porte. Quinze gars pour un demi-sandwich, c'est peu...",
				 "hum":-1, "score":0},
				{"text": "Marielle a fait preuve de caractère, et pas qu’un peu ! Pas de charme à l'œuvre ici, mais bien sa réputation de championne et son tempérament de feu. Elle a réussi à recruter des étudiants et des ouvriers. Qui aurait cru qu’elle en aurait dans le ventre pour rallier autant de gars ?",
				 "hum":-1, "score":2}]],
			  [[{"text": "Comme prévu, l’équipe de colleurs s’est fait tomber dessus. Roger, plein de courage, s’est jeté dans la mêlée, mais l’âge ne pardonne pas. Après quelques échanges vigoureux, il a fini par prendre une belle raclée. Il a au moins eu l'utilité de distraire assez longtemps pour que les autres se tirent en vitesse.",
				 "hum":-1, "score":1},
				{"text": "Roger a chopé les colleurs communistes au vol ! Juste un regard, et ils ont su qu'ils étaient cuits. Pas besoin de hausser la voix, il les a mis au boulot tout l’après-midi, les forçant à recouvrir toutes leurs affiches avec celles de Charles Prairie. Sous sa surveillance de vieux briscard, pas un n’a bronché. Il les faisait trimer comme des bons petits soldats, et lui, il regardait ça d’un œil amusé. Quand ils ont fini, ils étaient lessivés, humiliés…",
				 "hum":-1, "score":3},
				{"text": "Roger a patrouillé avec ses cadets, mais pas un ne connaissait le coin. Alors, quand ils ont vu une bande de jeunes avec des seaux de colle, ils n’ont pas hésité : ils ont appliqué les consignes de Charles Prairie et leur ont bien cassé la figure. Le problème ? C’était nos gars ! On s’est retrouvés avec nos propres militants à l’hôpital. Une vraie catastrophe, et un sacré gâchis !",
				 "hum":-1, "score":0}],
				[{"text": "Catastrophe totale ! Jacques a raconté à la presse que Mai 68 était orchestré par une alliance improbable : la Chine de Mao, Israël, la CIA, Cuba, la Suisse et même la Bulgarie. Oui, vous avez bien entendu, il a vraiment dit ça ! Le journaliste n’en a pas raté une miette, et la candidature de Charles Prairie est maintenant la risée de tout le monde. Une humiliation complète.",
				 "hum":-1, "score":0},
				{"text": "À la sortie de la messe, Jacques a livré un véritable sermon mystique, parlant de la mission sacrée du Général face à l'antéchrist rouge. Les fidèles, encore sous l'effet des cantiques, étaient captivés, buvant chacune de ses paroles. Ils ont pris les tracts avec ferveur, on peut dire qu’il les a conquis !",
				 "hum":-1, "score":3},
				{"text": "Malheureusement, Jacques n'a pas vraiment les jambes pour ce genre de course. Il s'est fait attraper par la police avant d'avoir pu finir son travail. Avec son statut et sa manière de parler, il s'en tirera sans trop de problèmes et il a tout de même réussi à coller une dizaine de papillons... c’est déjà ça.",
				 "hum":-1, "score":1}]]]

var day = allDays[0]
var dayMissions = []
var	militant = []
var	contexts = []
var answers = []
var score = 0

signal anyMissionSelected
signal anyDialogAnswered

var res = preload("res://scenes/ResultsMission.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
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
		EnumMissions.J:
			return {"scn": preload("res://scenes/elements/missions/MissionJ.tscn"),
					"data": {}} 
		EnumMissions.K:
			return {"scn": preload("res://scenes/elements/missions/MissionK.tscn"),
					"data": {}} 
		EnumMissions.L:
			return {"scn": preload("res://scenes/elements/missions/MissionL.tscn"),
					"data": {}} 
		EnumMissions.M:
			return {"scn": preload("res://scenes/elements/missions/MissionM.tscn"),
					"data": {}} 
		EnumMissions.N:
			return {"scn": preload("res://scenes/elements/missions/MissionN.tscn"),
					"data": {}} 
		EnumMissions.O:
			return {"scn": preload("res://scenes/elements/missions/MissionO.tscn"),
					"data": {}}

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
						"medium" : "talkie",
						"data": "François Mitterrand fustige la dérive autoritaire après l'annonce de la dissolution de l'Assemblée nationale par le général De Gaulle !"}
			EnumContexts.C2:
				return {"scn": preload("res://scenes/elements/contexts/Contexte2.tscn"),
						"medium" : "phone",
						"data": "Le Général a sérieusement envisagé de démissionner avant de décider de rester pour s'opposer à \"l’entreprise communiste totalitaire\". Le combat continue !"}
			EnumContexts.C3:
				return {"scn": preload("res://scenes/elements/contexts/Contexte3.tscn"),
						"medium" : "talkie",
						"data": "André Malraux l'a dit clairement : si la gauche prend le pouvoir, elle se fera renverser par ses propres alliés révolutionnaires. Et après, c'est la dictature, sous une forme ou une autre ! Recrute bien, compagnon..."}
			EnumContexts.C4:
				return {"scn": preload("res://scenes/elements/contexts/Contexte4.tscn"),
						"medium" : "phone",
						"data": "Compagnon, les renforts que tu m’as demandés de Gironde sont arrivés."}
			EnumContexts.C5:
				return {"scn": preload("res://scenes/elements/contexts/Contexte5.tscn"),
						"medium" : "radio",
						"data": "Drame aujourd’hui chez Peugeot : après 22 jours de grève, la police a investi les usines de Sochaux. Bilan tragique : 2 morts et 150 blessés."}
			EnumContexts.C6:
				return {"scn": preload("res://scenes/elements/contexts/Contexte6.tscn"),
						"medium" : "talkie",
						"data": "Un jeune militant communiste a été tué à coups de pistolet à Achicourt, par des membres d'un groupe d'action civique."}

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
	
func showContext(n):
	var	textContext = getContext(n).data
	var	medium = getContext(n).medium
	var contextPosition = null
	match medium:
		"radio":
			contextPosition = $RadioLocation.position
		"talkie":
			contextPosition = $TalkieLocation.position
		"phone":
			contextPosition = $PhoneLocation.position
	return DialogManager.start_dialog(contextPosition, 
		Vector2(500,100), 
		DialogManager.TextBoxTypes.ELEC,
		[textContext]).inputFinished
	
func startDays():
	$Titre.hide()
	$Tuto.hide()
	score = 0 
	var ncontext = 0
	
	# Clear everything before instanciating new things
	if militant:
		militant.queue_free()
	for m in dayMissions:
		m.queue_free()
	
	# LOAD BG1 (Generic)
	var bg = preload("res://scenes/elements/Background1.tscn").instantiate()
	add_child(bg)
	
	await showContext(0)
	ncontext = ncontext + 1
	
	# Loop all days
	for i_day in allDays.size():
		var day = allDays[i_day]
		
		# Instanciate militants of the day, and  contexts
		for i_mil in day["militants"].size():
			
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
				Vector2(400,200), 
				DialogManager.TextBoxTypes.MILITANT,
				presentations[i_day][i_mil]).inputFinished
			
			# Q1
			DialogManager.start_dialog($AnswerLocation.position, 
				Vector2(250,75), 
				DialogManager.TextBoxTypes.REPONSE,
				[questions[i_day][i_mil][0]],
				0
			)
			DialogManager.buttonPressed.connect(_dialog_manager_response)

			# Q2
			DialogManager2.start_dialog($AnswerLocation.position + Vector2(300, 0), 
				Vector2(250,75), 
				DialogManager2.TextBoxTypes.REPONSE,
				[questions[i_day][i_mil][1]],
				1
			)
			DialogManager2.buttonPressed.connect(_dialog_manager_response)
			
			var rep1 = await anyDialogAnswered
			
			# He answers selected question
			await DialogManager.start_dialog($ResponseLocation.position,
				Vector2(500,150), 
				DialogManager.TextBoxTypes.MILITANT,
				reponses[i_day][i_mil][rep1]).inputFinished
			
			# Show remaining question
			DialogManager.start_dialog($AnswerLocation.position + Vector2(150, 0), 
				Vector2(250,75), 
				DialogManager.TextBoxTypes.REPONSE,
				[questions[i_day][i_mil][1-rep1]],
				0
			)
			DialogManager.buttonPressed.connect(_dialog_manager_response)
			
			var rep2 = await anyDialogAnswered
			
			# He answers remaining question
			await DialogManager.start_dialog($ResponseLocation.position,
				Vector2(500,100), 
				DialogManager.TextBoxTypes.MILITANT,
				reponses[i_day][i_mil][1-rep1]).inputFinished
				
			# Now instanciate day missions
			for i in day["missions"][0].size():
				var mis = getMission(day["missions"][0][i]).scn.instantiate()
				mis.e_mission = day["missions"][0][i]
				dayMissions.append(mis)
				mis.selected.connect(_mission_selected)
				mis.position = Vector2(200*(i+1) + 150, 680)	
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
					var toadd = scores[i_day][i_mil][ms.e_mission % 3]["score"]
					score = score + toadd
					print("SCORE IS NOW ", score)
					print("SAVED ", answers)
				else:
					mission.go_away()

			await get_tree().create_timer(1.0).timeout
			militant.come_out($MilitantLocation.position, $DoorLocation.position)
			
			await mil.byeBye
			
			# Show context before results
			await showContext(ncontext)
			ncontext = ncontext + 1
			
			# Mission results
			res.reset()
			res.show()
			add_child(res)
			bg.hide()
			
			await res.showPanel(scores[i_day][i_mil][ms.e_mission % 3]["text"],
								scores[i_day][i_mil][ms.e_mission % 3]["hum"])
			res.isFinished = true
			await res.quitResults
			res.hide()
			remove_child(res)
			
			bg.show()
			# To next cycle
	
	# Show last context before scores
	await showContext(5)
	
	
	
# Handle mission selection
func _mission_selected(obj):
	anyMissionSelected.emit(obj)


func _dialog_manager_response(cdialog):
	var answered = cdialog.id
	DialogManager.inputCloseDialog()
	DialogManager2.inputCloseDialog()
	anyDialogAnswered.emit(answered)


