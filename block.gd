extends Control

@export var colors : Array[Color]

var health: int

func _ready() -> void:
	$Background.color = colors[randi() % colors.size()]
	$Particles.color = $Background.color
	health = randi_range(get_parent().min_block_health, get_parent().max_block_health)
	update_health_label()

func _process(delta: float) -> void:
	# getting bullet_speed like this feels awful
	position.y += get_parent().block_speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		health -= 1
		update_health_label()
		get_parent().increase_score()
		
		area.get_node("CollisionShape2D").set_deferred("disabled", true)
		area.get_node("Sprite2D").hide()
		area.get_node("Particles").position = area.position
		area.get_node("Particles").emitting = true
		
		if health <= 0:
			print(position)
			$Particles.position = position + Vector2(54, 54)
			$Particles.emitting = true
			$Background.hide()
			$HealthLabel.hide()
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			get_parent().time = 10
			get_parent().update_time_text()

func update_health_label() -> void:
	$HealthLabel.text = str(health)

func _on_particles_finished() -> void:
	queue_free()
