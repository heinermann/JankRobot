using Godot;
using System;

public partial class menu : Control
{
	private void OnStartGamePressed()
	{
		GetTree().ChangeSceneToFile("res://Painting Room/painting room.tscn");
	}

	private void OnQuitPressed()
	{
		GetTree().Quit();
	}
}
