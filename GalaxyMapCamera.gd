extends Camera


const ANGLE_V_LIMIT: float = 0.05
const PANNING_SPEED: float = 0.02
const ZOOM_SPEED: float = 0.05


var angle_h: float = 0.0
var angle_v: float = 0.5
var dist: float = 50.0

var panning = false


func _ready():
    update_position()


func _input(event):
    if event is InputEventMouseButton:
        match event.button_index:
            BUTTON_MIDDLE:
                panning = event.pressed
            BUTTON_WHEEL_UP:
                dist -= dist * ZOOM_SPEED
                update_position()
            BUTTON_WHEEL_DOWN:
                dist += dist * ZOOM_SPEED
                update_position()
    
    elif panning and (event is InputEventMouseMotion):
        var mouse_movement = event.relative
        angle_h += mouse_movement.x * PANNING_SPEED
        angle_v += mouse_movement.y * PANNING_SPEED
        update_position()


func update_position():
    if angle_h < 0:
        angle_h += 2 * PI
    elif angle_h > 2 * PI:
        angle_h -= 2 * PI
    angle_v = clamp(angle_v, ANGLE_V_LIMIT, PI / 2 - ANGLE_V_LIMIT)
    dist = clamp(dist, 10, 1000)

    var f = cos(angle_v)
    var x = dist * cos(angle_h) * f
    var y = dist * sin(angle_v)
    var z = dist * sin(angle_h) * f
    look_at_from_position(Vector3(x, y, z), Vector3(0, 0, 0), Vector3(0, 1, 0))
