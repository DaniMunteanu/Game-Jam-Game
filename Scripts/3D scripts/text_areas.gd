extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes1", ["Ozzy, I'm coming for you.", "I'm finally coming for you..."])


func _on_nd_text_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes2", ["I was the Fool who messed up the spell, all those years ago. I should have paid the price."])


func _on_third_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes3", ["Instead, the World ripped you away from me. And I've missed you every day since."])


func _on_fourth_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes4", ["But now, I've changed. It is time to end my guilt."])


func _on_fifth_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Character"):
		TextManager.show_once("mes5", ["IT IS TIME TO SET THINGS RIGHT."])
