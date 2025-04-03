extends Node

#class_name Game

var MaxScore : int = 1
var currentround :int = 1
var maxrounds :int

var hasGamestartet : bool = false
var waitForNextRound : bool = false
var isMultiplayerGame : bool = false

var GameScene : PackedScene = preload("res://Scenes/Pong_40.tscn")

var playerdic : Dictionary = {"player1":"", "player2":"", "Rounds":1}

##### Beispiel Setter / Getter
#var sprite_offset : Vector2 = Vector2.ZERO :
#	set (value):
#		sprite_offset = on_sprite_offset_change(value)
#	get:
#		return sprite_offset
#
#func on_sprite_offset_change(value: Vector2) -> Vector2:
#	return Vector2.ZERO
#####

var p1_score :int = 0 :
	set (value):
		p1_score = value
		_check_win_state()
	get:
		return p1_score

var p2_score : int = 0 :
	set (value):
		p2_score = value
		_check_win_state()
	get:
		return p2_score

signal Left_Player_Scored
signal Right_Player_Scored
signal Game_Is_over
signal New_Game_Started
signal Next_Round_Started
#signal Update_Player_Dict(p1:String, p2:String,score:int,rounds:int)

func _check_win_state():
	if(MaxScore == p1_score):
		emit_signal("Game_Is_over", playerdic["player1"])
	elif(MaxScore == p2_score):
		emit_signal("Game_Is_over", playerdic["player2"])


func update_player_dict(p1:String, p2:String,score:int = 10,rounds:int = 3):
	playerdic.clear()
#
	playerdic = {"player1":p1, "player2":p2, "rounds":rounds, "score": score}
#
	for r in range(1, rounds+1):
		var roundname = "round_{rnd}".format({"rnd":str(r)})
		playerdic[roundname] = {"p1": 0, "p2":0, "won": "NONE"}
#	print_debug(playerdic)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
#	connect("Left_Player_Scored", ScoreLeft, CONNECT_DEFERRED)
#	connect("Right_Player_Scored", ScoreRight, CONNECT_DEFERRED)
	connect("Game_Is_over", _Game_Is_over, CONNECT_DEFERRED)
#

func _Game_Is_over(ply):
	var roundname = "round_{rnd}".format({"rnd":str(currentround)})
#	var won

#	match ply:
#		"p1":
#			won = 1
#		"p2":
#			won = 2

	playerdic[roundname] = {"p1": p1_score, "p2":p2_score, "won": ply}
	currentround += 1
	pass
#func ScoreLeft(score : int):
#	pass # Replace with function body.
#
#
#func ScoreRight(score : int):
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass
