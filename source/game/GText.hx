package game;

import lime.utils.Assets;
import flixel.text.FlxBitmapText;
import flixel.graphics.frames.FlxBitmapFont;

class GText extends FlxBitmapText {
	public function new() {
		var xmlData = (Assets.getText(AssetPaths.thaleah_standard__fnt));
		var customFont = FlxBitmapFont.fromAngelCode(AssetPaths.thaleah_standard__png,
			xmlData);
		super(customFont);
		this.useTextColor = false;
		this.borderColor = 0xFFFFFFFF;
		this.multiLine = true;
	}
}