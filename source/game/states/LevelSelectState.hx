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
}