extends Area2D

func _process(delta: float) -> void:
	# this feels awful
	position.y -= get_parent().bullet_speed * delta
