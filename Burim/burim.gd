extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animacao")
@onready var auxanim: AnimationPlayer = get_node("AuxAnimacao")
@onready var texture: Sprite2D = get_node("Textura")
@onready var SPEED = 300.0
@onready var areataq: CollisionShape2D = get_node("Ataque/CollisionShape2D")
@export var damage: int = 1
@export var vida: int = 5


var can_attack: bool = true
var can_die: bool = false


func _physics_process(_delta):
	if (can_attack == false or 
	can_die == true):
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
	
func _on_animacao_animation_finished(anim_name: String) -> void:
	match anim_name:
		"Attack":
			can_attack = true
			
		"Morte":
			get_tree().reload_current_scene()
		
	
func direcao() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		areataq.position.x = 59
		
	if velocity.x < 0:
		texture.flip_h = true
		areataq.position.x = -59 
	return
	
func _on_ataque_body_entered(body):
	body.update_vida(damage)
	
func update_vida(value: int) -> void:
	vida -= value
	if vida <= 0:
		can_die = true
		animation.play("Morte")
		areataq.set_deferred("disabled", true)
		return
		
	auxanim.play("dano")

