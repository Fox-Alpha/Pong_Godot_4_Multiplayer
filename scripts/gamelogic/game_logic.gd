extends Node
class_name PongGameLogic

enum Players {
	PLAYER_1,
	PLAYER_2
}

func _ready() -> void:
	print("GameLogic => _ready()")
	pass


func _enter_tree() -> void:
	print("GameLogic => _enter_tree()")
	Game.Register_Game_Logic.emit(self.get_instance_id())
	pass


func get_playercolor(_ply:int) -> Color:
	#Todo Save Player color in Dictionary for next Round
	#var col = playerdic["colors"][ply]
	randomize()
	return Color.from_rgba8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))# col


#func update_player_dict(p1:String = "P1", p2:String  = "P2", m_score:int = 10, m_rounds:int = 3, colors:Array = [Color.DARK_BLUE, Color.ORANGE_RED]):
	#playerdic.clear()
	#playerdic = {"player1":p1, "player2":p2, "max_rounds":m_rounds, "max_score": m_score, "colors":colors}

	#for r in range(1, m_rounds):
		#var roundname = "round_{rnd}".format({"rnd":str(r)})
		#playerdic[roundname] = {"p1": 0, "p2":0, "won": "NONE"}
	#pass
