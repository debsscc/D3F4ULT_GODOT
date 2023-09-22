extends Control

onready var popup = $Popup
var placeholder_visible = true
var notificacao_ja_reproduzida = false

onready var time = get_node("VBoxContainer/time_label")
onready var pause = $Popup_Menu # Popup do menu

func _ready():
	$VBoxContainer.hide()
	$VideoPlayer.play()
	$Timer2_Aceito.one_shot = true
	pause.hide()

func _process(_delta):
	var datetime = Time.get_time_dict_from_system()

	var meridiem = "AM"
	var hour = datetime["hour"]

	if hour > 12:
		meridiem = " PM"
		hour -= 12

	var minute = "%02d" % datetime["minute"]

	var time_str = str(hour) + ":" + str(minute) + meridiem
	time.text = time_str
	
	_abrir_pause()

func _abrir_pause():
	if Input.is_action_pressed("ui_cancel"):  # Verifica a tecla "Esc"
		$Popup_Menu.show()

func _on_VideoPlayer_finished():
	$VideoPlayer.hide()
	$VideoPlayer2.play()

func _on_VideoPlayer2_finished():
	$VideoPlayer2.hide()
	$VBoxContainer.show()
	
func _on_msn_botao_pressed():
	var click = $mouse_click
	click.play()
	$Popup.show_modal()
	
func _on_mouse_click_finished():
	$mouse_click.stop()

func _on_Entrar_pressed():
	var click = $mouse_click
	$Popup.hide()
	$Popup2.show_modal()
	click.play()
	
func _on_Enviar_pressed():
	var click_ok = $mouse_click
	var click_off = $Xp_error
	var texto_digitado = $Popup2/LineEdit.text
	var time = $Timer2_Aceito
	
	if texto_digitado == "D3F4ULT":
		click_ok.play()
		time.start()
	else:
		click_off.play()
		$Popup2/LineEdit.text = ""
	
#AMIZADE ACEITA
func _on_Timer2_Aceito_timeout():
	$notificacao.play()
	$Popup3.show_modal()

func _on_Popup3_about_to_show():
	$Timer2_Aceito.stop()


func _on_IniciarConversa_pressed():
	get_tree().change_scene("res://Cena2_CHAT.tscn")


func _on_Menu_pressed():
	$Popup_Menu.hide()

func _on_Menu2_pressed():
	get_tree().change_scene("res://Menu.tscn")
