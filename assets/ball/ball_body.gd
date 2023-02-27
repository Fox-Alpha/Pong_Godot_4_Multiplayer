extends CharacterBody2D

var speed = 200
#velocity = Vector2.ZERO


func _ready():
	Game.connect("New_Game_Started", reset, CONNECT_DEFERRED)
	Game.connect("Next_Round_Started", reset, CONNECT_DEFERRED)
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-1,1][randi() % 2]


func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func reset():
	speed = 200
	position =  get_viewport_rect().get_center()
	randomize()
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-1,1][randi() % 2]

func _on_visible_on_screen_notifier_2d_screen_exited():
	if(!Game.hasGamestartet):
		return
	if(position.x < 0):
		Game.emit_signal("Right_Player_Scored", 1)
	else:
		Game.emit_signal("Left_Player_Scored", 1)
#	reset()
