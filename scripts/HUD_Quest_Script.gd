extends CanvasLayer
var title = "Titulo"
var mission = "Fale com o taverneiro"
export var missionCount = 0
export var missionLimit = 5

func _ready():
	$titleQuest.text = title
	$textQuest.text = mission
	$textCount.text = str(missionCount) + "/" + str(missionLimit)
