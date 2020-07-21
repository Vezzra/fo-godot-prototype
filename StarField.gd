extends Spatial


var panning = false
var panning_speed = 0.01


# Called when the node enters the scene tree for the first time.
func _ready():
    var star_scene = preload("res://Star.tscn")
    var positions = global.galaxy_calc_positions(100, 50)
    for pos in positions:
        var star = star_scene.instance()
        star.translate(Vector3(pos.x, 0, pos.y))
        add_child(star)


func _input(event):
    if event is InputEventMouseButton:
        print(event.factor)
        if event.button_index == BUTTON_MIDDLE:
            panning = event.pressed
    elif panning and (event is InputEventMouseMotion):
        var delta = event.relative
        rotate(Vector3(0, 0, 1), -delta.y * panning_speed)
        rotate(Vector3(0, 1, 0), -delta.x * panning_speed)
