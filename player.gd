extends CharacterBody2D

signal health_depleted

@onready var coin_label = %Label
var health = 100.0


var coin_counter = 0 
func _physics_process(delta):
	const SPEED = 600.0
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	# Taking damage
	const DAMAGE_RATE = 6.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coins"):
		set_coin(coin_counter + 1)
		print(coin_counter)
		health += 1

func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coin Count : " + str(coin_counter)
