extends Node2D

func change_scene(target: String) -> void:
	$fade/FadePlayer.play('fade')
	await($fade/FadePlayer.animation_finished)
	get_tree().change_scene_to_file(target)
	$fade/FadePlayer.play_backwards('fade')
