package game;

import flixel.text.FlxBitmapText;
import flixel.graphics.frames.FlxBitmapFont;
import lime.utils.Assets;

class TitleText extends FlxBitmapText {
	public function new() {
		var xmlData = Assets.getText(AssetPaths.thaleah__fnt);
		var customFont = FlxBitmapFont.fromAngelCode(AssetPaths.thaleah__png,
			xmlData);
		super(customFont);
		this.useTextColor = false;
		this.borderColor = 0xFFFFFFFF;
		this.multiLine = true;
	}
}