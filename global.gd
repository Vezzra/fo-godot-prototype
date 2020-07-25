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

const MIN_SYS_DIST = 1
const MAX_STARLANE_LENGTH = 15


var gs_seed: String = "0"
var gs_map_size: int = 500

var galaxy: Galaxy

var starnames: Array


class Starlane:
    var source: int
    var dest: int
    
    func _init(a_source, a_dest):
        source = a_source
        dest = a_dest
        if not valid():
            print("WARNING: Created starlane where source and destination system are the same")
    
    func valid():
        return (source != dest)


class StarSystem:
    var id: int
    var pos: Vector3
    var name: String
    var starlanes: Array
    
    func _init(a_id: int, a_pos: Vector3):
        id = a_id
        pos = a_pos
        name = global.starnames.pop_front()
        starlanes = []
    
    func add_starlane(starlane: Starlane):
        if not starlane.valid():
            print("ERROR: Attemting to add invalid starlane")
            return
        
        var already_linked_sys = get_linked_systems()
        if (starlane.source in already_linked_sys) or (starlane.dest in already_linked_sys):
            return
            
        if (starlane.source == id) or (starlane.dest == id):
            starlanes.append(starlane)
        else:
            print("ERROR: Attempting to add starlane to system that does not start or end there")
    
    func get_linked_systems():
        var linked_sys = []
        for starlane in starlanes:
            if starlane.source == id:
                linked_sys.append(starlane.dest)
            elif starlane.dest == id:
                linked_sys.append(starlane.source)
        return linked_sys
    

class Galaxy extends AStar:
    var systems = {}
    var starlanes = []
    
    func add_system(sys: StarSystem):
        systems[sys.id] = sys
        add_point(sys.id, sys.pos)
    
    func add_starlane(starlane: Starlane):
        if not ((starlane.source in systems.keys()) and (starlane.dest in systems.keys())):
            print("ERROR: Attempting to add starlane to non-existing systems")
            return
        
        var ssys: StarSystem = systems[starlane.source]
        var ssys_linked_sys = ssys.get_linked_systems()
        var dsys: StarSystem = systems[starlane.dest]
        var dsys_linked_sys = dsys.get_linked_systems()
        
        if (ssys.id in dsys_linked_sys) and (not dsys.id in ssys_linked_sys) or (dsys.id in ssys_linked_sys) and (not ssys.id in dsys_linked_sys):
            print("ERROR: Found corrupted starlane lists when attempting to add starlane to system")
            return
        
        ssys.add_starlane(starlane)
        dsys.add_starlane(starlane)
        starlanes.append(starlane)
        connect_points(starlane.source, starlane.dest)
    
    func get_all_sys_connected_to(sys_id, connected_sys_list: Array = []):
        if sys_id in connected_sys_list:
            return
        
        connected_sys_list.append(sys_id)
        var this_sys: StarSystem = systems[sys_id]
        
        for ssid in this_sys.get_linked_systems():
            if ssid in connected_sys_list:
                continue
            get_all_sys_connected_to(ssid, connected_sys_list)
        
        return connected_sys_list
    
    func get_islands():
        var islands = []
        var already_assigned_sys = []
        for ssid in systems.keys():
            if ssid in already_assigned_sys:
                continue
            var island = get_all_sys_connected_to(ssid)
            islands.append(island)
            already_assigned_sys += island
        return islands

    func calc_positions(size, radius):
        # Calculate positions for the disc galaxy shape.
        for i in range(size):
            var attempts: int = 100
            var too_close = false
            var new_pos: Vector3
            
            while attempts:
                attempts -= 1
                var dist = rand_range(0.0, radius)
                var angle = rand_range(0.0, 6.2831853072)
                new_pos = Vector3(dist * cos(angle), 0, dist * sin(angle))
                
                var nearest_neighbor = get_closest_point(new_pos)
                if nearest_neighbor < 0:
                    too_close = false
                    break
                elif new_pos.distance_to(get_point_position(nearest_neighbor)) < MIN_SYS_DIST:
                    too_close = true
                else:
                    too_close = false
                    break
                
            if not too_close:
                add_system(StarSystem.new(i, new_pos))
    
    func generate_starlanes():
        for ss in systems.values():
            set_point_disabled(ss.id, true)
            var dest = get_closest_point(ss.pos, false)
            set_point_disabled(ss.id, false)
            if (dest >= 0) and (not dest in ss.get_linked_systems()):
                add_starlane(Starlane.new(ss.id, dest))
        
        var islands = get_islands()
        var last_amount_of_islands: int = 0
        while len(islands) != last_amount_of_islands:
            for island in islands:
                for ssid in island:
                    set_point_disabled(ssid, true)
                
                var dist_map = {}
                var dist_list = []
                for ssid in island:
                    var ss: StarSystem = systems[ssid]
                    var closest_island = get_closest_point(ss.pos)
                    if closest_island >= 0:
                        var dist = ss.pos.distance_to(get_point_position(closest_island))
                        if dist in dist_map.keys():
                            dist_map[dist].append(ss)
                        else:
                            dist_map[dist] = [ss]
                        dist_list.append(dist)
                
                if dist_list:
                    dist_list.sort()
                    for ss in dist_map[dist_list[0]]:
                        add_starlane(Starlane.new(ss.id, get_closest_point(ss.pos)))

                for ssid in island:
                    set_point_disabled(ssid, false)
            
            last_amount_of_islands = len(islands)
            islands = get_islands()
        
        for ss in systems.values():
            var linked_sys = ss.get_linked_systems()
            if len(linked_sys) == 1:
                set_point_disabled(ss.id, true)
                set_point_disabled(linked_sys[0], true)
                var closest_neighbor = get_closest_point(ss.pos)
                add_starlane(Starlane.new(ss.id, closest_neighbor))
                set_point_disabled(ss.id, false)
                set_point_disabled(linked_sys[0], false)


func _ready():
    var name_file: File = File.new()
    starnames = []
    
    name_file.open("res://assets/text/starnames.txt", File.READ)
    while not name_file.eof_reached():
        var starname = name_file.get_line()
        if starname:
            starnames.append(starname)
    
    starnames.shuffle()
