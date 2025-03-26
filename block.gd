extends Control

@export var colors : Array[Color]

var health: int

func _ready() -> void:
	$Background.color = colors[randi() % colors.size()]
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
		
		# destroy the bullet as well
		area.queue_free()
		
		if health <= 0:
			queue_free()

func update_health_label() -> void:
	$HealthLabel.text = str(health)
