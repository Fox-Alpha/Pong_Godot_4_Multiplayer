extends CharacterBody2D

const SPEED : float = 200.0
var _speed : float = 0.0
var ballspeed : Vector2 = Vector2.ZERO

var dbg : Control = null


func _ready():
	Game.connect("New_Game_Started", reset, CONNECT_DEFERRED)
	Game.connect("Next_Round_Started", reset, CONNECT_DEFERRED)
	
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8, 0.8][randi() % 2]

	_speed = SPEED


func _physics_process(delta):
	_speed = clampf(_speed * 1.1, SPEED, 700.0)
	ballspeed =  velocity * delta * _speed
	ballspeed = ballspeed.clamp(Vector2(-15, -15), Vector2(15, 15))
	var collision = move_and_collide(ballspeed)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	if Game.DebugControl:
		Game.DebugControl.SetDebugText.emit(str(ballspeed))


func reset():
	position =  get_viewport_rect().get_center()
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.8, 0.8][randi() % 2]
	_speed = SPEED


func _on_visible_on_screen_notifier_2d_screen_exited():
	if(!Game.hasGamestartet):
		return
	if(position.x < 0):
		Game.emit_signal("Right_Player_Scored", 1)
	else:
		Game.emit_signal("Left_Player_Scored", 1)
#	reset()
