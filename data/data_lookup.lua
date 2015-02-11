
local lookup = {}
-- data lookups


-- Creates an entity of type destructible object on the map.

-- properties (table): A table that describes all properties of the entity to create. Its key-value pairs must be:
-- name (string, optional): Name identifying the entity or nil. If the name is already used by another entity, a suffix (of the form "_2", "_3", etc.) will be automatically appended to keep entity names unique.
-- layer (number): Layer on the map (0: low, 1: intermediate, 2: high).
-- x (number): X coordinate on the map.
-- y (number): Y coordinate on the map.
-- treasure_name (string, optional): Kind of pickable treasure to hide in the destructible object (the name of an equipment item). If this value is not set, then no treasure is placed in the destructible object. If the treasure is not obtainable when the object is destroyed, no pickable treasure is created.
-- treasure_variant (number, optional): Variant of the treasure if any (because some equipment items may have several variants). The default value is 1 (the first variant).
-- treasure_savegame_variable (string, optional): Name of the boolean value that stores in the savegame whether the pickable treasure hidden in the destructible object was found. No value means that the treasure (if any) is not saved. If the treasure is saved and the player already has it, then no treasure is put in the destructible object.
-- sprite (string): Name of the animation set of a sprite to create for the destructible object.
-- destruction_sound (string, optional): Sound to play when the destructible object is cut or broken after being thrown. No value means no sound.
-- weight (number, optional): Level of "lift" ability required to lift the object. 0 allows the player to lift the object unconditionally. The special value -1 means that the object can never be lifted. The default value is 0.
-- can_be_cut (boolean, optional): Whether the hero can cut the object with the sword. No value means false.
-- can_explode (boolean, optional): Whether the object should explode when it is cut, hit by a weapon and after a delay when the hero lifts it. The default value is false.
-- can_regenerate (boolean, optional): Whether the object should automatically regenerate after a delay when it is destroyed. The default value is false.
-- damage_on_enemies (number, optional): Number of life points to remove from an enemy that gets hit by this object after the hero throws it. If the value is 0, enemies will ignore the object. The default value is 1.
-- ground (string, optional): Ground defined by this entity. The ground is usually "wall", but you may set "traversable" to make the object traversable, or for example "grass" to make it traversable too but with an additional grass sprite below the hero. The default value is "wall".
-- Return value (destructible object): The destructible object created.

lookup.equipment = {
	["sword__1"]={requires=nil},
	["sword__2"]={requires="sword__1"},
	["sword__3"]={requires="sword__2"},
	["glove__1"]={requires=nil},
	["glove__2"]={requires="glove__1"},
	["bomb_bag__1"]={requires=nil},
	["bomb_bag__2"]={requires="bomb_bag__1"},
	["bomb_bag__3"]={requires="bomb_bag__2"}
}

lookup.destructible = {
	["bush"]=		{layer = 0, treasure_name = "random", sprite = "entities/bush", destruction_sound = "bush", weight = 1, can_be_cut = true, required_size={x=16, y=16}, offset={x=8, y=13}},
	["white_rock"]=	{layer = 0, treasure_name = "random", sprite = "entities/stone_small_white", destruction_sound = "stone", weight = 1,  damage_on_enemies = 2, required_size={x=16, y=16}, offset={x=8, y=13}},
	["black_rock"]= {layer = 0, treasure_name = "random", sprite = "entities/stone_small_black", destruction_sound = "stone", weight = 2,  damage_on_enemies = 4, required_size={x=16, y=16}, offset={x=8, y=13}},
	["pot"]=		{layer = 0, treasure_name = "random", sprite = "entities/pot",  destruction_sound = "stone",  damage_on_enemies = 2, required_size={x=16, y=16}, offset={x=8, y=13}}, -- treasure undecided
}

lookup.doors = {
	["door_weak_block"]={ layer = 0, direction = 1, sprite = "entities/door_weak_block", opening_method = "explosion"},
	["door_normal"]={ layer = 0, direction = 1, sprite = "entities/door_normal"},
	["door_small_key"]={ layer = 0, direction = 1, sprite = "entities/door_small_key", opening_method = "interaction_if_savegame_variable", 
						 opening_condition = "small_key", opening_condition_consumed = true, cannot_open_dialog = "_small_key_required"},
	["door_boss_key"]= { layer = 0, direction = 1, sprite = "entities/door_boss_key",
						 opening_method = "interaction_if_savegame_variable", opening_condition = "dungeon_1_boss_key", cannot_open_dialog = "_boss_key_required"},
}

