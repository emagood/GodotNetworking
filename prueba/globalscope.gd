extends Node



func _ready() -> void:
	#is_nan  / is_instance_valid  /is_instance_id_valid //Devuelve si es un valor NaN ("No es un número" o no válido).truex
	pass      
	
	## usar para todo 

func test():
	pass

func test_str_to_var():
	
	
	var data = '{ "a": 1, "b": 2 }' # data is a String
	var dict = str_to_var(data)     # dict is a Dictionary
	print(dict["a"])  # Prints 1
	
	##################################
	
	var a = { "a": 1, "b": 2 }
	print(var_to_str(a)) ## {"a": 1,"b": 2}
	
	

	

func test_tan_sqrt():
	
	tan(deg_to_rad(45)) # Returns 1
	
	#############
	
	var a = log(2.0) # Returns 0.693147
	tanh(a)          # Returns 0.6
	#########################
	
	sqrt(9)     # Returns 3
	sqrt(10.24) # Returns 3.2
	sqrt(-1)    # Returns NaN
	
	pass
	
func test_typeof():
	var json = JSON.new()
	json.parse('["a", "b", "c"]')
	var result = json.get_data()
	if typeof(result) == TYPE_ARRAY:
		print(result[0]) # Prints a
	else:
		print("Unexpected result")
	pass
	
func test_rand():
	
	var a = rand_from_seed(4)
	print(a[0]) # Prints 2879024997
	print(a[1]) # Prints 4
	###################################################33
	prints(randf()) # Returns e.g. 0.375671
	
	####################################################
	randi()           # Returns random integer between 0 and 2^32 - 1
	randi() % 20      # Returns random integer between 0 and 19
	randi() % 100     # Returns random integer between 0 and 99
	randi() % 100 + 1 # Returns random integer between 1 and 100
	###############################################################
	randi_range(0, 1)      # Returns either 0 or 1
	randi_range(-10, 1000) # Returns random integer between -10 and 1000
	## randomize()
	####################################################################33
	var my_seed = "Godot Rocks".hash()
	seed(my_seed)
	a = randf() + randi()
	seed(my_seed)
	var b = randf() + randi()
# a and b are now identical
	
	pass

#
#func test():
	#pass
#
#func test():
	#pass
#
	#
