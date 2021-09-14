package game.objects;

// This class is the capsule the cats will be put into when they are touched by the player bullet
class Capsule extends FlxSprite {
	// Alive time, once this is over we kill the bullet and must be reset upon firing the element
	public static inline var CAPSULE_TIME:Float = 0.5;

	public var capsuleTimer:Float = 0.5;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		this.angle = 0;
		loadGraphic(AssetPaths.cat_capsule__png);
	}

	override public function update(elapsed) {
		super.update(elapsed);
		this.angle += elapsed;
		capsuleTimer -= elapsed;
		if (capsuleTimer < 0) {
			this.kill();
		}
	}
}