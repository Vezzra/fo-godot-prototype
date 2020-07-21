extends Control


var game_setup_dlg: Control


# Called when the node enters the scene tree for the first time.
func _ready():
    game_setup_dlg = preload("res://GameSetup.tscn").instance()
    $Popup.add_child(game_setup_dlg)
    game_setup_dlg.connect("ok", self, "_on_GameSetupDlg_ok")
    game_setup_dlg.connect("cancel", self, "_on_GameSetupDlg_cancel")


func _on_QuitBtn_pressed():
    get_tree().quit()


func _on_SinglePlayerBtn_pressed():
    var pos_x = ($Popup.get_rect().size.x - game_setup_dlg.get_rect().size.x) / 2
    var pos_y = ($Popup.get_rect().size.y - game_setup_dlg.get_rect().size.y) / 2
    game_setup_dlg.set_position(Vector2(pos_x, pos_y))
    $Popup.popup()


func _on_GameSetupDlg_ok():
    $Popup.hide()


func _on_GameSetupDlg_cancel():
    $Popup.hide()
