extends CharacterBody2D

# --- Variables de movimiento ---
var speed = 0.0              
var acceleration = 400.0     
var friction = 300.0        
var max_forward = 1000.0    
var max_reverse = 400.0      
var turn_speed = 0.1      
var turn_max = 2.5

var driving = false           # Si el jugador está manejando el auto o no

# --- Estados del vehículo ---
enum State { IDLE, DRIVE, DEAD }
var state = State.IDLE

# --- Función que se ejecuta en cada frame de física ---
func _physics_process(delta: float) -> void:
	if not driving:
		# Si no se está manejando, el coche no se mueve
		return

	match state:

		State.IDLE:

			# AGREGAR ANIMACION

			# -- Cambio --
			if Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Down"):
				state = State.DRIVE

		State.DRIVE:

			# --- Controles de aceleración y freno ---
			if Input.is_action_pressed("Up"):
				# Acelera hacia adelante
				speed += acceleration * delta
				# Aumenta la velocidad de doblado
				if speed > 10:
					turn_speed += 0.4 * delta
				elif speed < 0:
					turn_speed -= 0.4 * delta
			elif Input.is_action_pressed("Down"):
				# Acelera hacia atrás (reversa)
				speed -= acceleration * delta
				# Aumenta la velocidad de doblado
				if speed > 0:
					turn_speed -= 0.4 * delta
				elif speed < 5:
					turn_speed += 0.4 * delta
			else:
				# Si no se presiona nada, aplica fricción para ir frenando y disminuye la velocidad de doblado
				if abs(speed) > 0:
					# move_toward reduce "speed" hacia 0 gradualmente
					speed = move_toward(speed, 0, friction * delta)
					turn_speed -= 0.4 * delta 
				if speed < 0:
					turn_speed -= 0.4 * delta

			# Limita la velocidad dentro de los máximos definidos
			speed = clamp(speed, -max_reverse, max_forward)
			turn_speed = clamp(turn_speed, 0, turn_max)

			# --- Controles de giro ---
			if abs(speed) > 10:  # Solo permite girar si el auto está moviéndose (evita girar en el lugar)
				if Input.is_action_pressed("Left"):
					rotation -= turn_speed * delta * sign(speed)
				elif Input.is_action_pressed("Right"):
					rotation += turn_speed * delta * sign(speed)

			# --- Movimiento según la rotación actual ---
			var direction := Vector2.RIGHT.rotated(rotation)

			# Calcula la velocidad final aplicando dirección y velocidad
			velocity = direction * speed * delta

	# Mueve el cuerpo y detecta colisiones automáticamente
	move_and_collide(velocity)
