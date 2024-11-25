extends Node2D

var network_clients: Array = []
var network_server: NetworkServer
var address = "127.0.0.1"
var port = 1454
	
func _ready():
	pass

func start_network_server(address: String, port: int):
	network_server = NetworkServer.new(address, port)
	network_server.client_connected.connect(_on_server_client_connected)
	network_server.client_disconnected.connect(_on_server_client_disconnected)
	network_server.data_received.connect(_on_server_data_received)
	add_child(network_server)

func start_multiple_network_clients(address: String, port: int, client_count: int):
	for i in range(client_count):
		var network_client = NetworkClient.new(address, port)
		network_client.data_received.connect(func(data): _on_client_data_received(network_client, data))
		network_clients.append(network_client)
		add_child(network_client)
		print("Client with ID " + str(i + 1) + " started.")

func _on_client_data_received(network_client, data):
	print("Client received data: " + str(data))
	

	if data != "Hello Server from client":
		network_client.send_data("Hello Server from client")
	
	
	for i in range(network_clients.size()):
		if network_clients[i] == network_client:
			var client_id = i
			print("Client " + str(client_id) + " received: " + str(data))
			break

func _on_server_client_connected(player_id):
	print("Server has connection for id: " + str(player_id))
	

func _on_server_client_disconnected(player_id):
	print("Server has disconnection for id: " + str(player_id))

func _on_server_data_received(player_id, data):
	print("Server received data from (" + str(player_id) + "): " + str(data))
	network_server.send_data(player_id, "Hello Client")  # Responder al cliente

# Función de prueba para enviar mensajes desde cada cliente utilizando su ID
func test_send_messages():
	for client_id in range(network_clients.size()):
		var network_client = network_clients[client_id]
		var message = "Mensaje desde el cliente con ID " + str(client_id)
		print(message)
		network_client.send_data(message)

# Nueva función para enviar un mensaje a un cliente específico
func send_message_to_client_by_id(custom_id, message):
	if custom_id > 0 and custom_id <= network_clients.size():
		var network_client = network_clients[custom_id - 1]  
		network_client.send_data(message)
		print("Message sent to client: " + str(custom_id))
	else:
		print("Error: Client with ID " + str(custom_id) + " not found")

















func _on_send_pressed() -> void:
	# Ejemplo de uso de la nueva función
	send_message_to_client_by_id(6, "Mensaje especial al cliente id")
	test_send_messages()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	
	start_network_server(address, port)
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	start_multiple_network_clients(address, port, 20)  # Crear 20 clientes
	pass # Replace with function body.
