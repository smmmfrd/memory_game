extends Node2D

var card_prefab = preload("res://card.tscn")

@export var card_faces : Array[Texture2D]

@export var table: Vector2i
@export var copies: int = 2

var check_val: String = ""
var num_check: int = 0

signal card_selected (card_face: String)

@onready var card_height = card_faces[0].get_height()
@onready var card_width = card_faces[0].get_width()

func _ready():
	connect("card_selected", check_card)
	
	deal_table()
	
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

func deal_table():
	var deck : Array[Texture2D]
	
	var possible_cards = card_faces
	possible_cards.shuffle()
	
	for i in range((table.x * table.y) / copies):
		var new_card = possible_cards.pop_front()
		
		for j in copies:
			deck.append(new_card)
	
	deck.shuffle()
	
	for i in range(table.x * table.y):
		deal_card(i, deck[i])

func deal_card(index: int, card_face: Texture2D):
	var instance : Card = card_prefab.instantiate()
	instance.face_sprite = card_face
	
	var dealt_pos := Vector2(card_width * (index % table.x), card_height * floor(index /table.x ))
	instance.global_position = self.global_position + dealt_pos
	
	add_child(instance)

func check_card(card_face: String):
	num_check += 1
	print(num_check)
	
	if num_check == 1:
		check_val = card_face
	else:
		if check_val == card_face and num_check == copies:
			clear_match(true)
			num_check = 0
		elif check_val != card_face:
			clear_match(false)
			
			check_val = ""
			num_check = 0

func clear_match(cards_match: bool):
	for i in self.get_children():
		if i.face_up:
			if cards_match:
				i.queue_free()
			else:
				i.flip()
	
	if len(self.get_children()) == 0:
		print("Board Cleared!")
