package game.states;

import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends BaseGameState {
	override public function create() {
		super.create();
		createLevel(project.all_levels.Level_0);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}