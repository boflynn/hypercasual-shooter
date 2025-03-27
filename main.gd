extends Node

@export var bullet : PackedScene
@export var block : PackedScene

var bullet_speed: int = 500

var block_speed: int = 150
var block_size: int = 108

var min_block_health: int = 10
var max_block_health: int = 20
var blocks_to_spawn: int = 2

var time: int = 10
func update_time_text() -> void:
	$UI/TimeLabel.text = str(time)

var score: int = 0
func increase_score() -> void:
	score += 1
	$UI/ScoreLabel.text = "Score: %s" % score

func _on_fire_rate_timer_timeout() -> void:
	var bullet_instance: Area2D = bullet.instantiate()
	bullet_instance.position = $Player.position
	
	add_child(bullet_instance)

func _on_block_spawn_timer_timeout() -> void:
	var positions = [0,1,2,3,4]
	positions.shuffle()
	var index: int = 0
	
	while index < blocks_to_spawn:
		var block_instance: Control = block.instantiate()
		block_instance.position.x = positions[index] * block_size
		block_instance.position.y = -block_size
		
		add_child(block_instance)
		index += 1

func _on_countdown_timer_timeout() -> void:
	if $GameOverUI.is_game_over == false:
		time -= 1
		update_time_text()

	if time <= 0:
		$GameOverUI.game_over()

func _on_progression_timer_timeout() -> void:
	if blocks_to_spawn < 4:
		blocks_to_spawn += 1
	
	bullet_speed *= 1.25
	block_speed *= 1.25
	min_block_health *= 1.25
	max_block_health *= 1.25
	
	$FireRateTimer.wait_time *= 0.9
