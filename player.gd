extends CharacterBody2D

const SPEED = 400 # Velocidad inicial
var speed = SPEED

# --- ENUMERACION ---
enum State {
	IDLE,
	CAMINAR,
	DRIVE
}

var state = State.IDLE #Creamos una variable para el switch

func _physics_process(delta: float) -> void:

	var dir = Input.get_vector("Left", "Right", "Up", "Down")

# --- MAQUINA DE ESTADOS ---
	match state: 

		State.IDLE:

			# --- EJECUCION ---
			

			# --- CAMBIO ---
			if dir:
				state = State.CAMINAR

		State.CAMINAR:

			# --- EJECUCION ---
			velocity = dir * speed

			# --- CAMBIO ---
			if dir == Vector2.ZERO:
				state = State.IDLE

		State.DRIVE:

			# --- EJECUCION ---
			pass

			# --- CAMBIO ---
			

	move_and_slide()
