extends CanvasLayer

func _ready():
	$HP.text = str(Global.HP)
	$MP.text = str(Global.MP)
	$LVL.text = str(Global.LVL)
func _process(delta):
	$HP.text = str(Global.HP)
	$MP.text = str(Global.MP)
	$LVL.text = str(Global.LVL)
