extends Node2D

onready var animated_def = $def
onready var animated_pantera = $pantera
onready var animated_leoa = $leoa

onready var jogador = $KinematicBody2D
onready var porta = $Porta
onready var lixo = $botao_lixo
onready var galera = $purr_botao
onready var pause = $Popup_Menu # Popup do menu


func _ready():
	$corredor_sound.play()
	animated_leoa.play("frente")
	animated_def.play("frente")
	animated_pantera.play("frente")
	
	pause.hide()

func _process(delta):
		_abrir_pause()

func _abrir_pause():
	if Input.is_action_pressed("ui_cancel"):  # Verifica a tecla "Esc"
		$Popup_Menu.show()
		$corredor_sound.stop()
		animated_leoa.stop()
		animated_def.stop()
		animated_pantera.stop()
		
func _on_Porta_pressed():
		$porta_sound.play()
		get_tree().change_scene("res://Cena4.tscn")
	
func _on_botao_lixo_pressed():
	var som_lixo = $somLixo
	if (abs(lixo.rect_position.x - jogador.global_position.x) < 50):
		$somLixo.play()

func _on_Menu_pressed():
	
	$Popup_Menu.hide()
	$corredor_sound.play()
	animated_leoa.play("frente")
	animated_def.play("frente")
	animated_pantera.play("frente")

func _on_Menu2_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_purr_botao_pressed():
		var d = Dialogic.start("corredor")
		add_child(d)
