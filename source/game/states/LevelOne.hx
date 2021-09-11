package game.states;

import flixel.addons.display.FlxBackdrop;

class LevelOne extends BaseGameState {
	override public function create() {
		super.create();
		var bg = new FlxBackdrop(AssetPaths.cloud_bg__png);
		add(bg);
		createLevel(project.all_levels.Level_1);
	}
}