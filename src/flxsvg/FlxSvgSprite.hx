package flxsvg;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import format.SVG;
import format.svg.SVGRenderer;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.utils.Assets;

/**
 * A ```FlxSprite``` meant for loading SVG files via OpenFL's SVG rendering library.
 * @author Vortex
 */
class FlxSvgSprite extends FlxSprite{

    private var _svg:SVG;
    private var _shape:Shape;

    public var data:String;

    /**
     * Creats a new ```FlxSvgSprite```
     * @param data The SVG data as a string.
     * @param X The X position.
     * @param Y The Y position.
     */
    public function new(data:String, X:Float = 0, Y:Float = 0){
        super(X,Y);
        this.data = data;
        render(data);
    }

    public function render(data:String){
        if(data == null || data.length <= 0){
            data = Assets.getText("flxsvg/images/flixel.svg");
        }
        _shape = new Shape();
        _svg = new SVG(data);
        _svg.render(_shape.graphics);

        var renderer = new SVGRenderer(_svg.data);

        var bitmapData = new BitmapData(Std.int(renderer.width), Std.int(renderer.height), true, FlxColor.TRANSPARENT);
        bitmapData.draw(_shape);
                
        pixels = bitmapData;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        untyped pixels.width = width;
        untyped pixels.height = height;
    }
}