extends CharacterBody2D

var player_ref: CharacterBody2D = null
@export var SPEED: float = 150.0


func _physics_process(_delta: float) -> void:
	if player_ref == null:
		return
		
	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	velocity = direction * SPEED
	move_and_slide()


func _deteccao_corpo_dentro(body):
	player_ref = body


func deteccao_corpo_saiu(body):
	player_ref = null
