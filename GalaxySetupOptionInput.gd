extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("Low", global.GO_LOW)
	add_item("Medium", global.GO_MEDIUM)
	add_item("High", global.GO_HIGH)
	add_item("Random", global.GO_RANDOM)
	select(global.GO_MEDIUM)
