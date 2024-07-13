extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

@export var number_of_cards: int = 2

var dealt_cards : Array[Card]

var check_val: String = ""

signal card_selected (card_face: String)

@onready var card_height = card_faces[0].get_height()
@onready var card_width = card_faces[0].get_width()

func _ready():
	connect("card_selected", check_card)
	
	for i in range(number_of_cards):
		deal_card(i)

func deal_card(index: int):
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_faces.pick_random()
	instance.global_position = self.global_position + Vector2(card_width * index,0)
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
