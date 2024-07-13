extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

@export var table: Vector2i

var dealt_cards : Array[Card]

var check_val: String = ""

signal card_selected (card_face: String)

@onready var card_height = card_faces[0].get_height()
@onready var card_width = card_faces[0].get_width()

func _ready():
	connect("card_selected", check_card)
	
	for i in range(table.x + table.y):
		deal_card(i)

func deal_card(index: int):
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_faces.pick_random()
	
	var dealt_pos := Vector2(card_width * (index % table.x), card_height * floor(index /table.x ))
	instance.global_position = self.global_position + dealt_pos
	
	dealt_cards.push_back(instance)
	add_child(instance)

func check_card(card_face: String):
	print("Dealer sees: " + card_face)
	
	if check_val == "":
		check_val = card_face
	else:
		if check_val == card_face:
			print("That's a match!")
		else:
			print("No match found.")
		check_val = ""
