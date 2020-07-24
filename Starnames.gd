extends Node2D


const SCALE_1_AT = 50.0


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    update()


func _draw():
    var cam = get_viewport().get_camera()
    var cpos = cam.translation

    for ss in global.galaxy.systems.values():
        if cam.is_position_behind(ss.pos):
            continue
        
        var dec_scale = SCALE_1_AT / (cpos.distance_to(ss.pos))
        if dec_scale < 0.5:
            continue
        
        var pos_2d = cam.unproject_position(ss.pos)
        draw_rect(Rect2(pos_2d + (Vector2(0, -5) * dec_scale), Vector2(6, 3) * dec_scale), Color(0.7, 0.7, 1), true)
