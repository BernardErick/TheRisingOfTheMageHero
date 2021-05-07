extends Node2D
onready var Enemy
onready var Player

signal fight(damage,mana)

func _ready():
	if Enemy and Player != null and !Global.IS_FIGHTING:
		#get_node("Enemy").texture = Enemy.get_node("Sprite").texture
		if Enemy.name.substr(0,6) == "Goblin":
				get_node("Enemy").scale= Vector2(6,6)
				get_node("Enemy").texture = Enemy.get_node("Sprite").texture
				get_node("Enemy").flip_h = true
		if Enemy.name.substr(0,5) == "Slime":
			get_node("Enemy").texture = Enemy.get_node("Sprite").texture
		if Enemy.name.substr(0,8) == "Skeleton":
			get_node("Enemy").scale= Vector2(6,6)
			get_node("Enemy").texture = Enemy.get_node("Sprite").texture
			get_node("Enemy").flip_h = true
		$Camera_Battle.current = true
		get_node("HUD/HP_Player").text = str(Global.HP)
		get_node("HUD/MP_Player").text = str(Global.MP)
		get_node("HUD/HP_Enemy").text = str(Enemy.HP)
		Player.get_node("HUD").get_child(0).hide()
		Player.get_node("HUD").get_child(1).hide()
		Player.get_node("HUD").get_child(2).hide()
		Player.get_node("HUD").get_child(3).hide()
		Player.get_node("HUD").get_child(4).hide()
		Player.get_node("HUD").get_child(5).hide()		
	else:
		print("Aberto para modo teste")
func _process(delta):
	
	pass

func _on_ButtonAttack1_pressed():
	var damage = Global.AD + 10 - Enemy.AR * 0.1
	var mana = 0
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonAttack2_pressed():
	var damage = Global.AD + 20 - Enemy.AR * 0.1
	var mana = 90
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonAttack3_pressed():
	var damage = Global.AD + 30 - Enemy.AR * 0.1
	var mana = 120
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonAttack4_pressed():
	var damage = Global.AD + 40 - Enemy.AR * 0.1
	var mana = 150
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonAttack5_pressed():
	var damage = Global.AD + 50 - Enemy.AR * 0.1
	var mana = 150
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonAttack6_pressed():
	var damage = Global.AD + 100 - Enemy.AR * 0.1
	var mana = 200
	if Global.MP >= mana:
		emit_signal("fight",damage,mana)
	pass # Replace with function body.
func _on_ButtonLeave_pressed():
	Enemy.queue_free()
	Player.get_node("HUD").get_child(0).show()
	Player.get_node("HUD").get_child(1).show()
	Player.get_node("HUD").get_child(2).show()
	Player.get_node("HUD").get_child(3).show()
	Player.get_node("HUD").get_child(4).show()
	Player.get_node("HUD").get_child(5).show()
	Global.IS_FIGHTING = false
	Player.get_node("Camera_Player").current = true
	queue_free()
	pass # Replace with function body.
	
	
func _on_Battle_Scene_fight(damage,mana):
	$MENU.visible = false
	#momento de ataque do jogador/ o inimigo recebe dano
	yield(get_tree().create_timer(2.0),"timeout")
	$Player.get_node("AnimationPlayer").play("attack")
	$Enemy.get_node("AnimationPlayer").play("hit")
	Enemy.HP -= damage
	Global.MP -= mana
	$HUD/MP_Player.text = str(Global.MP)
	$HUD/HP_Enemy.text = str(Enemy.HP)
	#momento de contra ataque do inimigo/ o jogador recebe dano
	yield(get_tree().create_timer(3.0),"timeout")
	$Enemy.get_node("AnimationPlayer").play("attack")
	$Player.get_node("AnimationPlayer").play("hit")
	Global.HP -= Enemy.AD - Global.AR * 0.1
	$HUD/HP_Player.text = str(Global.HP)
	if Enemy.HP <= 0:
		if Enemy.name.substr(0,6) == "Goblin":
			GlobalMissionScript.goblinsKilled += 1
		if Enemy.name.substr(0,5) == "Slime":
			GlobalMissionScript.slimesKilled += 1
			if Enemy.name.substr(0,8) == "Skeleton":
				GlobalMissionScript.skeletonsKilled += 1
		
		Global.XP += Enemy.XP
		Global.IS_FIGHTING = false
		


		

		_on_ButtonLeave_pressed()
	yield(get_tree().create_timer(1.0),"timeout")	
	$MENU.visible = true
	pass # Replace with function body.
