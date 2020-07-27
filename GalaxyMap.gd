extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
    for ss in global.galaxy.systems.values():
        ss.spatial.connect("input_event", $StarField, "_on_Star_input_event")
        ss.spatial.connect("input_event", $Starnames, "_on_Star_input_event")
