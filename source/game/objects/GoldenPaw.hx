package game.objects;

class GoldenPaw extends Collectible {
	override public function setSprite() {
		loadGraphic(AssetPaths.super_print_two__png, false, 16, 16);
	}
}