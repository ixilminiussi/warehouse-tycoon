extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	var selecting = false
	for package in get_tree().get_nodes_in_group("package"):
		if package.selected: 
			selecting = true
			package.about_to_delete = true
	
	if selecting:
		$trashcan_open.visible = true
	else: $trashcan_open.visible = false


func _on_mouse_exited():
	$trashcan_open.visible = false
	var selecting = false
	for package in get_tree().get_nodes_in_group("package"):
		if package.selected: 
			selecting = true
		package.about_to_delete = false
	
	get_parent().get_parent().update()
