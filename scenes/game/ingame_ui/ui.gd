extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	# Global Signals
	Game.connect("Left_Player_Scored", ScoreLeft, CONNECT_DEFERRED)
	Game.connect("Right_Player_Scored", ScoreRight, CONNECT_DEFERRED)
	Game.connect("Game_Is_over", Game_Is_over, CONNECT_DEFERRED)
	Game.connect("New_Game_Started", New_Game_Started, CONNECT_DEFERRED)
	Game.connect("Next_Round_Started", Next_Round_Started, CONNECT_DEFERRED)
	######


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func New_Game_Started():
	%PlayerScoreLeft.text = "00000"
	%PlayerScoreRight.text = "00000"
	%WinLabel.visible = false
	%StartLabel.visible = false
	%LabelP1Name.text = Game.playerdic["player1"]
	%LabelP2Name.text = Game.playerdic["player2"]


func Next_Round_Started():
	%StartLabel.visible = false


func ScoreLeft(score : int):
	Game.p1_score += score
	%PlayerScoreLeft.text = str(Game.p1_score)
	%StartLabel.visible = true


func ScoreRight(score : int):
	Game.p2_score += score
	%PlayerScoreRight.text = str(Game.p2_score)
	%StartLabel.visible = true


func Game_Is_over(player : String):
	%WinLabel.text = "GameOver %s has won" % player
	%WinLabel.visible = true
