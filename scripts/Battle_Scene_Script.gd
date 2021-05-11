extends Node2D
onready var Enemy
onready var Player
#parte do wifi
var client
var wrapped_client
var connected = false

var text = ""

signal fight(damage,mana,type)
func _exit_tree():
	disconnect_from_server()
func connect_to_server():
	var ip = "192.168.0.6"
	var port = 120
	print("Connecting to server: %s : %s" % [ip, str(port)])
	var connect = client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected!")
	
func disconnect_from_server():
	connected = false
	client.disconnect_from_host()
func poll_server():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		if msg == null:
			continue;
		if msg.length() > 0:
			print("Texto recebido!")
			on_text_received(msg)

func on_text_received(text):
	print("Entrando no metodo de formatação...")
	if text == '1': #"1"
		print("Botao ne...",text)
		_on_ButtonAttack1_pressed()
	if text == '2': #"2"
		print("Botao ne...",text)
		_on_ButtonAttack2_pressed()
	if text == '3': #"3"
		print("Botao ne...",text)
		_on_ButtonAttack3_pressed()
	if text == '4': #"4"
		print("Botao ne...",text)
		_on_ButtonAttack4_pressed()

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	connect_to_server()
	if Enemy and Player != null and !Global.IS_FIGHTING:
		#get_node("Enemy").texture = Enemy.get_node("Sprite").texture
		if Enemy.name.substr(0,6) == "Goblin":
				get_node("Enemy").scale= Vector2(6,6)
				get_node("Enemy").texture = Enemy.get_node("Sprite").texture
				get_node("Enemy").flip_h = true
				Global.IS_FIGHTING = true
		if Enemy.name.substr(0,5) == "Slime":
			get_node("Enemy").texture = Enemy.get_node("Sprite").texture
			Global.IS_FIGHTING = true
		if Enemy.name.substr(0,8) == "Skeleton":
			get_node("Enemy").scale= Vector2(6,6)
			get_node("Enemy").texture = Enemy.get_node("Sprite").texture
			get_node("Enemy").flip_h = true
			Global.IS_FIGHTING = true
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
		Player.get_node("HUD").get_child(6).hide()
	else:
		print("Aberto para modo teste")
func _process(delta):
	if not connected:
		pass
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():
		poll_server()
func _physics_process(delta):
	$HUD/MP_Player.text = str(Global.HP)
	$HUD/MP_Player.text = str(Global.MP)
	$HUD/HP_Enemy.text = str(Enemy.HP)
	pass

func _on_ButtonAttack1_pressed():
	var damage = Global.AD + 10 - Enemy.AR * 0.1
	var mana = 0
	if Global.MP >= mana:
		emit_signal("fight",damage,mana,1)
	pass # Replace with function body.
func _on_ButtonAttack2_pressed():
	var damage = Global.AD + 12 - Enemy.AR * 0.1
	var mana = 90
	if Global.MP >= mana:
		emit_signal("fight",damage,mana,2)
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
func _on_ButtonLeave_pressed():
	Enemy.queue_free()
	Player.get_node("HUD").get_child(0).show()
	Player.get_node("HUD").get_child(1).show()
	Player.get_node("HUD").get_child(2).show()
	Player.get_node("HUD").get_child(3).show()
	Player.get_node("HUD").get_child(4).show()
	Player.get_node("HUD").get_child(5).show()
	Player.get_node("HUD").get_child(6).show()
	Global.IS_FIGHTING = false
	Player.get_node("Camera_Player").current = true
	queue_free()
	pass # Replace with function body.
	
	
func _on_Battle_Scene_fight(damage,mana,type):
	$MENU.visible = false
	#momento de ataque do jogador/ o inimigo recebe dano
	#yield(get_tree().create_timer(1.0),"timeout")
	if type == 1:
		$AnimatedEffects.play("efeito_tigre")
	if type == 2:
		if Global.HP + 10 >= Global.MAX_HP:
			Global.HP = Global.MAX_HP
		else:
			Global.HP += 10
		$AnimatedEffects2.play("efeito_tartaruga")
	$Player.get_node("AnimationPlayer").play("attack")
	$Enemy.get_node("AnimationPlayer").play("hit")
	Enemy.HP -= damage
	Global.MP -= mana
	$HUD/HP_Player.text = str(Global.HP)
	$HUD/MP_Player.text = str(Global.MP)
	$HUD/HP_Enemy.text = str(Enemy.HP)
	if Enemy.HP <= 0:
		if Enemy.name.substr(0,6) == "Goblin":
			GlobalMissionScript.goblinsKilled += 1
		if Enemy.name.substr(0,5) == "Slime":
			GlobalMissionScript.slimesKilled += 1
		if Enemy.name.substr(0,8) == "Skeleton":
			GlobalMissionScript.skeletonsKilled += 1
		if Enemy.name.substr(0,8) == "Skeleton":
			GlobalMissionScript.skeletonsKilled += 1
		Global.XP += Enemy.XP
		Global.IS_FIGHTING = false
		yield(get_tree().create_timer(2.0),"timeout")
		_on_ButtonLeave_pressed()
	#momento de contra ataque do inimigo/ o jogador recebe dano
	yield(get_tree().create_timer(3.0),"timeout")
	$AnimatedEffects.play("efeito_nenhum")
	$AnimatedEffects2.play("efeito_nenhum")
	$Enemy.get_node("AnimationPlayer").play("attack")
	$Player.get_node("AnimationPlayer").play("hit")
	Global.HP -= Enemy.AD - Global.AR * 0.1
	$HUD/HP_Player.text = str(Global.HP)

	yield(get_tree().create_timer(1.0),"timeout")	
	$MENU.visible = true
	pass # Replace with function body.
