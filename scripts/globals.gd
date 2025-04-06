extends Node

var MaxScore : int = 10
var currentround : int = 1
var maxrounds : int = 3

var hasGamestartet : bool = false
var waitForNextRound : bool = false
var isMultiplayerGame : bool = false

var GameScene : PackedScene = preload("res://scenes/game/Pong_40.tscn")

var playerdic : Dictionary = {"player1":"", "player2":"", "Rounds":1}

var DebugControl : Control :
	set (value):
		DebugControl = value
	get:
		return DebugControl

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
signal Game_Window_Size_Changed


# Called when the node enters the scene tree for the first time.
func _ready():
	Game_Is_over.connect( _Game_Is_over, CONNECT_DEFERRED)
	get_tree().get_root().size_changed.connect(func(): Game_Window_Size_Changed.emit())


func _check_win_state():
	if(MaxScore == p1_score):
		emit_signal("Game_Is_over", playerdic["player1"])
	elif(MaxScore == p2_score):
		emit_signal("Game_Is_over", playerdic["player2"])


func update_player_dict(p1:String, p2:String,score:int = 10,rounds:int = 3, colors:Array = [Color.DARK_BLUE, Color.ORANGE_RED]):
	playerdic.clear()
	playerdic = {"player1":p1, "player2":p2, "rounds":rounds, "score": score, "colors":colors}

	for r in range(1, rounds+1):
		var roundname = "round_{rnd}".format({"rnd":str(r)})
		playerdic[roundname] = {"p1": 0, "p2":0, "won": "NONE"}
	pass



func _Game_Is_over(ply):
	var roundname = "round_{rnd}".format({"rnd":str(currentround)})

	playerdic[roundname] = {"p1": p1_score, "p2":p2_score, "won": ply}
	currentround += 1
	pass


func get_playercolor(ply:int) -> Color:
	#var col = playerdic["colors"][ply]
	randomize()
	return Color.from_rgba8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))# col
