# flxsvg

![](https://img.shields.io/github/repo-size/Vortex2Oblivion/flxsvg) ![](https://badgen.net/github/open-issues/Vortex2Oblivion/flxsvg) ![](https://badgen.net/badge/license/MIT/green)

[OpenFL SVG Render](https://github.com/openfl/svg/) support for HaxeFlixel.

### Installation

Via haxelib:
```bash
haxelib install flxsvg
```

Via git for the latest updates:
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
		svg = new FlxSvgSprite();
		svg.loadSvg(Assets.getText("assets/images/HaxeFlixel.svg"));
		add(svg);
	}
}
```

### Licensing

**flxsvg** is made available under the **MIT License**. Check [LICENSE](./LICENSE) for more information.
