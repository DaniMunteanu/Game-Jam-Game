extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes1", ["Brother, I'm coming for you.", "I'm finally coming for you..."])


func _on_nd_text_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes2", ["I was the Fool who messed up the spell, all those years ago. I should have paid the price."])


func _on_third_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes3", ["Instead, the World ripped you away from me. And I've missed you every day since."])


func _on_fourth_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes4", ["But, if I break your chains, the Balance will demand a price. It wants me..."])


func _on_fifth_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes5", ["OZZY, WHAT DO I DO?"])


func _on_actually_first_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes0", ["Ozzy...? Are you here?"] )
