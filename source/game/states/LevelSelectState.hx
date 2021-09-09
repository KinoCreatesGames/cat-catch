package game.states;

// Allows the plyaer to select a level to play
class LevelSelectState extends FlxState {
	override public function create() {
		createTitle();
		createLevelImage();
		createLevelSelectButtons();
		super.create();
	}

	public function createTitle() {}

	public function createLevelImage() {}

	public function createLevelSelectButtons() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processStateTransitions();
	}

	public function processStateTransitions() {
		var exitButtonPressed = FlxG.keys.anyJustPressed([ESCAPE, X]);
		if (exitButtonPressed) {
			promptReturnToTitle();
		}
	}

	public function promptReturnToTitle() {
		// Show Dialog Box then return to title
	}
}