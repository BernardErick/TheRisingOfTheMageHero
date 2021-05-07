extends Control
var title = "Perdido"
var mission = "Fale com o taverneiro"
var mission1 = "Mate os slimes"
var mission2 = "Mate os goblins"
var mission3 = "Elimine os esqueletos"
signal boss
var tocou = false
export var missionCount = 0
export var mission1Limit = 5
export var mission2Limit = 5
export var mission3Limit = 5

var showQuest = -1

func _ready():
	$titleQuest.text = title
	$textQuest.text = mission
	
	
func _process(delta):
	if tocou:
		$titleQuest.text = "Ataque dos Slimes"
		$textQuest.text = mission1 + " " + str(GlobalMissionScript.slimesKilled) + "/" + str(mission1Limit)
	if showQuest == 1:
		$HUD_Quest_Panel.show()
		$textQuest.show()
		
		$TextureRect.show()
		$titleQuest.show()
	else : 
		$HUD_Quest_Panel.hide()
		$textQuest.hide()
		
		$TextureRect.hide()
		$titleQuest.hide()
		
	if Input.is_action_just_released ("quest"):
			showQuest *= -1
	
	if GlobalMissionScript.slimesKilled == mission1Limit:
		$titleQuest.text = "Goblin Slayer"
		$textQuest.text = mission2 + " " + str(GlobalMissionScript.goblinsKilled) +  "/" + str(mission2Limit)
	if GlobalMissionScript.goblinsKilled == mission2Limit:
		$titleQuest.text = "Caveirinhas"
		$textQuest.text = mission3 + str(GlobalMissionScript.skeletonsKilled) + "/" + str(mission3Limit)
	if GlobalMissionScript.skeletonsKilled == mission3Limit:
		emit_signal("boss")
		


func _on_Barkeeper_interact():
	tocou = true
	
	
	
