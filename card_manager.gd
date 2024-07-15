extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

@export var table: Vector2i

var check_val: String = ""

signal card_selected (card_face: String)

@onready var card_height = card_faces[0].get_height()
@onready var card_width = card_faces[0].get_width()

func _ready():
	connect("card_selected", check_card)
	
	var deck : Array[Texture2D]
	
	var possible_cards = card_faces
	possible_cards.shuffle()
	
	for i in range((table.x + table.y) / 2):
		var new_card = possible_cards.pop_front()
		
		deck.append(new_card)
		deck.append(new_card)
	
	deck.shuffle()
	
	for i in range(table.x + table.y):
		deal_card(i, deck[i])
	
	center_table()

func center_table():
	# Set the table's position to half the board size, then add half a card in size
	# With the cards' origin is at the center, and the first is made at the
	# table's center, this calculation makes a perfect center.
	var dest = Vector2(-(table.x * 0.5) * card_width + (card_width / 2),
		-(table.y * 0.5) * card_height + (card_height / 2))
	print(dest)
	
	global_position = dest
	print(global_position)

func deal_card(index: int, card_face: Texture2D):
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_face
	
	var dealt_pos := Vector2(card_width * (index % table.x), card_height * floor(index /table.x ))
	instance.global_position = self.global_position + dealt_pos
	
	add_child(instance)

func check_card(card_face: String):
	if check_val == "":
		check_val = card_face
	else:
		process_choice(check_val == card_face)
		
		check_val = ""

func process_choice(cards_match: bool):
	for i in self.get_children():
		if i.face_up:
			if cards_match:
				i.queue_free()
			else:
				i.flip()
	
	if len(self.get_children()) == 0:
		print("Board Cleared!")
