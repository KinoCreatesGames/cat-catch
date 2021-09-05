package game;

import game.states.PlayState;
import game.states.PauseSubState;
import game.states.SettingsSubState;
import game.states.LoadSubState;
import game.states.ThankYouState;
import game.states.SaveSubState;

function gotoSave(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		state.openSubState(new SaveSubState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoFirstLevel(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		FlxG.switchState(new PlayState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoOptions(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		state.openSubState(new SettingsSubState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoPause(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		state.openSubState(new PauseSubState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoCredits(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		state.openSubState(new SaveSubState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoLoad(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		state.openSubState(new LoadSubState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}

function gotoThankYou(state:FlxState) {
	FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
		FlxG.switchState(new ThankYouState());
		FlxG.camera.fade(KColor.BLACK, 1, true);
	});
}