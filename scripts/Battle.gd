extends Node2D
#singleton node

func start(player,enemy):
	var battle = preload("res://scenes/battle/Battle_Scene.tscn").instance()
	battle.Enemy = enemy
	battle.Player = player
	get_parent().add_child(battle) #inserindo a cena de batalha configurada na tela
