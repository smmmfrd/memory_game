extends TextureRect

var hovered := false

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and hovered:
			get_parent().clicked.emit()

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false
