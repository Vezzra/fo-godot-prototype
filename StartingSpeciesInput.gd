extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
    add_icon_item(global.species_textures[global.SP_EGASSEM], "Egassem", global.SP_EGASSEM)
    add_icon_item(global.species_textures[global.SP_HUMAN], "Human", global.SP_HUMAN)
    add_icon_item(global.species_textures[global.SP_LAENFA], "Laenfa", global.SP_LAENFA)
    add_icon_item(global.species_textures[global.SP_SCYLIOR], "Scylior", global.SP_SCYLIOR)
    add_icon_item(global.species_textures[global.SP_TRITH], "Trith", global.SP_TRITH)
    select(get_item_index(global.SP_HUMAN))
