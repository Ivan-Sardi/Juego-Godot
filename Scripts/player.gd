extends CharacterBody2D

var speed = 400

# --- ENUMERACION ---
enum State {
	IDLE,
	WALK,
	DRIVE,
	DEAD
}

var state = State.IDLE #Creamos una variable para el switch

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = dir * speed
# --- MAQUINA DE ESTADOS ---
	match state: 
		State.IDLE:

			# --- EJECUCION ---
			# ANIMACION DE ESTAR QUIETO
			
			# --- CAMBIO ---
			if dir:
				state = State.WALK

		State.WALK:
			
			# --- EJECUCION ---
			# ANIMACION DE CAMINAR
			
			# --- CAMBIO ---
			if dir == Vector2.ZERO:
				state = State.IDLE

		State.DRIVE:
			
			# --- EJECUCION ---
			# ANIMACION DE MANEJAR
			
			pass

			# --- CAMBIO ---
			

	move_and_slide()
