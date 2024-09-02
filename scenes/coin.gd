extends Node2D
@export var value = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print(body)
	# Si colisiona con el jugador
	if body.name  == "Player":
		#Sumar el valor al contador
		body.add_score(value)
		queue_free()
