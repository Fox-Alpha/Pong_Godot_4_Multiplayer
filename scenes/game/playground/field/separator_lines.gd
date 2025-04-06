extends Node2D

@export var TopLine : Sprite2D
@export var MiddleLine : Sprite2D
@export var BottomLine : Sprite2D

enum Positions {
	NOTDEF = -1,
	TOP,
	MIDDLE,
	BOTTOM
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.Game_Window_Size_Changed.connect(func(): 
		#PlayerLeftPosition = Vector2(10, get_viewport_rect().size.y/2)
		#PlayerRightPosition = Vector2(get_viewport_rect().size.x-10, get_viewport_rect().size.y/2)
		_reset_position()
	)
	_reset_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _reset_position() -> void:
	var screensize = get_viewport_rect()
	var x_center = screensize.get_center().x
	var sizeTo = Vector2(5.0, screensize.size.x)

	#region Obere und untere Linie
	ResetSeperatorLine(TopLine, Vector2(x_center, 120), sizeTo, Positions.TOP)
	# Middle Line TBD: ResetSeperatorLine(MiddleLine, Vector2(x_center, 120), sizeTo, Positions.MIDDLE)
	ResetSeperatorLine(BottomLine, Vector2(x_center, screensize.size.y-60), sizeTo, Positions.BOTTOM)
	#endregion

	#region Optische Mittellinie an ScreenSize anpassen
	var pgheight : int = %Separator_Bottom.position.y - %Separator_Top.position.y
	%Separator_Middle.position = Vector2(screensize.get_center().x, %Separator_Top.position.y)
	var sizeto=Vector2(5, pgheight)
	var size=%Separator_Middle.texture.get_size()
	var scalevactor=sizeto/size
	%Separator_Middle.scale = scalevactor
	#endregion


func ResetSeperatorLine(Seperator : Sprite2D, newPos : Vector2, sizeTo : Vector2, Pos : Positions = Positions.NOTDEF) -> void:
	if Pos < 0 or !is_instance_valid( Seperator) or sizeTo == Vector2.ZERO:
		return

	Seperator.scale = sizeTo / Seperator.texture.get_size()
	Seperator.position = newPos
	pass
