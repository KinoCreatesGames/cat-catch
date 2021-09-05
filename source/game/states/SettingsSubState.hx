package game.states;

import flixel.FlxObject;

/**
 * Settings state designed to hold setting information
 * in the game.
 */
class SettingsSubState extends FlxSubState {
	var mouseCursor:FlxSprite;

	public var titleText:FlxText;
	public var volumeLabel:FlxText;
	public var volumeText:FlxText;
	public var shakeLabel:FlxText;
	public var shakeButton:FlxButton;
	public var exitButton:FlxButton;
	public var textSpeedLabel:FlxText;
	public var textSpeedText:FlxText;

	override public function create() {
		super.create();
		bgColor = KColor.BLACK;
		var verticalPadding = 12;
		var margin = 24;

		createTitle(0, 0);
		createExit(FlxG.width, verticalPadding);
		createVolume(margin, titleText.y + titleText.height + verticalPadding);
		updateVolumeText();
		// createTextSpeed(margin,
		// 	(verticalPadding + volumeLabel.y + volumeLabel.height));

		members.iter((member) -> {
			if (Std.isOfType(member, FlxObject)) {
				var displayObj:FlxObject = cast member;
				displayObj.scrollFactor.set(0, 0);
			}
		});
		setupMouse();
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
		var verticalPadding = 24;
		titleText = new FlxText(0, verticalPadding, -1, Globals.TEXT_OPTIONS,
			Globals.FONT_L);
		titleText.screenCenterHorz();
		add(titleText);
	}

	function createExit(x:Float, y:Float) {
		var margin = 12;
		exitButton = new FlxButton(x, y, 'Exit', exitSettings);
		exitButton.x -= (exitButton.width + margin);
		add(exitButton);
	}

	function createVolume(x:Float, y:Float) {
		var horzSpacing = 12;
		var horzPadding = 24;
		volumeLabel = new FlxText(horzPadding, y, -1, 'Volume', Globals.FONT_N);
		var volumeDownBtn = new FlxButton((volumeLabel.x
			+ volumeLabel.width
			+ horzSpacing), y, '',
			volumeDown);
		volumeText = new FlxText(volumeDownBtn.x
			+ volumeDownBtn.width
			+ horzSpacing, y, -1,
			'100%', Globals.FONT_N);
		var volumeUpBtn = new FlxButton(volumeText.x
			+ volumeText.width
			+ horzSpacing, y, '', volumeUp);

		add(volumeLabel);
		add(volumeDownBtn);
		add(volumeText);
		add(volumeUpBtn);
	}

	function createTextSpeed(x:Float, y:Float) {
		var horzSpacing = 12;
		textSpeedLabel = new FlxText(x, y, -1, 'Text Speed', Globals.FONT_N);
		var textSpdBtnL = new FlxButton(horzSpacing
			+ textSpeedLabel.x
			+ textSpeedLabel.width, y, '',
			textSpeedDown);
		textSpeedText = new FlxText(horzSpacing
			+ textSpdBtnL.x
			+ textSpdBtnL.width, y, -1, 'Normal',
			Globals.FONT_N);
		var textSpdBtnR = new FlxButton(horzSpacing
			+ textSpeedText.x
			+ textSpeedText.width, y,
			textSpeedUp);

		add(textSpeedLabel);
		add(textSpeedText);
		add(textSpdBtnL);
		add(textSpdBtnR);
	}

	function volumeDown() {
		var increment = 5;
		var vol = ((FlxG.sound.volume * 100) - increment);
		FlxG.sound.volume = (vol / 100).clampf(0, 1);
		updateVolumeText();
	}

	function volumeUp() {
		var increment = 5;
		var vol = ((FlxG.sound.volume * 100) + increment);
		FlxG.sound.volume = (vol / 100).clampf(0, 1);
		updateVolumeText();
	}

	function textSpeedUp() {
		switch (textSpeedText.text) {
			case 'Normal':
				textSpeedText.text = 'Fast';
			case 'Slow':
				textSpeedText.text = 'Normal';
			case 'Fast':
				textSpeedText.text = 'Slow';
			case _:
				// Do nothing
		}
	}

	function textSpeedDown() {
		switch (textSpeedText.text) {
			case 'Normal':
				textSpeedText.text = 'Slow';
			case 'Slow':
				textSpeedText.text = 'Fast';
			case 'Fast':
				textSpeedText.text = 'Normal';
			case _:
				// Do nothing
		}
	}

	function updateVolumeText() {
		var displayVolume = Math.round(FlxG.sound.volume * 100);
		var text = '${(displayVolume)}%';
		volumeText.text = text;
	}

	function updateTextMode() {}

	function exitSettings() {
		saveSettings();
		close();
	}

	/**
	 * Save Functionality for Settings
	 */
	function saveSettings() {
		var save = DataPlugin.Save.createSaveSettings();
		save.data.volume = FlxG.sound.volume;
		// save.data.textMode = textSpeedText.text;
		save.close();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		updateMouse();
	}

	function updateMouse() {
		mouseCursor.scrollFactor.set(0, 0);
		var mousePosition = FlxG.mouse.getPosition();
		mouseCursor.setPosition(mousePosition.x, mousePosition.y);
	}
}