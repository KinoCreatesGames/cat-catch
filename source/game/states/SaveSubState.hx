package game.states;

import game.ui.File;

class SaveSubState extends FileSubState {
	public var mouseCursor:FlxSprite;

	override public function create() {
		super.create();
		setupMouse();
	}

	public function setupMouse() {
		mouseCursor = new FlxSprite(8, 8);
		mouseCursor.loadGraphic(AssetPaths.mouse_cursor__png, false, 8, 8,
			true);
		mouseCursor.animation.add('moving', [0], null, true);
		FlxG.mouse.visible = false;
		add(mouseCursor);
	}

	override public function setTitleText() {
		titleText.text = 'Save';
		titleText.alignment = CENTER;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMouse();
	}

	override public function clickFile(file:File) {
		var saveSlot = SaveLoad.Save.createSaveData(file.saveID);
		var currentData = SaveLoad.Save.gameData;
		// var player = currentData.player;
		// Update with additional information on other entities for the
		// game.
		var data:GameSaveState = {
			saveIndex: file.saveID,
			gameTime: currentData.gameTime,
			realTime: Date.now().getTime()
		};

		saveSlot.data.saveData = data;
		saveSlot.close();
		// Update File Properties
		file.realTime = data.realTime;
		file.gameTime = data.gameTime;
		file.updateSaveText();
	}

	public function updateMouse() {
		if (mouseCursor != null) {
			// mouseCursor.scrollFactor.set(0, 0);
			var mousePosition = FlxG.mouse.getPosition();
			mouseCursor.setPosition(mousePosition.x, mousePosition.y);
		}
	}
}