extends Node2D

var network_clients: Array = []
var network_server: NetworkServer

func _ready():
	var address = "127.0.0.1"
	var port = 1454
	start_network_server(address, port)
	start_multiple_network_clients(address, port, 20)  # Crear 20 clientes
	call_deferred("test_send_messages")  
	call_deferred("test_send_messages")  #

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

func _on_client_data_received(network_client, data):
	print("Client received data: " + str(data))
	network_client.send_data("Hello Server from client")

func _on_server_client_connected(player_id):
	print("Server has connection for id: " + str(player_id))
	network_server.send_data(player_id, "Hello Client")

func _on_server_client_disconnected(player_id):
	print("Server has disconnection for id: " + str(player_id))

func _on_server_data_received(player_id, data):
	print("Server received data from (" + str(player_id) + "): " + str(data))

# Función de prueba para enviar mensajes desde cada cliente utilizando su ID
func test_send_messages():
	for client_id in range(network_clients.size()):
		var network_client = network_clients[client_id]
		var message = "Mensaje desde el cliente con ID " + str(client_id)
		print(message)
		network_client.send_data(message)


func _on_button_pressed() -> void:
	call_deferred("test_send_messages")
	pass # Replace with function body.
