extends Node2D


const SCALE_1_AT = 50.0
const NAME_FONT_SIZE = 4


var font_robo = preload("res://resources/fonts/Roboto-Regular.tres")
var fonts = {}


# Called when the node enters the scene tree for the first time.
func _ready():
    for ss in global.galaxy.systems.values():
        fonts[ss.id] = font_robo.duplicate()


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
        if dec_scale < 1:
            continue
        
        var pos_2d = cam.unproject_position(ss.pos)
        var font: Font = fonts[ss.id]
        font.size = NAME_FONT_SIZE * dec_scale
        var off_x = -len(ss.name)
        draw_string(font, pos_2d + (Vector2(off_x, 7) * dec_scale), ss.name)
