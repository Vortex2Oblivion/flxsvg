package flxsvg;

import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import format.svg.SVGData;
import format.svg.SVGRenderer;
import openfl.geom.Matrix;
import openfl.display.Shape;

/**
 * A sprite that supports rendering Scalable Vector Graphics (SVG) within HaxeFlixel.
 * This class uses OpenFL to render SVG content into a Flixel sprite, allowing for scalable,
 * dynamic graphics in games or UI elements.
 *
 * @author Vortex2Oblivion
 * @author Mihai Alexandru (MAJigsaw77)
 */
class FlxSvgSprite extends FlxSprite
{
	/**
	 * The width of the SVG content to be rendered.
	 */
	public var svgWidth(default, set):Float = 0;

	/**
	 * The height of the SVG content to be rendered.
	 */
	public var svgHeight(default, set):Float = 0;

	/**
	 * Private storage for the parsed SVG data.
	 */
	@:noCompletion
	private var svgData:SVGData;

	/**
	 * A flag indicating whether the sprite needs to be redrawn (if the SVG content, dimensions or antialiasing have changed).
	 */
	@:noCompletion
	private var svgDirty:Bool = false;

	/**
	 * Creates a `FlxSvgSprite` at a specified position.
	 * @param x The initial X position of the sprite.
	 * @param y The initial Y position of the sprite.
	 */
	public function new(?x:Float = 0, ?y:Float = 0):Void
	{
		super(x, y);
	}

	public override function draw():Void
	{
		if (svgDirty)
		{
			if (svgData != null)
			{
				final diffX:Int = Math.floor(svgWidth) - pixels.width;
				final diffY:Int = Math.floor(svgHeight) - pixels.height;

				if (diffX != 0 || diffY != 0)
					makeGraphic(Math.floor(svgWidth), Math.floor(svgHeight), FlxColor.TRANSPARENT, true);
				else
					pixels.fillRect(pixels.rect, FlxColor.TRANSPARENT);

				final matrix:Matrix = new Matrix();

				matrix.identity();

				if (svgWidth > 0 && svgHeight > 0)
					matrix.scale(Math.floor(svgWidth) / svgData.width, Math.floor(svgHeight) / svgData.height);

				final shape:Shape = new Shape();

				new SVGRenderer(svgData).render(shape.graphics, matrix);

				pixels.draw(shape, antialiasing);

				dirty = true;
			}

			svgDirty = false;
		}

		super.draw();
	}

	public override function destroy():Void
	{
		super.destroy();

		svgData = null;
	}

	/**
	 * Loads an SVG from a `FlxXmlAsset` and optionally sets its width and height.
	 * @param svgData The `FlxXmlAsset` containing the SVG data.
	 * @param svgWidth (Optional) The width to render the SVG. Defaults to the intrinsic width of the SVG.
	 * @param svgHeight (Optional) The height to render the SVG. Defaults to the intrinsic height of the SVG.
	 * @return This instance, to allow for method chaining.
	 */
	public function loadSvg(svgData:FlxXmlAsset, ?svgWidth:Float, ?svgHeight:Float):FlxSvgSprite
	{
		if (svgData != null)
		{
			final xmlData:Xml = svgData.getXml();

			if (xmlData.firstElement()?.nodeName != 'svg' && xmlData.firstElement()?.nodeName != 'svg:svg')
			{
				FlxG.log.error('Not an SVG file (${xmlData.firstElement()?.nodeName})');
				return this;
			}

			this.svgData = new SVGData(xmlData);
			this.svgWidth = svgWidth > 0 ? svgWidth : this.svgData.width;
			this.svgHeight = svgHeight > 0 ? svgHeight : this.svgData.height;

			makeGraphic(Math.floor(this.svgWidth), Math.floor(this.svgHeight), FlxColor.TRANSPARENT, true);
		}
		else
			FlxG.log.error('No SVG data provided');

		return this;
	}

	@:noCompletion
	private function set_svgWidth(value:Float):Float
	{
		svgWidth = value;

		if (svgData != null)
			svgDirty = true;

		return svgWidth;
	}

	@:noCompletion
	private function set_svgHeight(value:Float):Float
	{
		svgHeight = value;

		if (svgData != null)
			svgDirty = true;

		return svgHeight;
	}

	@:noCompletion
	private override function set_antialiasing(value:Bool):Bool
	{
		antialiasing = value;

		if (svgData != null)
			svgDirty = true;

		return antialiasing;
	}
}
