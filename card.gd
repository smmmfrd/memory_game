class_name Card

extends Node2D

var card_back : Texture2D = preload("res://sprites/card_back.png")

@onready var sprite = $Sprite

@export var face_sprite : Texture2D

var face_up := false

signal clicked

signal flipped(card_face: String)

func _ready():
	clicked.connect(func():
		if not face_up:
			flip()
	)

func flip():
	var t := create_tween()
	t.tween_property(sprite, "scale", Vector2(0.1, 1), 0.1)
	t.tween_callback(func(): 
		face_up = not face_up
		sprite.texture = face_sprite if face_up else card_back
	)
	t.tween_property(sprite, "scale", Vector2(1, 1), 0.1)
	t.tween_callback(func(): 
		get_parent().emit_signal("card_selected", face_sprite.resource_path)
	)
