package game.objects;

class CatCapAnim extends FlxSprite {
	public function new(x:Float, y:Float) {
		super(x, y);
		loadGraphic(AssetPaths.cat_cap_animation__png, true, 16, 16, true);
		animation.add('capture', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12,
			false);
		animation.finishCallback = (animName:String) -> {
			if (animName == 'capture') {
				this.kill();
			}
		};
		animation.play('capture');
	}
}