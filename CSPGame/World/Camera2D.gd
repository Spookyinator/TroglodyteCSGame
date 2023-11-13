extends Camera2D
@onready var top_left = $"../TopLeft"
@onready var bottom_right = $"../BottomRight"

func _ready():
	var up = top_left.global_position.y
	var left = top_left.global_position.x
	var right = bottom_right.global_position.x
	var down = bottom_right.global_position.y
	limit_left = left
	limit_top = up
	limit_right = right
	limit_bottom = down
	make_current()

