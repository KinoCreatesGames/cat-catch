package game.states;

class ThankYouState extends FlxState {
	public var mouseCursor:FlxSprite;

	override public function create() {
		super.create();
		createThankYou();
		setupMouse();
	}

	function createThankYou() {
		var content = 'Thank you for playing!'.split("\n").map((line) -> {
			return line.trim();
		}).join("\n");
		var text = new FlxText(0, 0, -1, content, Globals.FONT_N);
		text.screenCenter();
		add(text);
	}

	function setupMouse() {
		mouseCursor = new FlxSprite(12, 12);
		mouseCursor.loadGraphic(AssetPaths.mouse_cursor__png, true, 12, 12,
			true);
		mouseCursor.animation.add('moving', [0], null, true);
		mouseCursor.animation.add('hold', [1], null, true);
		FlxG.mouse.visible = false;
		add(mouseCursor);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processStateTransition();
		updateMouse();
	}

	public function processStateTransition() {
		if (FlxG.mouse.justPressed) {
			FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
				FlxG.camera.fade(KColor.BLACK, 1, true);
				FlxG.switchState(new TitleState());
			});
		}
	}

	function updateMouse() {
		mouseCursor.scrollFactor.set(0, 0);
		var mousePosition = FlxG.mouse.getPosition();
		mouseCursor.setPosition(mousePosition.x, mousePosition.y);
	}
}