package flxsvg;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import format.SVG;
import format.svg.SVGRenderer;
import openfl.display.BitmapData;
import openfl.display.Shape;

/**
 * A ```FlxSprite``` meant for loading SVG files via OpenFL's SVG rendering library.
 * @author Vortex
 */
class FlxSvgSprite extends FlxSprite{

    private var _svg:SVG;
    private var _shape:Shape;

    public var data:String;

    public function new(data:String, X:Float = 0, Y:Float = 0){
        super(X,Y);
        this.data = data;
        _shape = new Shape();
        _svg = new SVG(data);
        _svg.render(_shape.graphics);

        var renderer = new SVGRenderer(_svg.data);

        var bitmapData = new BitmapData(Std.int(renderer.width), Std.int(renderer.height), true, FlxColor.TRANSPARENT);
        bitmapData.draw(_shape);
        
        pixels = bitmapData;
    }
}