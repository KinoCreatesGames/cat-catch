package game;

import flixel.FlxBasic;
import game.states.CutSceneState.TextSpeed as TxtSpd;

/**
 * Data Plugin for handling saving settings and file data
 * for the game.
 */
class DataPlugin extends FlxBasic {
	/**
	 * Current Game State Information for passing to save files
	 */
	public var gameData:GameState;

	public static inline var SAVE_SETTINGS = 'SprocketSettings';
	public static inline var SAVE_DATA_PREFIX = 'SprocketData';
	public static var Save(get, null):DataPlugin;

	public var TextSpeed(get, null):Float;
	public var TextMode(get, null):String;
	public var SkipMiniGames(get, null):Bool;

	public static function initializeSave() {
		var save = new DataPlugin();
		save.gameData = {
			gameTime: 0,
		};
		FlxG.plugins.list.push(save);
	};

	public static function get_Save():DataPlugin {
		return cast(FlxG.plugins.get(DataPlugin), DataPlugin);
	}

	public function get_TextSpeed():Float {
		var save = createSaveSettings();
		var modeText = save.data.textMode;
		return switch (modeText) {
			case 'Normal':
				TxtSpd.NORMAL;
			case 'Fast':
				TxtSpd.FAST;
			case 'Slow':
				TxtSpd.SLOW;
			case _:
				TxtSpd.NORMAL;
		}
		save.close();
	}

	public function get_TextMode():String {
		var save = createSaveSettings();
		var modeText = save.data.textMode;
		save.close();
		return modeText;
	}

	public function get_SkipMiniGames() {
		var save = createSaveSettings();
		var skipMiniGames = save.data.skipMiniGames;
		save.close();
		return skipMiniGames;
	}

	public function createSaveSettings():FlxSave {
		var save = new FlxSave();
		save.bind(SAVE_SETTINGS);
		return save;
	}

	public function loadSettings() {
		// Saves The Options For The Game
		var save = createSaveSettings();
		// Set Volume
		if (save.data.volume != null) {
			FlxG.sound.volume = save.data.volume;
		}
		// Set Skip Mini Games
		if (save.data.skipMiniGames != null) {}
		// Set Text Speed Mode
		if (save.data.textMode == null) {
			save.data.textMode = 'Normal';
		}
		save.close();
	}

	public function createSaveData(saveId:Int):FlxSave {
		var save = new FlxSave();
		save.bind(SAVE_DATA_PREFIX + saveId);
		return save;
	}

	public function createLoadSaveData(saveId:Int):FlxSave {
		return createSaveData(saveId);
	}

	/**
	 * Returns the loaded save file.
	 * Accessing it via your fn
	 * and close the file after loading complete.
	 * @param saveId
	 * @return FlxSave
	 */
	public function loadSaveData(saveId:Int, loadFn:GameSaveState -> Void) {
		var save = createSaveData(saveId);
		var data:GameSaveState = save.data.saveData;
		loadFn(data);
		save.close();
	}
}
