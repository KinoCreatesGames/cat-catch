package game.objects;

class Save extends Interactable {
	public function new(x:Float, y:Float) {
		super(x, y);
		loadGraphic(AssetPaths.save_bell__png, false, 24, 24, false);
	}
}