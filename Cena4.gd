extends Node2D

onready var _animated_sprite = $mika/Mika

onready var jogador = $KinematicBody2D
onready var porta = $Porta
onready var mika = $Mika
onready var ManoDog = $ManoDOG
onready var pause = $Popup_Menu # Popup do menu


func _ready():
	pause.hide()
	$corredor_sound.play()
	_animated_sprite.play("frente");
	ManoDog.play("pisca")
	
func _process(delta):
		_abrir_pause()

func _abrir_pause():
	if Input.is_action_pressed("ui_cancel"):  # Verifica a tecla "Esc"
		$Popup_Menu.show()
		$corredor_sound.stop()
		ManoDog.stop()
		_animated_sprite.stop()

func _on_Porta_pressed():
		get_tree().change_scene("res://Creditos.tscn")


func _on_Mika_pressed():
		var d = Dialogic.start("sala_cena4")
		add_child(d)


func _on_Menu2_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Menu_pressed():
	$Popup_Menu.hide()
	$corredor_sound.play()
	ManoDog.play()
	_animated_sprite.play()