-- use the same as prop lookup
lookup.transitions = 
{
	["cave_stairs_1"] = 		{required_size={x=32, y=48},
								 [{x1=0, y1=0, x2=8, y2=2*16}]={[1]=865}, 
								 [{x1=8, y1=0, x2=8+16, y2=8}]={[1]=867},
								 [{x1=8+16, y1=0, x2=2*16, y2=2*16}]={[1]=866},
								 [{x1=8, y1=8, x2=8+16, y2=2*16}]={[1]=868}
								 },

	["edge_stairs_1"] = 	    {required_size={x=48, y=24},
								  [{x1=16, y1=-8, x2=32, y2=0, layer=0}]={[4]=70},
								  [{x1=16, y1=0, x2=32, y2=8, layer=0}]={[4]=328}, 
								  [{x1=8, y1=0, x2=40, y2=8, layer=1}]={[4]=152}, 
								  [{x1=8, y1=8, x2=16, y2=24, layer=0}]={[4]=72},
								  [{x1=16, y1=8, x2=32, y2=24, layer=0}]={[4]=192},
								  [{x1=32, y1=8, x2=40, y2=24, layer=0}]={[4]=73}},
	["edge_stairs_3"] = 		{required_size={x=48, y=24},
								  [{x1=8, y1=24, x2=32, y2=32, layer=0}]={[4]=70}, 
								  [{x1=8, y1=16, x2=32, y2=24, layer=0}]={[4]=328}, 
							      [{x1=8, y1=0, x2=16, y2=16, layer=0}]={[4]=74}, 
								  [{x1=16, y1=0, x2=32, y2=16, layer=0}]={[4]=196},
								  [{x1=32, y1=0, x2=40, y2=16, layer=0}]={[4]=75},
								  [{x1=8, y1=16, x2=40, y2=24, layer=1}]={[4]=153}},
	 ["edge_stairs_2"] = 	    {required_size={x=64, y=24},
								 [{x1=0, y1=0, x2=24, y2=24, layer=0}]={[4]=49}, 
								 [{x1=40, y1=0, x2=64, y2=24, layer=0}]={[4]=49}, 
								 [{x1=0, y1=0, x2=32, y2=8, layer=1}]={[4]=152}, 
								 [{x1=0, y1=8, x2=8, y2=24, layer=0}]={[4]=72},
								 [{x1=8, y1=8, x2=24, y2=24, layer=0}]={[4]=192},
								 [{x1=24, y1=8, x2=32, y2=24, layer=0}]={[4]=73}},
	["edge_stairs_0"] = 		{required_size={x=64, y=24},
								 [{x1=0, y1=0, x2=24, y2=24, layer=0}]={[4]=52}, 
								 [{x1=40, y1=0, x2=64, y2=24, layer=0}]={[4]=52}, 
							     [{x1=0, y1=0, x2=8, y2=16, layer=0}]={[4]=74}, 
								 [{x1=8, y1=0, x2=8+16, y2=16, layer=0}]={[4]=196},
								 [{x1=8+16, y1=0, x2=2*16, y2=16, layer=0}]={[4]=75},
								 [{x1=0, y1=16, x2=32, y2=24, layer=1}]={[4]=153}},
	["edge_doors_1"] = 	    {required_size={x=24, y=48},
							  [{x1=8, y1=16, x2=24, y2=32, layer=0}]={[4]=328},
							  [{x1=0, y1=24, x2=32, y2=32, layer=1}]={[4]=152}, 
							  [{x1=0, y1=32, x2=8, y2=48, layer=0}]={[4]=72},
							  [{x1=8, y1=32, x2=24, y2=48, layer=0}]={[4]=76},
							  [{x1=24, y1=32, x2=32, y2=48, layer=0}]={[4]=73},
							  [{x1=0, y1=0, x2=8, y2=16, layer=0}]={[4]=74}, 
							  [{x1=8, y1=0, x2=24, y2=16, layer=0}]={[4]=77},
							  [{x1=24, y1=0, x2=32, y2=16, layer=0}]={[4]=75},
							  [{x1=0, y1=16, x2=32, y2=24, layer=1}]={[4]=153}},
	["edge_doors_0"] = 	    {required_size={x=48, y=24},
							  [{x1=0, y1=0, x2=16, y2=8, layer=0}]={[4]=79},
							  [{x1=0, y1=8, x2=16, y2=24, layer=0}]={[4]=83},
							  [{x1=0, y1=24, x2=16, y2=32, layer=0}]={[4]=81},
							  [{x1=16, y1=0, x2=24, y2=32, layer=1}]={[4]=165},
							  [{x1=24, y1=0, x2=32, y2=32, layer=1}]={[4]=164},
							  [{x1=32, y1=0, x2=48, y2=8, layer=0}]={[4]=78},
							  [{x1=32, y1=8, x2=48, y2=24, layer=0}]={[4]=82},
							  [{x1=32, y1=24, x2=48, y2=32, layer=0}]={[4]=80},
							  [{x1=16, y1=8, x2=32, y2=24, layer=0}]={[4]=328},
							  }						 
}

