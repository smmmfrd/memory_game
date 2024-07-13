extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

var dealt_cards : Array[Card]

var check_val: String = ""

signal card_selected (card_face: String)

func _ready():
	connect("card_selected", check_card)
	
	deal_card()

func deal_card():
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_faces.pick_random()
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
