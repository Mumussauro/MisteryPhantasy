extends CharacterBody2D

@onready var animation: AnimationPlayer = get_node("Animacao")
@onready var auxanim: AnimationPlayer = get_node("Auxanim")

var can_die: bool = false
var player_ref: CharacterBody2D = null

@export var damage: int = 1
@export var vida: int = 3
@export var SPEED: float = 150.0
@export var distancia_limite: float = 60.0

func _physics_process(_delta: float) -> void:
	if can_die:
		return
		
	if player_ref == null:
		velocity = Vector2.ZERO
		animacao()
		return
		
	var direcao: Vector2 = global_position.direction_to(player_ref.global_position)
	var distancia: float = global_position.distance_to(player_ref.global_position)
	
	if distancia < distancia_limite:
		animation.play("Attack")
		return
	
	
	velocity = direcao * SPEED
	move_and_slide()
	animacao()

func animacao() -> void:
	if velocity != Vector2.ZERO:
		animation.play("Run")
		return
		
	animation.play("Idle")
	
	
func update_vida(value: int) -> void:
	vida -= value
	if vida <= 0:
		can_die = true
		animation.play("Morte")
		return
	auxanim.play("hit")
	
func _deteccao_corpo_dentro(body):
	player_ref = body


func deteccao_corpo_saiu(_body):
	player_ref = null


func animacao_acabou(anim_name: String) -> void:
	if anim_name == "Morte":
		queue_free()
