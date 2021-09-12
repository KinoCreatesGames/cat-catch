package game.states;

class CreditsSubState extends FlxSubState {
	var titleText:FlxText;
	var mouseCursor:FlxSprite;

	public function new() {
		super(KColor.RICH_BLACK_FORGRA_LOW);
	}

	override public function create() {
		super.create();
		var verticalPadding = 24;
		var horizontalPadding = 24;
		setupMouse();
		createTitle(horizontalPadding, verticalPadding);
		createCredits(horizontalPadding, verticalPadding * 3);
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

	function createTitle(x:Float, y:Float) {
		titleText = new FlxText(x, y);
		titleText.cameraCenterHorz();
		add(titleText);
	}

	function createCredits(x:Float, y:Float) {
		var kinoText = new FlxText(x, y, -1, 'Designer Kino Rose - @EISKino',
			Globals.FONT_L);
		y += 40;
		var jdText = new FlxText(x, y, -1, 'Music by JDSherbert',
			Globals.FONT_L);

		kinoText.cameraCenterHorz();
		jdText.screenCenterHorz();
		add(kinoText);
		add(jdText);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		updateMouse();
		if (FlxG.keys.anyJustPressed([ESCAPE, X, Z]) || FlxG.mouse.justPressed) {
			close();
		}
	}

	function updateMouse() {
		mouseCursor.scrollFactor.set(0, 0);
		var mousePosition = FlxG.mouse.getPosition();
		mouseCursor.setPosition(mousePosition.x, mousePosition.y);
	}
}