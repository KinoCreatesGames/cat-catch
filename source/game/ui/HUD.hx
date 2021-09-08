package game.ui;

import flixel.group.FlxSpriteGroup;

class HUD extends FlxSpriteGroup {
	public var player:Player;
	public var timerText:GText;
	public var stickIcon:FlxSprite;
	public var stickCountText:GText;
	public var catCountText:GText;

	public function new() {
		super();
	}

	// Creation function for holding all of the different UI elements in the game
	public function create() {
		createHealth();
		createCatCount();
		createTimer();
		createInventoryCount();
	}

	public function createHealth() {}

	/**
	 * Cat Count which will be received from the 
	 * level state and setup in LDTk, to determine how many cats are totalled in each level.
	 */
	public function createCatCount() {
		catCountText = new GText();
	}

	public function createTimer() {}

	public function createInventoryCount() {
		var width = FlxG.width;
		var padding = 16;
		var verticalPadding = 8;
		var spacing = 4;
		stickIcon = new FlxSprite(width - padding, verticalPadding);
		stickCountText = new GText();
		stickCountText.text = '${player.nipStickCount}';
		stickCountText.x = ((stickIcon.x - spacing) - stickCountText.width);
		add(stickIcon);
		add(stickCountText);
	}

	public function updateInventoryCount() {
		stickCountText.text = '${player.nipStickCount}';
	}
}