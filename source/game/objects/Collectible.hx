package game.objects;

class Collectible extends FlxSprite {
	public static inline var VARIANCE:Float = 4.0;

	public var elapsedTime:Float;
	public var initialY:Float;

	public function new(x:Float, y:Float) {
		super(x, y);
		this.initialY = y;
		setSprite();
	}

	/**
	 * Used to setup the base sprite for the collectible.
	 */
	public function setSprite() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		waveBounce(elapsed);
	}

	public function waveBounce(elapsed:Float) {
		elapsedTime += elapsed;
		this.y = this.initialY + Math.sin(elapsedTime) * VARIANCE;
	}
}