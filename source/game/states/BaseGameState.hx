package game.states;

class BaseGameState extends BaseLDTkState {
	// Groups
	override public function processCollision() {
		FlxG.overlap(player, collectibleGrp, playerTouchCollectible);
	}

	public function playerTouchCollectible(player:Player,
			collectible:Collectible) {
		var collectibleType = Type.getClass(collectible);
		switch (collectibleType) {
			case PawHeart:
				player.addHealth(1);
				collectible.kill();
			case NipStick:
				player.addStick(1);
				collectible.kill();
			case _:
				// Do nothing
		}
	}

	override public function processLevel(elapsed:Float) {}
}