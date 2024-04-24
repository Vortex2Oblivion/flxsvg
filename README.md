# flxsvg

![](https://img.shields.io/github/repo-size/Vortex2Oblivion/flxsvg) ![](https://badgen.net/github/open-issues/Vortex2Oblivion/flxsvg) ![](https://badgen.net/badge/license/MIT/green)

[OpenFL SVG Render](https://github.com/openfl/svg/) support for HaxeFlixel.

### Installation


This library can only be installed via GIT as of now
```bash
haxelib git flxsvg https://github.com/Vortex2Oblivion/flxsvg
```

### Usage

```haxe
package;

import flixel.FlxState;
import openfl.utils.Assets;
import flxsvg.FlxSvgSprite;

class PlayState extends FlxState
{

	var svg:FlxSvgSprite;

	override public function create()
	{
		super.create();
		svg = new FlxSvgSprite(Assets.getText("assets/images/haxe.svg"));
		svg.screenCenter();
		add(svg);
	}
}
```

### Licensing

**flxsvg** is made available under the **MIT License**. Check [LICENSE](./LICENSE) for more information.
