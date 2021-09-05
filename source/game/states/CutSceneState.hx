package game.states;

import flixel.addons.text.FlxTypeText;

/**
 * Speed in seconds, before a character is rendered
 * to the screen. So 1 second before you see the next 
 * letter.
 */
enum abstract TextSpeed(Float) from Float to Float {
	var FAST = 0.25;
	var NORMAL = 0.55;
	var SLOW = 1;
}

class CutsceneState extends FlxState {
	public var sceneText:FlxTypeText;
	public var textIndex:Int;
	public var textList:Array<SceneText>;
	public var nextState:FlxState;
	public var skipBar:FlxBar;
	public var skipText:FlxText;
	public var skipThreshold:Float;
	public var skipPerc:Int;
	public var textComplete:Bool;

	/** *  Delay before transitioning to the next text in seconds.
	 */
	public var textDelay:Float;

	public static inline var TEXT_WIDTH:Int = 400;
	public static inline var INIT_TEXT_DELAY:Int = 3;
	public static inline var SKIP_THRESHOLD:Float = 2.5;

	public function new(newState:FlxState, textInfo:Array<SceneText>) {
		bgColor = KColor.RICH_BLACK_FORGRA;
		textIndex = -1;
		skipThreshold = 0;
		skipPerc = 0;
		textComplete = false;
		textList = textInfo;
		nextState = newState;
		textDelay = 0;

		super();
	}

	override public function create() {
		createSkip();
		createSceneText();
		transitionText();
		super.create();
	}

	public function createSkip() {
		var margin = 48;
		var barWidth = 100;
		var x = FlxG.width - (barWidth + margin);
		var y = margin;
		skipBar = new FlxBar(x, y, LEFT_TO_RIGHT, barWidth, 20, this,
			"skipPerc", 0, 100, true);
		skipBar.createFilledBar(KColor.BLACK, KColor.BURGUNDY, true,
			KColor.SNOW);
		skipText = new FlxText(skipBar.x + (skipBar.width / 2), (skipBar.y),
			50, 'Skip', Globals.FONT_N);
		skipText.y += 2;
		skipText.x -= 12;
		skipText.color = KColor.SNOW;
		skipBar.visible = false;
		skipText.visible = false;

		add(skipBar);
		add(skipText);
	}

	public function createSceneText() {
		sceneText = new FlxTypeText(0, 0, TEXT_WIDTH, '', Globals.FONT_L);
		sceneText.screenCenter();
		add(sceneText);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateSkip(elapsed);
		updateText(elapsed);
	}

	public function updateSkip(elapsed:Float) {
		// Update Perc
		skipPerc = Math.ceil((skipThreshold / SKIP_THRESHOLD) * 100);
		if (skipPerc > 0) {
			skipBar.visible = true;
			skipText.visible = true;
		} else {
			skipBar.visible = false;
			skipText.visible = false;
		}
		if (FlxG.keys.anyPressed([Z])) {
			skipThreshold += elapsed;
		} else if (skipPerc < 100 && skipPerc > 0) {
			skipThreshold -= elapsed;
		}

		if (skipThreshold >= SKIP_THRESHOLD) {
			transitionToScene();
		}
	}

	public function updateText(elapsed:Float) {
		var currentText = textList[textIndex % textList.length];
		var delay = currentText.delay;
		if (textIndex < textList.length - 1) {
			if (textDelay > delay) {
				transitionText();
			}
		} else if (textDelay > delay) {
			transitionToScene();
		}
		if (textComplete) {
			textDelay += elapsed;
		}
	}

	public function transitionText() {
		textIndex++;
		textComplete = false;
		var currentText = textList[textIndex % textList.length];
		sceneText.resetText(currentText.text);
		sceneText.start(TextSpeed.NORMAL, false, false, [SPACE], () -> {
			textComplete = true;
		});
		textDelay = 0;
	}

	public function transitionToScene() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			FlxG.camera.fade(KColor.BLACK, 1, true);
			FlxG.switchState(nextState);
		});
	}
}