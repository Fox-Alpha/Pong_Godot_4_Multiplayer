extends VBoxContainer

@export var backbuttonmenu : Control

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_back_to_mainmenu_pressed():
	visible = false
	backbuttonmenu.visible = true


func _on_button_start_pressed():
	print_debug("Start pressed !")
	var p1 = %EditPlayer1Name.text
	var p2 = %EditPlayer2Name.text
	var colors:Array[Color]
	var score:int
	var rounds:int	

	if(%EditLocalMaxPointsPerRound.text.is_valid_int()):
		score = %EditLocalMaxPointsPerRound.text.to_int()
#
	if(%EditLocalMaxRounds.text.is_valid_int()):
		rounds = %EditLocalMaxRounds.text.to_int()

	colors.append(%ColorPickerButtonP1.color)
	colors.append(%ColorPickerButtonP2.color)

	if(p1.is_empty()): p1 = "Player1"
	if(p2.is_empty()): p2 = "Player2"
	if(score <=0) : score = 10
	if(rounds <=0) : rounds = 3
	
#	Game.update_player_dict(p1, p2)
	Game.update_player_dict(p1, p2, score, rounds, colors)
	
	get_tree().change_scene_to_packed(Game.GameScene)
	pass # Replace with function body.



func _on_h_slider_rounds_value_changed(value):
	%EditLocalMaxRounds.text = str(value)
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	%EditLocalMaxPointsPerRound.text = str(value)
	pass # Replace with function body.


func _on_h_slider_points_ready():
	%HSliderPoints.value = %EditLocalMaxPointsPerRound.text.to_int()


func _on_edit_local_max_rounds_ready():
	%HSliderRounds.value = %EditLocalMaxRounds.text.to_int()
