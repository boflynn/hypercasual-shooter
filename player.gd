extends Area2D

var x_minimum:int = 40
var x_maximum:int = 500

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		position.x = clamp(event.position.x, x_minimum, x_maximum)
	pass
