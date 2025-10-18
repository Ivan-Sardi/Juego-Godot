extends CharacterBody2D
# Este nodo representa un cuerpo con física en 2D que puede moverse y chocar con otros.

# --- Variables de movimiento ---
var speed: float = 0.0              # Velocidad actual del auto (positiva hacia adelante, negativa en reversa)
var acceleration: float = 400.0     # Qué tan rápido acelera el auto
var friction: float = 300.0         # Qué tan rápido se frena cuando no se acelera
var max_forward: float = 1000.0     # Velocidad máxima hacia adelante
var max_reverse: float = 400.0      # Velocidad máxima hacia atrás
var turn_speed: float = 2.5         # Qué tan rápido gira (radianes por segundo aprox.)

var driving: bool = false           # Si el jugador está manejando el auto o no

# --- Estados del vehículo ---
enum State { IDLE, DRIVE, DEAD }
var state: State = State.IDLE       # Estado actual (quieto, conduciendo o destruido)

# --- Función que se ejecuta en cada frame de física ---
func _physics_process(delta: float) -> void:
	if not driving:
		# Si no se está manejando, el coche no se mueve
		return

	# --- Controles de aceleración y freno ---
	if Input.is_action_pressed("Up"):
		# Acelera hacia adelante
		speed += acceleration * delta
	elif Input.is_action_pressed("Down"):
		# Acelera hacia atrás (reversa)
		speed -= acceleration * delta
	else:
		# Si no se presiona nada, aplica fricción para ir frenando
		if abs(speed) > 0:
			# move_toward reduce "speed" hacia 0 gradualmente
			speed = move_toward(speed, 0, friction * delta)

	# Limita la velocidad dentro de los máximos definidos
	speed = clamp(speed, -max_reverse, max_forward)

	# --- Controles de giro ---
	if abs(speed) > 10:  # Solo permite girar si el auto está moviéndose (evita girar en el lugar)
		if Input.is_action_pressed("Left"):
			# Gira hacia la izquierda (sentido horario)
			rotation -= turn_speed * delta * sign(speed)
		elif Input.is_action_pressed("Right"):
			# Gira hacia la derecha (sentido antihorario)
			rotation += turn_speed * delta * sign(speed)

	# --- Movimiento según la rotación actual ---
	# Vector2.RIGHT porque tu sprite apunta hacia la derecha.
	# Si el sprite apuntara hacia arriba, usarías Vector2.UP.
	var direction := Vector2.RIGHT.rotated(rotation)

	# Calcula la velocidad final aplicando dirección y velocidad
	velocity = direction * speed * delta

	# Mueve el cuerpo y detecta colisiones automáticamente
	move_and_collide(velocity)
