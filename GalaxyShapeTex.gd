extends TextureRect


func _ready():
    texture = global.galaxy_shape_textures[global.GS_DISC]


func _on_OptionButton_item_selected(index):
    texture = global.galaxy_shape_textures[index]
