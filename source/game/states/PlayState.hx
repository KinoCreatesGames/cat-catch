package game.states;

import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends BaseGameState {
	override public function create() {
		super.create();
		var bg = new FlxBackdrop(AssetPaths.cloud_bg__png, 0.5, 0);
		// Offset BG to account for camera position in the level

		add(bg);

		createLevel(project.all_levels.Level_0);

		var text = new GText();
		text.text = 'Hello world to the Bitmap text world';
		text.screenCenter();
		// add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}