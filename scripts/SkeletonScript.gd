extends KinematicBody2D

export var HP:int = 60 #Health points
export var AP:int = 0 #Ability power
export var AD:int = 5 #Ability Damage
export var MR:int = 10 #Magic Resistence
export var AR:int = 10 #Armor
export var XP:int = 20

var movement = Vector2(0,0)
export var speed = 300
var touchPlayer = false
onready var Player = get_parent().get_node("Player")
var slow = 40
var pos
var player_entered = false

func _ready():
	pos = position.x


func _physics_process(delta):
	_movement(delta)
	animationController()
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
		$AnimatedSprite.play("Run")
		
func animationController():
	var posAtual = position.x
	if posAtual > pos :
		pos = posAtual
		$AnimatedSprite.flip_h = false
		
	if posAtual < pos :
		pos = posAtual
		$AnimatedSprite.flip_h = true









func _on_Area2D_body_entered(body):
	if body == Player:
		player_entered = true

func _on_Area2D_body_exited(body):
	if body == Player: 
		player_entered = false
