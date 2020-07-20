extends Node


const LETTER_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
const LETTER_LOWER = "abcdefghijklmnopqrstuvwxyz"
const LETTER_DIGITS = "1234567890"

const GO_LOW = 0
const GO_MEDIUM = 1
const GO_HIGH = 2
const GO_RANDOM = 3

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


# Called when the node enters the scene tree for the first time.
func _ready():
	for gs_shape in gs_files.keys():
		var gs_tex: ImageTexture = ImageTexture.new()
		gs_tex.load(gs_files[gs_shape])
		galaxy_shape_textures[gs_shape] = gs_tex
