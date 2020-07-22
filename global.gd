extends Node


const LETTER_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
const LETTER_LOWER = "abcdefghijklmnopqrstuvwxyz"
const LETTER_DIGITS = "1234567890"

const GO_NONE = 0
const GO_LOW = 1
const GO_MEDIUM = 2
const GO_HIGH = 3
const GO_RANDOM = 4

const GS_SPIRAL2 = 0
const GS_SPIRAL3 = 1
const GS_SPIRAL4 = 2
const GS_CLUSTER = 3
const GS_ELLIPTICAL = 4
const GS_DISC = 5
const GS_BOX = 6
const GS_IRREGULAR = 7
const GS_RING = 8
const GS_RANDOM = 9

const GA_YOUNG = 0
const GA_MATURE = 1
const GA_ANCIENT = 2
const GA_RANDOM = 3

const AIA_BEGINNER = 0
const AIA_TURTLE = 1
const AIA_CAUTIOUS = 2
const AIA_TYPICAL = 3
const AIA_AGGRESSIVE = 4
const AIA_MANIACAL = 5

const SP_HUMAN = 0
const SP_LAENFA = 1
const SP_SCYLIOR = 2
const SP_EGASSEM = 3
const SP_TRITH = 4

const MIN_SYS_DIST = 2


var gs_files = {
    GS_SPIRAL2: "res://assets/image/gp_spiral2.png",
    GS_SPIRAL3: "res://assets/image/gp_spiral3.png",
    GS_SPIRAL4: "res://assets/image/gp_spiral4.png",
    GS_CLUSTER: "res://assets/image/gp_cluster.png",
    GS_ELLIPTICAL: "res://assets/image/gp_elliptical.png",
    GS_DISC: "res://assets/image/gp_disc.png",
    GS_BOX: "res://assets/image/gp_box.png",
    GS_IRREGULAR: "res://assets/image/gp_irregular.png",
    GS_RING: "res://assets/image/gp_ring.png",
    GS_RANDOM: "res://assets/image/gp_random.png"
}
var galaxy_shape_textures = {}

var sp_files = {
    SP_HUMAN: "res://assets/image/species/human.png",
    SP_LAENFA: "res://assets/image/species/laenfa.png",
    SP_SCYLIOR: "res://assets/image/species/scylior.png",
    SP_EGASSEM: "res://assets/image/species/egassem.png",
    SP_TRITH: "res://assets/image/species/trith.png"
   }
var species_textures = {}


# Called when the node enters the scene tree for the first time.
func _ready():
    for gs_shape in gs_files.keys():
        var gs_tex: ImageTexture = ImageTexture.new()
        gs_tex.load(gs_files[gs_shape])
        galaxy_shape_textures[gs_shape] = gs_tex

    for species in sp_files.keys():
        var sp_tex: ImageTexture = ImageTexture.new()
        sp_tex.load(sp_files[species])
        species_textures[species] = sp_tex


func galaxy_calc_positions(size, radius):
    # Calculate positions for the disc galaxy shape.
    var positions = []
    
    for _i in range(size):
        var attempts: int = 100
        var too_close = false
        var new_pos: Vector2
        
        while attempts:
            attempts -= 1
            var dist = rand_range(0.0, radius)
            var angle = rand_range(0.0, 6.2831853072)
            new_pos = Vector2(dist * cos(angle), dist * sin(angle))
            
            too_close = false
            for pos in positions:
                if new_pos.distance_to(pos) < MIN_SYS_DIST:
                    too_close = true
                    break
            
            if not too_close:
                break

        if not too_close:
            positions.append(new_pos)

    return positions
