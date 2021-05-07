extends KinematicBody2D

export var HP:int = 60 #Health points
export var AP:int = 0 #Ability power
export var AD:int = 5 #Ability Damage
export var MR:int = 10 #Magic Resistence
export var AR:int = 10 #Armor
export var XP:int = 10
var movement = Vector2(0,0)
export var speed = 300
var touchPlayer = false
onready var Player = get_tree().root.get_node("MapForest/Player")
var slow = 40
var player_entered = false
var rng = RandomNumberGenerator.new()
func _ready():
	generateRandomSlime()
func _physics_process(delta):
	_movement(delta)
	_runToPlayer()
	pass

func _movement(delta):
	var collision = move_and_collide(movement * speed * delta)
	if collision:
		if collision.collider == Player and !touchPlayer:
			touchPlayer = true
			Battle.start(Player,self)
func _runToPlayer():
	if player_entered and !touchPlayer and !Global.IS_FIGHTING:
		position += (Player.position - position)/slow

func _on_Area2D_body_entered(body):
	if body == Player:
		player_entered = true
func _on_Area2D_body_exited(body):
	if body == Player:
		player_entered = false
func generateRandomSlime():
	rng.randomize()
	$Sprite.texture = load("res://assets/enemies/slimes/slime" + str(rng.randi_range(1,20)) + ".tres")
