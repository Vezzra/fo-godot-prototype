tool


extends FOWindow


signal ok
signal cancel


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _on_CloseWidget_pressed():
    emit_signal("cancel")


func _on_OKBtn_pressed():
    global.gs_seed = $ToplevelContainer/LeftContainer/Seed/LineEdit.text
    global.gs_map_size = $ToplevelContainer/LeftContainer/Systems/SpinBox.value
    emit_signal("ok")


func _on_CancelBtn_pressed():
    emit_signal("cancel")
