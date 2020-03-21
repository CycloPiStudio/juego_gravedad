extends Node2D

var numero_pantallas
var pantalla = 1
var personaje = preload("res://juego/personaje/jugador.tscn")

var escena = load("res://juego/pantallas/pantalla1/pantalla1.tscn").instance()
#var controles = load("res://juego/controles/UI.tscn")
func _ready():
	
	numero_pantallas = 2
	cargar_escenario() 
	cargar_jugador()
#	cargar_controles()
#func _input(event):
#	if event.is_action_pressed("pausa"):
#		if get_tree().get_root().get_node("Principal.tscn").is_paused():
#			get_tree().get_root().get_node("Principal.tscn").paused = false
#
#		else:
#			get_tree().get_root().get_node("Principal.tscn").paused = true
			
func cargar_escenario():
	var node = escena
	add_child(node)

func personaje_salida(node):
	var posicion_salida = get_node("punto_salida")
	node.set_global_position(posicion_salida.get_global_position())

func cargar_jugador():
	var node = personaje.instance()
	personaje_salida(node)
	add_child(node)

#func cargar_controles():
#	var node = controles.instance()
#	add_child(node)


func cambiar_pantalla():
	# quitar escena actual 
	
	var level = get_node("pantalla" + str(pantalla))
	level.queue_free()

	# Add the next level
	pantalla+=1
	var next_level_resource = load("res://juego/pantallas/pantalla" + str(pantalla) + "/pantalla" + str(pantalla) +".tscn")
	var next_level = next_level_resource.instance()
	call_deferred("add_child",next_level)
	personaje_salida($jugador)

# variable para evitar error de valor devuelto no utilizado por change_scene


var vargameover
func game_over():
	vargameover = get_tree().change_scene("res://juego/menus/menu_principal.tscn")

func _on_Timer_entre_pantallas_timeout():
	
	$Control/LabelNextLevel/AnimationPlayer.play("next_level_anima")



func _on_AnimationPlayer_animation_finished(next_level_anima):
	next_level_anima = $Control/LabelNextLevel.hide()
	cambiar_pantalla()

	


#func _on_AnimationPlayer2_animation_finished(animacion_gameover):
#	game_over()
