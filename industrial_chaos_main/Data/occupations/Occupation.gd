extends Resource
class_name Occupation

export(int) var starting_strength = 0
export(int) var starting_perception = 0
export(int) var starting_toughness = 0
export(String) var occupation_name = "no_name"
export(String, MULTILINE) var occupation_description = "no description"
# export(Resource) var starting_oddity/special_condition # this will be used to spawn players with special perms like
# knowledge(passcodes) or afflictions
