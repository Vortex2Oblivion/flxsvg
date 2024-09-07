package flxsvg;

import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import format.svg.SVGData;
import format.svg.SVGRenderer;
import openfl.geom.Matrix;
import openfl.display.Shape;

class FlxSvgSprite extends FlxSprite
{
	public var svgWidth(default, set):Float = 0;
	public var svgHeight(default, set):Float = 0;

	@:noCompletion
	private var svgData:SVGData;

	@:noCompletion
	private var svgDirty:Bool = false;

	public function new(x:Float = 0, y:Float = 0):Void
	{
		super(x, y);
	}

	public override function draw():Void
	{
		if (svgDirty)
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

			pixels.draw(shape);

			svgDirty = false;
		}

		super.draw();
	}

	public function loadSvg(svgData:FlxXmlAsset, ?svgWidth:Float, ?svgHeight:Float):FlxSvgSprite
	{
		if (xml != null)
		{
			final xmlData:Xml = xml.getXml();

			if (xmlData.firstElement()?.nodeName != "svg" && xmlData.firstElement()?.nodeName != "svg:svg")
				return this;

			svgData = new SVGData(xmlData);

			this.svgWidth = svgWidth > 0 ? svgWidth : svgData.width;
			this.svgHeight = svgHeight > 0 ? svgHeight : svgData.height;
		}

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
}