lookup.tiles =
{
	["maze_wall_hor"]={[1]=1016, [4]=70},
	["maze_wall_ver"]={[1]=1016, [4]=71},
	["maze_post"]={[1]=1016, [4]=69},
	["dungeon_floor"]={[4]=328},
	["dungeon_spacer"]={[4]=170},
	["pot_stand"]={[4]=101},
	["debug_corner"]={[1]=63, [4]=327}
}

lookup.wall_tiling =
{
	["dungeon"]={["wall"]={["n"]=49, ["e"]=50, ["w"]=51, ["s"]=52},
				 ["wall_inward_corner"]={["nw"]=45, ["ne"]=46, ["sw"]=47, ["se"]=48},
				 ["wall_outward_corner"]={["nw"]=53, ["ne"]=54, ["sw"]=55, ["se"]=56},
				 ["floor_edge"]={["n"]=179, ["e"]=238, ["w"]=237, ["s"]=236},
				 ["floor_edge_inward_corner"]={["nw"]=14, ["ne"]=15, ["sw"]=16, ["se"]=17},
				 ["floor_edge_outward_corner"]={["nw"]=239, ["ne"]=240, ["sw"]=241, ["se"]=242}
				}
}

lookup.props = 
{
	["green_tree"]= { required_size={x=64, y=64},
					 [{x1=0, y1=-8, x2=8, y2=4*8, layer=2}]=513, -- left canopy
					 [{x1=8, y1=-16, x2=7*8, y2=0, layer=2}]=512, -- top canopy
					 [{x1=8, y1=0, x2=7*8, y2=5*8, layer=2}]=511, -- middle canopy
					 [{x1=7*8, y1=-8, x2=8*8, y2=4*8, layer=2}]=514, -- right canopy
					 [{x1=0, y1=4*8, x2=8, y2=6*8, layer=0}]=503, --left trunk
					 [{x1=7*8, y1=4*8, x2=8*8, y2=6*8, layer=0}]=504, -- right trunk
					 [{x1=8, y1=5*8, x2=7*8, y2=7*8, layer=0}]=505, -- middle trunk
					 [{x1=16, y1=7*8, x2=6*8, y2=8*8, layer=0}]=523, -- bottom trunk
					 [{x1=8, y1=0, x2=7*8, y2=5*8, layer=0}]=502}, -- wall
	["small_green_tree"]={[{x1=0, y1=0, x2=32, y2=32, layer=0}]=526, required_size={x=32, y=32}},
	["small_lightgreen_tree"]={[{x1=0, y1=0, x2=32, y2=32, layer=0}]=527, required_size={x=32, y=32}},
	["tree_stump"]={[{x1=0, y1=0, x2=32, y2=32, layer=0}]=630, required_size={x=32, y=32}},
	["flower1"]={[{x1=0, y1=0, x2=16, y2=16, layer=0}]=42, required_size={x=16, y=16}},
	["flower2"]={[{x1=0, y1=0, x2=16, y2=16, layer=0}]=43, required_size={x=16, y=16}},
	["halfgrass"]={[{x1=0, y1=0, x2=16, y2=16, layer=0}]=36, required_size={x=16, y=16}},
	["fullgrass"]={[{x1=0, y1=0, x2=16, y2=16, layer=0}]=37, required_size={x=16, y=16}},
	["hole"] = {[{x1=0, y1=0, x2=16, y2=16, layer=0}]=825, required_size={x=16, y=16}},
	["impassable_rock_16x16"] = { 	[{x1=0, y1=0, x2=8, y2=8, layer=0}]=288, 
									[{x1=8, y1=0, x2=16, y2=8, layer=0}]=287, 
									[{x1=0, y1=8, x2=8, y2=16, layer=0}]=286, 
									[{x1=8, y1=8, x2=16, y2=16, layer=0}]=285, 
									required_size={x=16, y=16}},
	["impassable_rock_32x16"] = { 	[{x1=0, y1=0, x2=8, y2=8, layer=0}]=284, 
									[{x1=24, y1=0, x2=32, y2=8, layer=0}]=283, 
									[{x1=0, y1=8, x2=8, y2=16, layer=0}]=282, 
									[{x1=24, y1=8, x2=32, y2=16, layer=0}]=281,
									[{x1=8, y1=0, x2=24, y2=8, layer=0}]=265, 
									[{x1=8, y1=8, x2=24, y2=16, layer=0}]=266,
									required_size={x=32, y=16}},
	["impassable_rock_16x32"] = { 	[{x1=0, y1=0, x2=8, y2=8, layer=0}]=288, 
									[{x1=8, y1=0, x2=16, y2=8, layer=0}]=287, 
									[{x1=0, y1=24, x2=8, y2=32, layer=0}]=286, 
									[{x1=8, y1=24, x2=16, y2=32, layer=0}]=285,
									[{x1=0, y1=8, x2=8, y2=24, layer=0}]=273, 
									[{x1=8, y1=8, x2=16, y2=24, layer=0}]=274,
									required_size={x=16, y=32}},
}

return lookup