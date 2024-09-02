extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var score = 0

@onready var anim = $AnimatedSprite2D
@onready var label_score = $"../UI/label_score"

# Estados del jugador 
enum states  {IDLE, LEFT, RIGHT, JUMPING, FALLING}
var current_state = states.IDLE

func _physics_process(delta):
	
	match current_state:
		states.IDLE:
			anim.play("idle")
		states.LEFT:
			anim.play("walk_left")
		states.RIGHT:
			anim.play("walk_right")
		states.JUMPING:
			anim.play("jump")
		states.FALLING:
			anim.play("fall")
	
	# Escribir puntuación
	label_score.text = str(score)
	
	# Add the gravity.
	if not is_on_floor():
		
		velocity += get_gravity() * delta
		if velocity.y > 0:
			change_states(states.FALLING)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		change_states(states.JUMPING)
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Si se mueve
	if velocity != Vector2.ZERO : 
		if velocity.x > 0 : 
			change_states(states.RIGHT)
		else:
			if velocity.x < 0:
				change_states(states.LEFT)
	else:
		change_states(states.IDLE)


	move_and_slide()
	
# ------------------------------------------------------------------------------	
func change_states(new_state : states) -> void: 
	if new_state!=current_state:
		print("Estado cambiado: " + states.find_key(current_state) + " -> " + str(states.find_key(new_state)))
		current_state = new_state
	
	
func add_score(value: int) -> void:
	score += value
