class_name Cube extends Marker2D


var is_valid_position := false
var snap_to : Vector2

var inside_truck


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	is_valid_position = false
	inside_truck = false
	snap_to = Vector2.ZERO
	
	for drop_zone in get_tree().get_nodes_in_group("zone"):
		var try = drop_zone.select(self)
		if abs(drop_zone.global_position.x - global_position.x) <= 52 and abs(drop_zone.global_position.y - global_position.y) <= 52:
			inside_truck = true
			if try:
				snap_to = drop_zone.global_position - global_position
				is_valid_position = true
	
	if not inside_truck: is_valid_position = true
