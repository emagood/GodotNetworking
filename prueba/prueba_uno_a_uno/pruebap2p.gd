extends Node2D

var network_client: NetworkClient
var network_server: NetworkServer
var address = "127.0.0.1"
var port = 3115

func _ready():
	start_network_server(address, port)
	start_network_client(address, port)

func start_network_server(address: String, port: int):
	network_server = NetworkServer.new(address, port)
	network_server.client_connected.connect(_on_server_client_connected)
	network_server.client_disconnected.connect(_on_server_client_disconnected)
	network_server.data_received.connect(_on_server_data_received)
	add_child(network_server)
	print("Network server started.")

func start_network_client(address: String, port: int):
	network_client = NetworkClient.new(address, port)
	network_client.data_received.connect(_on_client_data_received)
	network_client.connection_successful.connect(_on_client_connected)
	network_client.connection_failed.connect(_on_client_disconnected)
	add_child(network_client)
	print("Network client started.")

func _on_client_data_received(data):
	print("Client received data: " + str(data))
	network_client.send_data("Hello Server from client")

func _on_server_client_connected(client_id):
	print("Server has connection for id: " + str(client_id))

func _on_server_client_disconnected(client_id):
	print("Server has disconnection for id: " + str(client_id))

func _on_server_data_received(client_id, data):
	print("Server received data from (" + str(client_id) + "): " + str(data))
	network_server.send_data(client_id, "Hello Client")  # Responder al cliente

func _on_client_connected():
	print("Client successfully connected to server")
	network_client.send_data("Hello Server from client")

func _on_client_disconnected():
	print("Client disconnected from server")

func _on_send_pressed() -> void:
	network_client.send_data("Mensaje especial al servidor")
	pass
