extends Control

@onready var debug: Label = $Debug

signal SetDebugText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.DebugControl = self
	SetDebugText.connect(_SetDebugText)
	var screensize := get_viewport_rect()
	var bottomcenter := Vector2( screensize.size.x / 2.0, screensize.size.y)
	position = bottomcenter
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _SetDebugText(DbgText : String) -> void:
	debug.text = DbgText
	pass
