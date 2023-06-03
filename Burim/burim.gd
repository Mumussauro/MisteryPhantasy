extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta):

	var direction: Vector2 = get_direction()
	velocity = direction * SPEED
	move_and_slide()
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("andar_esq", "andar_dir"),
		Input.get_axis("subir_", "descer_")
	).normalized()
