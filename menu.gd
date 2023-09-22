extends Control

func _ready():
	var blur = $Blur
	blur.play()

func _on_botao_iniciar_pressed():
	get_tree().change_scene("res://cena1.tscn")


func _on_botao_creditos_pressed():
	get_tree().change_scene("res://Creditos.tscn")
