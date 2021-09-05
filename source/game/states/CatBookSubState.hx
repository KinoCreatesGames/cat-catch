package game.states;

class CatBookSubState extends FlxSubState {
	public var menuExitSound:FlxSound;

	public function new() {
		super(KColor.RICH_BLACK_FORGRA_LOW);
	}

	override public function create() {
		menuExitSound = FlxG.sound.load(AssetPaths.pause_out__wav);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateButtonPress();
	}

	public function updateButtonPress() {
		var exitButtonPressed = FlxG.keys.anyJustPressed([ESCAPE, X]);
		if (exitButtonPressed) {
			FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
				close();
				FlxG.camera.fade(KColor.BLACK, 1, true);
			});
		}
	}
}