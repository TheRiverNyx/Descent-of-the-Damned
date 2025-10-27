@tool
class_name PlatformerPathGraph extends Node2D

@export var tilemap_layer: TileMapLayer
@export var show_debug: bool = true
@export var max_jump_height:int = 3 #tiles
@export var max_jump_distance:int = 3 #tiles
@onready var graph = AStar2D.new()
@export_tool_button("Generate") var generate_nodes_action = generate_nodes
@onready var cell_size = Vector2(tilemap_layer.get_tile_set().tile_size)

class NavNode extends Object:
    var id: int
    var position:Vector2
    var action: String = "walk"
    var neighbors : Dictionary = {} #id:cost
var nodes: Dictionary = {}
var next_id :int = 0

func _ready() -> void:
    if Engine.is_editor_hint():
        generate_nodes()
    else:
        generate_nodes()

func generate_nodes():
    var cells = tilemap_layer.get_used_cells()
    
    for cell in cells:
        var above = Vector2i(cell[0],cell[1] - 1)
        
        if !(above in cells):
            var node = NavNode.new()
            node.position = tilemap_layer.to_global(tilemap_layer.map_to_local(above)) + cell_size / 2
