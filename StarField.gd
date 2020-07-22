extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
    var star_scene = preload("res://Star.tscn")
    var positions = global.galaxy_calc_positions(100, 50)
    for pos in positions:
        var star = star_scene.instance()
        star.translate(Vector3(pos.x, 0, pos.y))
        add_child(star)
