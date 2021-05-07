extends StaticBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Global.HP = Global.MAX_HP
		Global.MP = Global.MAX_MP
	pass # Replace with function body.
