extends KinematicBody2D
export var speed_walk:int = 150
var movement = Vector2(0,0)

func _physics_process(delta):
	if !Global.IS_FIGHTING:
			var horizontal_axis = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
			var vertical_axis = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
			movement.x = speed_walk * horizontal_axis * delta
			movement.y = speed_walk * vertical_axis * delta
			
			move_and_collide(movement)
			animationController()
			level_up()
func animationController():
	if movement.x < 0:
		$AnimatedSprite.flip_h = true
	if movement.x > 0:
		$AnimatedSprite.flip_h = false
	if movement.x == 0 and movement.y == 0:
		$AnimatedSprite.play("Idle")
	else:
		if abs(movement.x) or abs(movement.y) > 0:
			if movement.y < 0:
				$AnimatedSprite.play("Climb")
			else:
				$AnimatedSprite.play("Walk")
func level_up():
	if Global.XP >= 50 and Global.LVL < 2:
		Global.LVL = 2
		Global.MAX_HP += 30
	if Global.XP >= 90 and Global.LVL < 3:
		Global.LVL = 3
		Global.MAX_HP += 30
		Global.MAX_MP += 10
	if Global.XP >= 140 and Global.LVL < 4:
		Global.LVL = 4
		Global.MAX_HP += 30
		Global.MAX_MP += 1
	if Global.XP >= 210 and Global.LVL < 5:
		Global.LVL = 5
		Global.MAX_HP += 30
		Global.MAX_MP += 10
	if Global.XP >= 300 and Global.LVL < 6:
		Global.LVL = 6
		Global.MAX_HP += 30
		Global.MAX_MP += 10
	if Global.XP >= 380 and Global.LVL < 7:
		Global.LVL = 7
		Global.MAX_HP += 30
		Global.MAX_MP += 10
