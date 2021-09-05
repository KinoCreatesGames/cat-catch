package game.ext;

import flixel.FlxCamera;
import flixel.util.FlxAxes;

inline function screenCenterHorz(sprite:FlxSprite) {
	sprite.screenCenter(FlxAxes.X);
}

inline function cameraCenter(sprite:FlxSprite, ?camera:FlxCamera) {
	camera = camera == null ? sprite.camera : camera;
	sprite.cameraCenterHorz(camera);
	sprite.cameraCenterVert(camera);
}

inline function cameraCenterHorz(sprite:FlxSprite, ?camera:FlxCamera) {
	camera = camera == null ? sprite.camera : camera;
	sprite.x = ((camera.x + camera.width) / 2) - (sprite.width / 2);
}

inline function screenCenterVert(sprite:FlxSprite) {
	sprite.screenCenter(FlxAxes.Y);
}

inline function cameraCenterVert(sprite:FlxSprite, ?camera:FlxCamera) {
	camera = camera == null ? sprite.camera : camera;
	sprite.y = ((camera.y + camera.height) / 2) - (sprite.height / 2);
}

inline function drawBorder(sprite:FlxSprite, size:Float, color:FlxColor) {
	sprite.drawRect(0, 0, sprite.width, sprite.height, KColor.TRANSPARENT, {
		thickness: size,
		color: color,
	});
}