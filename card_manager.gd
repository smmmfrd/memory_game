extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

var dealt_cards : Array[Card]

signal card_selected (card_face)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("card_selected", check_card)
	
	deal_card()

func deal_card():
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_faces.pick_random()
	#instance.flipped.connect(func(): check_card(instance.face_sprite.resource_name))
	dealt_cards.push_back(instance)
	add_child(instance)

func check_card(card_face: String):
	print("Dealer sees: " + card_face)
