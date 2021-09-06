package game.objects;

class PawHeart extends Collectible {
	override public function setSprite() {
		loadGraphic(AssetPaths.pawheart__png, false, 8, 8, false);
	}
}