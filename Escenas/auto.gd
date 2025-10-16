extends CharacterBody2D

var speed = 400 # Velocidad

var driving = false # Booleano para saber si esta o no siendo controlado el vehiculo

# -- Referencia a objetos --
@onready var sprite = $Sprite2D
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
		var dir = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = dir * speed
		
		# -- Maquina de estados --
		match state: 
			State.IDLE:

				# ANIMACION DE ESTAR QUIETO
				
				# --- CAMBIO ---
				if dir:
					state = State.DRIVE

			State.DRIVE:
				
				# ANIMACION DE MANEJAR
				
				# -- Rotacion del vehiculo --
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
