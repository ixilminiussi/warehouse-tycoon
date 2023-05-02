extends Control

var gamemode = 2

var money_count := 0
var loss_rate = 5
var timer

var truck_count = 0
var level_pointer = 0
const shipping_costs = [100, 400, 600, 300, 1000, 1100, 700, 1200, 1800]
const likelihoods = [6, 6, 6, 2, 4, 4, 10, 2, 10, 5]
const game_over_scene = preload("res://scenes/game_over.tscn")

signal game_over

func _ready(): 
		$truck.shipping_cost = shipping_costs[level_pointer]
		$belt.cant_rotate_likelihood = likelihoods[level_pointer]
		update()

func _process(_delta) -> void: pass

func update() -> void:
	var count = cube_count()
	print(count)
	$Pannel/add_button_lg.disabled = true if count > 35 else false
	$Pannel/add_button_md.disabled = true if count > 36 else false
	$Pannel/add_button_sm.disabled = true if count > 38 else false
	$belt.sm_range = 2 if count == 38 else 4
	
	$Labels/BalanceLabel.text = "balance : " + str(money_count)
	$Labels/IncomeLabel.text =  str($truck.how_much())
	if $truck.get_multiplier() == 2: $Labels/IncomeLabel.text += "[color=#5b2fa9] x" + str($truck.get_multiplier()) + "[/color]"
	if $truck.get_multiplier() == 5: $Labels/IncomeLabel.text += "[color=#4992d6] x" + str($truck.get_multiplier()) + "[/color]"
	if $truck.get_multiplier() == 10: $Labels/IncomeLabel.text += "[color=#deb663] x" + str($truck.get_multiplier()) + "[/color]"
	$Labels/ShippingLabel.text = "-" + str($truck.shipping_cost)

func cube_count() -> int:
	var i = 0
	for cube in get_tree().get_nodes_in_group("cube"): i += 1
	return i


func update_truck_count() -> void:
	update()
	
	if money_count > 0:
		truck_count += 1
		level_pointer = clamp(truck_count, 0, 15)
		$truck.shipping_cost = shipping_costs[level_pointer]
		$belt.cant_rotate_likelihood = likelihoods[level_pointer]
	else:
		emit_signal("game_over")
		await get_tree().create_timer(2).timeout
		
		var instance = game_over_scene.instantiate()
		get_parent().add_child(instance)
		instance.initialize(truck_count, money_count)
		self.queue_free()
	
	update()
