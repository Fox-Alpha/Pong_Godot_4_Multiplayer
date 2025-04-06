extends Control

@onready var _game_message_container: PanelContainer = %PanelContainer_GameMessages
@onready var _game_message_label: Label = %GameMessageLabel


const ANYKEYMESSAGE : String ="Press Any Key to start"
const GAMEOVER : String ="Game Over"
const NEXTROUND : String ="Next Round"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Global Signals
	Game.Left_Player_Scored.connect(ScoreLeft, CONNECT_DEFERRED)
	Game.Right_Player_Scored.connect(ScoreRight, CONNECT_DEFERRED)
	Game.Game_Is_over.connect(Game_Is_over, CONNECT_DEFERRED)
	Game.New_Game_Started.connect(New_Game_Started, CONNECT_DEFERRED)
	Game.Next_Round_Started.connect(Next_Round_Started, CONNECT_DEFERRED)
	######


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func New_Game_Started():
	%PlayerScoreLeft.text = "00000"
	%PlayerScoreRight.text = "00000"

	var p : String = ""
	p = Game.playerdic["player1"]
	%LabelP1Name.text = p if (!p.is_empty()) else "P1"
	
	p = ""
	p = Game.playerdic["player2"]
	%LabelP2Name.text = p if (!p.is_empty()) else "P2"


func Next_Round_Started():
	_game_message_container.visible = false


func ScoreLeft(score : int):
	Game.p1_score += score
	%PlayerScoreLeft.text = str(Game.p1_score)
	#%StartLabel.visible = true


func ScoreRight(score : int):
	Game.p2_score += score
	%PlayerScoreRight.text = str(Game.p2_score)
	#%StartLabel.visible = true


func Game_Is_over(player : String):
	#%WinLabel.text = "GameOver %s has won" % player
	#%WinLabel.visible = true
	ShowGameMessage("GameOver %s has won" % player)

func ShowGameMessage(message : String) -> void:
	_game_message_label.text = message
	_game_message_container.visible = true
	pass
