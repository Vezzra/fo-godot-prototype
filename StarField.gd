extends Spatial


var ig = ImmediateGeometry.new()
var galaxy = global.Galaxy.new()


func add_pos_as_vertex(st: SurfaceTool, pos):
    st.add_uv(Vector2(pos.x, pos.y))
    st.add_vertex(pos)


# Called when the node enters the scene tree for the first time.
func _ready():
    global.starfield = self
    var star_scene = preload("res://Star.tscn")
    
    rand_seed(hash(global.gs_seed))
    var width = 2.0 * sqrt(global.gs_map_size)
    galaxy.calc_positions(global.gs_map_size, width)
    galaxy.generate_starlanes()
    global.galaxy = galaxy
    
    for ss in galaxy.systems.values():
        var star = star_scene.instance()
        ss.spatial = star
        star.translate(ss.pos)
        add_child(star)
    
    ig.material_override = load("res://resources/materials/starlane_material.tres")
    add_child(ig)


func _process(delta):
    ig.clear()
    ig.begin(Mesh.PRIMITIVE_LINES)
    ig.set_color(Color(1, 1, 1))
    for starlane in galaxy.starlanes:
        ig.add_vertex(galaxy.get_point_position(starlane.source))
        ig.add_vertex(galaxy.get_point_position(starlane.dest))
    ig.end()
