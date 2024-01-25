using Godot;
using System;

public partial class menu : Control
{
	private void OnStartGamePressed()
	{
		GetTree().ChangeSceneToFile("res://Painting Room/painting room.tscn");
	}
	
	private void OnControlsPressed()
	{
		GD.Print("Controls button pressed");
		// toggle controls menu
	}
	
	private void OnOptionsPressed()
	{
		GD.Print("Options button pressed");
		// toggle options menu
	}
	
	private void OnQuitPressed()
	{
		GetTree().Quit();
	}
}
