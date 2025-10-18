extends Node2D
# Este script controla la lógica general del mundo:
# - Detectar si el jugador está cerca del auto
# - Entrar o salir del vehículo
# - Cambiar entre cámaras (jugador / coche)

# --- Referencias a nodos de la escena ---
@onready var car = $Car                   # Referencia al nodo del auto
@onready var player = $Player             # Referencia al nodo del jugador
@onready var player_cam = $Player/Camera2D # Cámara del jugador (la que sigue al personaje)
@onready var car_cam = $Car/Camera2D       # Cámara del auto (la que sigue al coche)

# Variable que indica si el jugador está cerca del auto
var nearCar = false


# --- Detección de entrada al área del coche ---
func PersonajeEntraAArea(area: Area2D) -> void:
	# Si el área detectada se llama "Car", marcamos que el jugador está cerca
	if area.name == "Car":
		nearCar = true


# --- Detección de salida del área del coche ---
func PersonajeSaleDeArea(area: Area2D) -> void:
	# Si el jugador sale del área, ya no está cerca del coche
	if area.name == "Car":
		nearCar = false


# --- Entrada de teclado ---
func _input(event):
	# Si el jugador está cerca y presiona la tecla de interacción ("Interact")
	if nearCar and event.is_action_pressed("Interact"):

		# --- Si el jugador NO está conduciendo todavía ---
		if not car.driving:
			# 🚶 Entrar al auto
			car.driving = true                # Activa el modo de conducción en el auto
			player.exist = false              # Desactiva el control del personaje
			player.visible = false            # Oculta el sprite del jugador
			player.global_position = car.global_position # Mueve al jugador al mismo lugar del auto

			# Cambia la cámara activa al coche
			car_cam.make_current()

		# --- Si el jugador YA está conduciendo ---
		else:
			# 🚗 Salir del auto
			car.driving = false               # Desactiva el modo conducción
			player.exist = true               # Reactiva el control del personaje
			player.visible = true             # Vuelve a mostrarlo
			player.global_position = car.global_position + Vector2(0, 100)
			# Lo coloca un poco más abajo del coche (para que "salga")

			# Cambia la cámara activa al jugador
			player_cam.make_current()
