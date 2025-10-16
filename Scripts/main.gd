extends Node2D

# -- Referencia a objetos --
@onready var car = $Car
@onready var player = $Player 

var nearCar = false # Booleano para saber si esta en el area del auto

# -- Deteccion de areas --
func PersonajeEntraAArea(area: Area2D) -> void:
	if area.name == "Car":
		nearCar = true


func PersonajeSaleDeArea(area: Area2D) -> void:
	if area.name == "Car":
		nearCar = false
		
		
func _input(event):
	if nearCar and event.is_action_pressed("Interact"):
		car.driving = not car.driving
		player.caminando = not player.caminando
		player.visible = not player.visible
		player.global_position = car.global_position - Vector2(466,293) # Coloca al personaje en la ubicacion del auto, la resta es porque si no no anda que se yo
		
