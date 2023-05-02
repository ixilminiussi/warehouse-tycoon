class_name Package extends RigidBody2D

@export var mouse_drag_scale = 40
@export var snap_distance = 75
@export var growth_scale = 4.5

const grab_sound = preload("res://assets/sounds/grab.wav") as AudioStreamWAV
const bad_release_sound = preload("res://assets/sounds/bad_release.wav") as AudioStreamWAV
const good_release_sound = preload("res://assets/sounds/good_release.wav") as AudioStreamWAV
const delete_sound = preload("res://assets/sounds/destroy.wav") as AudioStreamWAV
const rotate_sound = preload("res://assets/sounds/rotate.wav") as AudioStreamWAV
const norotate_sound = preload("res://assets/sounds/norotate.wav") as AudioStreamWAV

var is_fragile := false
var can_rotate := true
var is_heavy := false

var failed_fee : int
var sell_fee : int

var selected = false

var snap_to = Vector2.ZERO
var snapped = false

var rotations = [0, PI/2, PI, -PI/2]
var target_pointer := 0

var teleport := false
var is_valid_position := true
var about_to_delete := false

func _ready() -> void:
	$GhostSprite.z_index = 20
	if can_rotate: 
		$Sprite/Up.visible = false
		$GhostSprite/Up2.visible = false
	$GhostSprite.visible = false
	gravity_scale = 2
	add_to_group("package")


func _physics_process(delta) -> void:
	if selected:
		$GhostSprite.global_position = lerp($GhostSprite.global_position, get_global_mouse_position(), 25 * delta)
		
	$GhostSprite.rotation = rotations[target_pointer]


func _process(_delta) -> void:
	if selected:
		var inside = false
		var outside = false
		is_valid_position = true
		for child in $GhostSprite.get_children(): if child.is_in_group("cube"):
			if child.inside_truck: inside = true 
			else: 
				outside = true
				if child.global_position.x > 678 and not (about_to_delete and get_parent().money_count >= failed_fee):
					inside = true
			
			snap_to = child.snap_to
			if not child.is_valid_position:
				is_valid_position = false
		
		if inside and outside: is_valid_position = false
		
		if is_valid_position:
			$GhostSprite.modulate = Color.LIGHT_SEA_GREEN
		else:
			$GhostSprite.modulate = Color.MEDIUM_VIOLET_RED
	
		$GhostSprite.modulate.a = .6

func rotate_right() -> void:
	$AudioStreamPlayer2D.stream = norotate_sound
	if can_rotate:
		$AudioStreamPlayer2D.stream = rotate_sound
		target_pointer = (target_pointer + 1) % 4
	$AudioStreamPlayer2D.play()


func rotate_left() -> void:
	$AudioStreamPlayer2D.stream = norotate_sound
	if can_rotate:
		$AudioStreamPlayer2D.stream = rotate_sound
		target_pointer = target_pointer - 1 if target_pointer > 0 else 3
	$AudioStreamPlayer2D.play()


func cant_rotate() -> void:
	var rand_rotation = rotations[randi_range(0, 3)]
	rotation = rand_rotation
	$Sprite/Up.rotation = -rand_rotation
	$GhostSprite/Up2.rotation = -rand_rotation
	can_rotate = false
	sell_fee *= 2


func grab() -> void:
	selected = true
	freeze = true
	$Sprite.visible = false
	$GhostSprite.visible = true
	target_pointer = 0
	$AudioStreamPlayer2D.stream = grab_sound
	$AudioStreamPlayer2D.play()


func release() -> void: if selected:
	if about_to_delete: delete()
	
	selected = false
	$Sprite.visible = true
	$GhostSprite.visible = false
	
	if is_valid_position:
		global_position = $GhostSprite.global_position
		global_rotation = $GhostSprite.global_rotation
		global_position += snap_to
		$AudioStreamPlayer2D.stream = good_release_sound
		$AudioStreamPlayer2D.play()
	else:
		$AudioStreamPlayer2D.stream = bad_release_sound
		$AudioStreamPlayer2D.play()
	
	$GhostSprite.rotation = 0
	target_pointer = 0
	$GhostSprite.position = Vector2.ZERO
	
	if global_position.x > 624:
		add_to_group("truck")
	else:
		remove_from_group("truck")
	
	freeze = false
	get_tree().call_group("truck_updates","update")


func delete() -> void:
	if get_parent().money_count >= failed_fee:
		get_parent().get_node("AudioStreamPlayer2D").stream = delete_sound
		get_parent().get_node("AudioStreamPlayer2D").play()
		get_tree().call_group("truck_updates","update")
		get_parent().add_child(PointLabel.new(str(-failed_fee), -failed_fee, $GhostSprite.global_position - Vector2(50, 100)))
		queue_free()
	else:
		$AudioStreamPlayer2D.stream = bad_release_sound
		$AudioStreamPlayer2D.play()
		get_parent().add_child(PointLabel.new("no money !", -1, $GhostSprite.global_position - Vector2(200, 100)))


func sell(multiplier : int) -> void:	
	sell_fee *= multiplier
	get_parent().add_child(PointLabel.new(str(sell_fee), sell_fee, global_position))
	get_parent().money_count += sell_fee
	queue_free()


func _on_input_event(_viewport, _event, _shape_idx) -> void:
	if Input.is_action_just_pressed("click"):
		grab()


func _input(_event) -> void:
	if Input.is_action_just_released("click"):
		release()
	if Input.is_action_just_pressed("left"):
		if selected: rotate_left()
	if Input.is_action_just_pressed("right"):
		if selected: rotate_right()
