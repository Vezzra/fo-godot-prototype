tool


class_name FOWindow


extends NinePatchRect


export var Title: String = "Window Title" setget set_title

enum {NONE, RESIZE, DRAG, PINNED}
var state = NONE
var mouse_pos_offset: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _input(event):
    if event is InputEventMouseButton:
        if event.button_index != BUTTON_LEFT:
            return

        match state:
            NONE:
                if event.pressed:
                    var mouse_pos = get_global_mouse_position()
                    if $Title.get_global_rect().has_point(mouse_pos):
                        mouse_pos_offset = mouse_pos - get_global_rect().position
                        state = DRAG
                    elif $ResizeWidget.get_global_rect().has_point(mouse_pos):
                        mouse_pos_offset = mouse_pos - get_global_rect().end
                        state = RESIZE

            DRAG, RESIZE:
                if not event.pressed:
                    state = NONE

    elif event is InputEventMouseMotion:
        match state:
            DRAG:
                set_position(get_global_mouse_position() - mouse_pos_offset)
            
            RESIZE:
                set_size(get_global_mouse_position() - mouse_pos_offset - get_global_rect().position)


func set_title(new_title):
    Title = new_title
    $Title.text = Title


func _on_PinWidget_toggled(button_pressed):
    if button_pressed:
        state = PINNED
    else:
        state = NONE
