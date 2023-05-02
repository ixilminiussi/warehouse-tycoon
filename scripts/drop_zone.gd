class_name DropZone extends Marker2D

const size = 104
const snap_distance = 52

var partner : Cube

var selected := false

func _init(x : int, y : int) -> void:
	position = Vector2(110 + size * x, 266 + size * y)
	add_to_group("zone")


func _draw() -> void:
	if selected:
		draw_rect(Rect2(-50, -50, size, size), Color(Color.WHITE_SMOKE, 0.2), true)


func select(cube : Cube) -> bool:
	queue_redraw()
	if selected and cube != partner:
		return false
	
	if abs(cube.global_position.x - global_position.x) <= 52 and abs(cube.global_position.y - global_position.y) <= 52:
		selected = true
		partner = cube
	else:
		selected = false
	
	return selected


func deselect() -> void:
	selected = false
	partner = null
	queue_redraw()
