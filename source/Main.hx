package;

import screenshotplugin.ScreenShotPlugin;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
		flixel.FlxG.plugins.add(new ScreenShotPlugin());
	}
}
