package;

import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.utils.Assets;
import flxsvg.FlxSvgSprite;

class PlayState extends FlxState
{

	var svg:FlxSvgSprite;

	override public function create()
	{
		super.create();
		bgColor = FlxColor.WHITE;
		svg = new FlxSvgSprite(Assets.getText("assets/images/haxe.svg"));
		svg.screenCenter();
		add(svg);
	}
}
