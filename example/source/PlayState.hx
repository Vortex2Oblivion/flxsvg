package;

import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.utils.Assets;
import flxsvg.FlxSvgSprite;
import flixel.FlxG;

class PlayState extends FlxState
{

	var svg:FlxSvgSprite;

	override public function create()
	{
		super.create();
		bgColor = FlxColor.WHITE;
		svg = new FlxSvgSprite(Assets.getText("assets/images/HaxeFlixel.svg"));
		svg.screenCenter();
		add(svg);
	}
}
