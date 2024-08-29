package flxsvg;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import format.SVG;
import format.svg.SVGRenderer;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.utils.Assets;

/**
 * A ```FlxSprite``` meant for loading SVG files via OpenFL's SVG rendering library.
 * @author Vortex
 */
class FlxSvgSprite extends FlxSprite {
	private var _svg:SVG;
	private var _shape:Shape;
	private var _bitmapData:BitmapData;

	/**
	 * The raw SVG data as a string.
	 */
	public var data(default, null):String;

	/**
	 * Creats a new ```FlxSvgSprite```
	 * @param data The SVG data as a string.
	 * @param X The X position.
	 * @param Y The Y position.
	 */
	public function new(data:String, X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.data = data;
		render(data);
	}

	/**
	 * Renders a SVG graphic to an FlxSprite
	 * @param data 
	 */
	public function render(data:String) {
        if (data == '' || (Xml.parse(data).firstElement()?.nodeName != "svg" && Xml.parse(data).firstElement()?.nodeName != "svg:svg")) {
            FlxG.log.error("Not an SVG file ("+ (data == '' ? "null" : Xml.parse(data).firstElement()?.nodeName) + ")");
            loadGraphic("flixel/images/logo/default.png");
            return;
        }
		_shape = new Shape();
		_svg = new SVG(data);
		_svg.render(_shape.graphics);

		var renderer:SVGRenderer = new SVGRenderer(_svg.data);

		_bitmapData = new BitmapData(Std.int(renderer.width), Std.int(renderer.height), true, FlxColor.TRANSPARENT);
		_bitmapData.draw(_shape);

		loadGraphic(_bitmapData);
		updateHitbox();
	}
}
