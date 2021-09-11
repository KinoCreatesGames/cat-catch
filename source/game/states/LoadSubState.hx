package game.states;

import game.ui.File;

class LoadSubState extends FileSubState {
	public var mouseCursor:FlxSprite;

	override public function create() {
		super.create();
		setupMouse();
	}

	override public function setTitleText() {
		titleText.text = 'Load';
		titleText.alignment = CENTER;
	}

	public function setupMouse() {
		mouseCursor = new FlxSprite(8, 8);
		mouseCursor.loadGraphic(AssetPaths.mouse_cursor__png, false, 8, 8,
			true);
		mouseCursor.animation.add('moving', [0], 0, true);
		FlxG.mouse.visible = false;
		add(mouseCursor);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMouse();
	}

	// Need to gather up and track game data
	override public function clickFile(file:File) {
		// Grab Load Save Data
		SaveLoad.Save.loadSaveData(file.saveID, (state) -> {
			var gameData = SaveLoad.Save.gameData;
			// gameData.days = state.days;
			gameData.gameTime = state.gameTime;
			// Set Player Stats
			// gameData.player = new Gal(0, 0, state.playerStats);
			// gameData.player.happiness = state.playerHappinessLvl;
			// gameData.player.affection = state.playerAffectionLvl;
			// Start loading into the  HubState
			FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
				close();
				// FlxG.camera.fade(KColor.BLACK, 1, true);
				FlxG.switchState(new PlayState());
			});
		});
	}

	public function updateMouse() {
		if (mouseCursor != null) {
			// mouseCursor.scrollFactor.set(0, 0);
			var mousePosition = FlxG.mouse.getPosition();
			mouseCursor.setPosition(mousePosition.x, mousePosition.y);
		}
	}
}