package game.states;

import game.ui.File;

class FileSubState extends FlxSubState {
	public var titleText:FlxText;
	public var fileSprites:Array<File>;
	public var backButton:FlxButton;

	private var save:FlxSave;

	override public function create() {
		fileSprites = [];
		createTitleText();
		createBackButton();
		createFileList();
		super.create();
	}

	public function createTitleText() {
		titleText = new FlxText(0, 40, -1, '', Globals.FONT_L);
		titleText.screenCenterHorz();
		add(titleText);
	}

	public function createBackButton() {
		backButton = new FlxButton(20, 20, Globals.TEXT_BACK, clickBack);
		add(backButton);
	}

	public function setTitleText() {
		titleText.text = '';
	}

	public function createFileList() {}

	public function clickFile(file:File) {}

	public function clickBack() {
		// Should'nt be saving here, should be saving onClick
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.camera.fade(KColor.BLACK, 1, true);
		});
	}
}