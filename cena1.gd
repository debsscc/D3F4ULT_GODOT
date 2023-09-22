extends Node2D

onready var popup = $Popup
onready var tween = $Tween
onready var jogador = $KinematicBody2D
onready var postit = $Postit

func _ready():
	$VideoPlayer.play()

func _on_VideoPlayer_finished():
	tween.interpolate_property(popup, "modulate:a", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	tween.connect("tween_all_completed", self, "_on_TransitionComplete")

func _on_TransitionComplete():
	$VideoPlayer.hide()
	$Postit.connect("pressed", self, "_on_postit_pressed")
	var sound_corredor = $Corredor_som
	var sound_2 = $Som_fundo
	$Corredor_som.play()
	$Som_fundo.play()

func _on_Postit_pressed():
	print(postit.rect_position.x, " ", jogador.global_position.x)
	if (abs(postit.rect_position.x - jogador.global_position.x) < 100):
		$Popup.show_modal()
		$papelzin_sound.play()

func _on_Porta_pressed():
	$Porta_Abrindo_som.play()
	get_tree().change_scene("res://Cena2.tscn")

func _on_x_pressed():
	$Popup.hide()
