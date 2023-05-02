extends StaticBody2D

const leaving_sound = preload("res://assets/sounds/car_leaving.wav")
const arriving_sound = preload("res://assets/sounds/car_arriving.wav")
var table = []
const WIDTH := 8
const HEIGHT := 5

var shipping_cost = 500

var start_position = Vector2(624, -51)


# Called when the node enters the scene tree for the first time.
func _ready():	
	for x in range(WIDTH):
		table.append([])
		table[x] = []
		for y in range(HEIGHT):
			table[x].append([])
			table[x][y] = DropZone.new(x,y)
			add_child(table[x][y])
	
	
	$AudioStreamPlayer2D.stream = arriving_sound
	$AudioStreamPlayer2D.play()
	update()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", start_position, 3)
	update()


func update():
	var h = get_count() / 40 * 136
	var y = 136 - h
	$Barempty/BarFull.region_rect.position.y = y
	$Barempty/BarFull.region_rect.size.y = h
	$Barempty/BarFull.position.y = y/2 + 1


func get_count() -> float:
	var count : float = 0
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if table[x][y].selected: count += 1
	
	return count


func get_multiplier() -> int:
	var count = get_count()
	
	if count == 40: return 10
	if count >= 30: return 5
	if count >= 20: return 2
	return 1


func how_much() -> int:
	var money = 0
	for box in get_tree().get_nodes_in_group("truck"):
		money += box.sell_fee
		
	return money


func _on_send_button_pressed() -> void:
	get_tree().get_first_node_in_group("send_button").disabled = true
	$AudioStreamPlayer2D.stream = leaving_sound
	$AudioStreamPlayer2D.play()
	update()
	get_parent().update()
	var multiplier = get_multiplier()
	
	for box in get_tree().get_nodes_in_group("truck"):
		box.sell(multiplier)
		await get_tree().create_timer(0.1).timeout
	
	get_parent().money_count -= shipping_cost
	
	for x in range(WIDTH):
		for y in range(HEIGHT):
			table[x][y].deselect()
			
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", start_position + Vector2(1500, 0), 3)
	tween.tween_callback(come_back)


func come_back():
	get_parent().update_truck_count()
	
	if get_parent().money_count >= 0:
		$AudioStreamPlayer2D.stream = arriving_sound
		$AudioStreamPlayer2D.play()
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", start_position, 3)
	
	get_tree().get_first_node_in_group("send_button").disabled = false
	update()

func set_shipping_cost(cost : int) -> void:
	shipping_cost = cost


func _on_pannel_done():
	pass # Replace with function body.
