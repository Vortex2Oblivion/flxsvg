package flxsvg;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.math.FlxMatrix;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import format.svg.SVGData;
import format.svg.SVGRenderer;
import openfl.display.Shape;

/**
 * A sprite that supports rendering Scalable Vector Graphics (SVG) within HaxeFlixel.
 * This class uses OpenFL to render SVG content into a Flixel sprite, allowing for scalable,
 * dynamic graphics in games or UI elements.
 *
 * @author Vortex2Oblivion
 * @author Mihai Alexandru (MAJigsaw77)
 */
class FlxSvgSprite extends FlxSprite {
	/**
	 * Private storage for the parsed SVG data.
	 */
	@:noCompletion
	private var svgData(default, set):SVGData;

	/**
	 * A flag indicating whether the sprite needs to be redrawn (if the SVG content, dimensions or antialiasing have changed).
	 */
	@:noCompletion
	private var svgDirty:Bool = false;

	@:noCompletion
	private var renderer:SVGRenderer;

	@:noCompletion
	private final matrix:FlxMatrix = new FlxMatrix();

	@:noCompletion
	private final shape:Shape = new Shape();

	/**
	 * Creates a `FlxSvgSprite` at a specified position.
	 * @param x The initial X position of the sprite.
	 * @param y The initial Y position of the sprite.
	 */
	public function new(?x:Float = 0, ?y:Float = 0):Void {
		super(x, y);
	}

	public override function draw():Void {
		if (svgDirty) {
			if (svgData != null && pixels != null) {
				final diffX:Int = Math.floor(width) - pixels.width;
				final diffY:Int = Math.floor(height) - pixels.height;

				if (diffX != 0 || diffY != 0)
					makeGraphic(Math.floor(width), Math.floor(height), FlxColor.TRANSPARENT, true);
				else
					pixels.fillRect(pixels.rect, FlxColor.TRANSPARENT);

				matrix.identity();

				if (width > 0 && height > 0)
					matrix.scale(Math.floor(width) / svgData.width, Math.floor(height) / svgData.height);

				renderer.render(shape.graphics, matrix);

				pixels.draw(shape, antialiasing);

				shape.graphics.clear();

				dirty = true;
			}

			svgDirty = false;
		}

		super.draw();
	}

	public override function destroy():Void {
		super.destroy();
		svgData = null;
	}

	/**
	 * Loads an SVG from a `FlxXmlAsset` and optionally sets its width and height.
	 * @param svgData The `FlxXmlAsset` containing the SVG data.
	 * @param width (Optional) The width to render the SVG. Defaults to the intrinsic width of the SVG.
	 * @param height (Optional) The height to render the SVG. Defaults to the intrinsic height of the SVG.
	 * @return This instance, to allow for method chaining.
	 */
	public function loadSvg(svgData:FlxXmlAsset, ?width:Float, ?height:Float):FlxSvgSprite {
		if (svgData != null) {
			final xmlData:Xml = svgData.getXml();

			if (xmlData.firstElement()?.nodeName != 'svg' && xmlData.firstElement()?.nodeName != 'svg:svg') {
				FlxG.log.error('Not an SVG file (${xmlData.firstElement()?.nodeName})');
				return this;
			}

			this.svgData = new SVGData(xmlData);
			this.width = width > 0 ? width : this.svgData.width;
			this.height = height > 0 ? height : this.svgData.height;

			makeGraphic(Math.floor(this.width), Math.floor(this.height), FlxColor.TRANSPARENT, true);
		} else
			FlxG.log.error('No SVG data provided');

		return this;
	}
	
	@:noCompletion
	private inline function set_svgData(data:SVGData):SVGData {
		renderer = new SVGRenderer(data);
		return this.svgData = data;
	}

	@:noCompletion
	override private function get_width() {
		return  svgData != null ? svgData.width : super.get_width();
	}

	@:noCompletion
	override private function get_height() {
		return svgData != null ? svgData.height : super.get_height();
	}

	@:noCompletion
	override private function set_width(value:Float):Float {
		width = value;

		if (svgData != null)
			svgDirty = true;

		return width;
	}

	@:noCompletion
	override private function set_height(value:Float):Float {
		height = value;

		if (svgData != null)
			svgDirty = true;

		return height;
	}

	@:noCompletion
	private override function set_antialiasing(value:Bool):Bool {
		antialiasing = value;

		if (svgData != null)
			svgDirty = true;

		return antialiasing;
	}
}
