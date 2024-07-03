extends Node2D

var card = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	deal_card()

func deal_card():
	var instance : Card = card.instantiate()
	instance.face_sprite = card_faces.pick_random()
	add_child(instance)
