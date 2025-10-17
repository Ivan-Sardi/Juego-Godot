extends CharacterBody2D

var speed = 0
var acceleration = 2
var pos_car # Para despues hacer que gire
var recoil = 3
var friction = 0.9
var max_forward = 10
var max_reverse = 5

var driving = false # Booleano para saber si esta o no siendo controlado el vehiculo

# -- Referencia a objetos --
@onready var player = get_parent().get_node("Player")

# -- Distintos estados --
enum State {
	IDLE,
	DRIVE,
	DEAD
}

var state = State.IDLE # Variable del estado/animaciones

func _physics_process(delta: float) -> void:
	if driving:

		player.global_position = global_position - Vector2(466,293) # Mueve el personaje al auto

		# -- Movimiento del auto --
		velocity.y = -speed
		if Input.is_action_pressed("Up"):
			speed += acceleration

		# -- Maquina de estados --
		match state: 
			State.IDLE:

				# ANIMACION DE ESTAR QUIETO

				# --- CAMBIO ---
				if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
					state = State.DRIVE

			State.DRIVE:

				# ANIMACION DE MANEJAR

				# -- Movimiento del auto --
				if Input.is_action_pressed("Up"):
					speed += acceleration # Aumenta la velocidad
				elif Input.is_action_pressed("Down"):
					speed -= acceleration # Disminuye la velocidad
				else:
					speed *= friction # Frena de a poco cuando no presionas nada
				speed = clamp(speed, -max_reverse, max_forward) # Velocidad y retroceso maximo

				position.y -= speed


				# -- Rotacion del vehiculo --
				

				# --- CAMBIO ---
				

			State.DEAD:

				# ANIMACION DE MUERTE

				# --- CAMBIO ---
				pass

		move_and_slide()
