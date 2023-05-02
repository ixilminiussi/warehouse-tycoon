extends StaticBody2D

const simple_scene = preload("res://scenes/packages/simple_package.tscn")
const double_scene = preload("res://scenes/packages/double_package.tscn")
const arrow_scene = preload("res://scenes/packages/arrow_package.tscn")
const big_scene = preload("res://scenes/packages/big_package.tscn")
const z_scene = preload("res://scenes/packages/z_package.tscn")
const s_scene = preload("res://scenes/packages/s_package.tscn")
const T_scene = preload("res://scenes/packages/T_package.tscn")
const I_scene = preload("res://scenes/packages/I_package.tscn")
const L_scene = preload("res://scenes/packages/L_package.tscn")
const R_scene = preload("res://scenes/packages/R_package.tscn")
const Z_scene = preload("res://scenes/packages/Z_package.tscn")
const S_scene = preload("res://scenes/packages/S_package.tscn")
const bowl_scene = preload("res://scenes/packages/bowl_package.tscn")
const V_scene = preload("res://scenes/packages/V_package.tscn")
const d_scene = preload("res://scenes/packages/d_package.tscn")
const b_scene = preload("res://scenes/packages/b_package.tscn")
const triple_scene = preload("res://scenes/packages/triple_package.tscn")


var cant_rotate_likelihood = 6
var sm_range = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void: pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass


func _on_add_button_lg_pressed() -> void:
	var instance
	var can_rotate = randi_range(1, cant_rotate_likelihood)
	
	match randi_range(1, 6):
		1:
			instance = get_S()
		2:
			instance = get_Z()
		3:
			instance = get_bowl()
		4:
			instance = get_V()
		5:
			instance = get_b()
		6:
			instance = get_d()
	
	instance.failed_fee = 100
	instance.sell_fee = 25
	
	if can_rotate == 1: instance.cant_rotate()
	instance.global_position = $spawn_point.global_position
	get_parent().add_child(instance)
	$AudioStreamPlayer2D.play()
	get_parent().update()


func _on_add_button_md_pressed() -> void:
	var instance
	var can_rotate = randi_range(1, cant_rotate_likelihood)
	
	match randi_range(4, 10):
		4:
			instance = get_big()
		5:
			instance = get_L()
		6:
			instance = get_R()
		7:
			instance = get_s()
		8:
			instance = get_z()
		9:
			instance = get_I()
		10:
			instance = get_T()
	
	instance.failed_fee = 100
	instance.sell_fee = 10	
	if can_rotate == 1: instance.cant_rotate()
	instance.global_position = $spawn_point.global_position
	get_parent().add_child(instance)
	$AudioStreamPlayer2D.play()
	get_parent().update()


func _on_add_button_sm_pressed() -> void:
	var instance
	var can_rotate = randi_range(1, cant_rotate_likelihood)
	
	match randi_range(2, sm_range):
		1:
			instance = get_simple()
		2:
			instance = get_double()
		3:
			instance = get_arrow()
		4:
			instance = get_triple()
	
	instance.failed_fee = 50
	instance.sell_fee = 0
	if can_rotate == 1: instance.cant_rotate()
	instance.global_position = $spawn_point.global_position
	get_parent().add_child(instance)
	$AudioStreamPlayer2D.play()
	get_parent().update()


func get_simple(): return simple_scene.instantiate() as Package

func get_double(): return double_scene.instantiate() as Package

func get_arrow(): return arrow_scene.instantiate() as Package

func get_triple(): return triple_scene.instantiate() as Package

func get_big(): return big_scene.instantiate() as Package

func get_L(): return L_scene.instantiate() as Package

func get_R(): return R_scene.instantiate() as Package

func get_V(): return V_scene.instantiate() as Package

func get_b(): return b_scene.instantiate() as Package

func get_d(): return d_scene.instantiate() as Package

func get_s(): return s_scene.instantiate() as Package

func get_z(): return z_scene.instantiate() as Package

func get_I(): return I_scene.instantiate() as Package

func get_T(): return T_scene.instantiate() as Package

func get_S(): return S_scene.instantiate() as Package

func get_Z(): return Z_scene.instantiate() as Package

func get_bowl(): return bowl_scene.instantiate() as Package
