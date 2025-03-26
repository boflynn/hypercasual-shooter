extends Control

@export var colors : Array[Color]

var health: int

func _ready() -> void:
	$Background.color = colors[randi() % colors.size()]
	health = randi_range(get_parent().min_block_health, get_parent().max_block_health)
	$HealthLabel.text = str(health)

func _process(delta: float) -> void:
	# getting bullet_speed like this feels awful
	position.y += get_parent().block_speed * delta
