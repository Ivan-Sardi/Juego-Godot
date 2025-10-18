extends CharacterBody2D

var speed = 400

var exist = true # Booleano para saber si esta o no siendo controlado el personaje

# -- Referencia a objetos --
@onready var sprite = $AnimatedSprite2D


# -- Distintos estados --
enum State {
	IDLE,
	WALK,
	DEAD
}

var state = State.IDLE # Variable del estado

func _ready():
	$Camera2D.make_current()

func _physics_process(delta: float) -> void:
	if exist:

		# -- Movimiento del personaje --
		var dir = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = dir * speed

		# -- Maquina de estados --
		match state: 
			State.IDLE:

				# ANIMACION DE ESTAR QUIETO

				# --- CAMBIO ---
				if dir:
					state = State.WALK

			State.WALK:

				# ANIMACION DE MANEJAR

				# -- Rotacion del personaje --
				match dir:
					Vector2(0.0, -1.0):
						sprite.rotation_degrees = 270
					Vector2(0.0, 1.0):
						sprite.rotation_degrees = 90
					Vector2(-1.0, 0.0):
						sprite.rotation_degrees = 180
					Vector2(1.0, 0.0):
						sprite.rotation_degrees = 0

				# --- CAMBIO ---
				if dir == Vector2.ZERO:
					state = State.IDLE

			State.DEAD:

				# ANIMACION DE MUERTE

				# --- CAMBIO ---
				pass

		move_and_slide()
