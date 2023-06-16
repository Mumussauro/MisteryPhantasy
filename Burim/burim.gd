extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animacao")
@onready var texture: Sprite2D = get_node("Textura")
@onready var SPEED = 300.0
@onready var areataq: CollisionShape2D = get_node("Ataque/CollisionShape2D")

var can_attack: bool = true

func _physics_process(_delta):
	if can_attack == false:
		return
	
	move()
	animacao()
	ataque()
	direcao()
	
func move() -> void:
	velocity = direction() * SPEED
	move_and_slide()
	
func direction() -> Vector2:
	return Vector2(
		Input.get_axis("andar_esq", "andar_dir"),
		Input.get_axis("subir_", "descer_")
	).normalized()
	
	
func animacao() -> void:
	if velocity != Vector2.ZERO:
		animation.play("Run")
		return
	animation.play("Idle")
	
func ataque() -> void:
	if Input.is_action_just_pressed("ataq") and can_attack:
		can_attack = false
		animation.play("Attack")


func _on_animacao_animation_finished(_anim_name: String):
	can_attack = true

func direcao() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		areataq.position.x = 59
		
	if velocity.x < 0:
		texture.flip_h = true
		areataq.position.x = -59
	return
