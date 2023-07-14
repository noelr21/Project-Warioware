extends Area2D

# Variables to specifiy how to move in the node structure to find a specific node which goes by nodeName
@export var parentDirectories: int = 1;
@export var nodeName: String = "Stats";

var damage;

func _ready():
	if (nodeName != null || nodeName != "") && parentDirectories >= 0:
		var ancestors = "";
		for i in parentDirectories:
			ancestors += "../"
		damage = get_node(ancestors+nodeName).damage
