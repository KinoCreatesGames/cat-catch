package game.states;

import game.objects.Save;
import game.objects.Collectible;
import game.objects.PawHeart;
import game.objects.NipStick;

class BaseGameState extends BaseLDTkState {
	// Groups
	override public function createEntities() {}

	public function spawnPlayer() {}

	public function spawnCollectibles() {}

	public function spawnInteractables() {
		lvl.l_Entities.all_Save.iter((eSave) -> {
			interactableGrp.add(new Save(eSave.pixelX, eSave.pixelY));
		});
	}

	public function spawnEnemies() {}

	override public function processCollision() {
		FlxG.overlap(player, collectibleGrp, playerTouchCollectible);

		// Level collision
		FlxG.overlap(player, lvlGrp);
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