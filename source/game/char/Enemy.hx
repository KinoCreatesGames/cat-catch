package game.char;

import flixel.FlxObject;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Enemy extends game.char.Actor {
	public var walkPath:Array<FlxPoint>;
	public var points:Int;
	public var ai:State;
	public var player:Player;
	public var range:Float;
	public var leashRange:Float;

	public static inline var HIT_TIME:Float = 0.5;
	public static inline var KNOCKBACK_FORCE:Float = 1000;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			monsterData:MonsterData) {
		super(x, y, monsterData);
		walkPath = path;
		points = monsterData.points;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMovement(elapsed);
	}

	public function updateMovement(elapsed:Float) {}

	public function idle(elapsed) {}

	public function playerInRange():Bool {
		var currPlayer = null;
		if (player != null) {
			if (player.getMidpoint().distanceTo(this.getMidpoint()) < range
				&& player.alive) {
				currPlayer = player;
			}
		}
		return currPlayer != null ? true : false;
	}

	public function playerInLeashRange():Bool {
		var currPlayer = null;
		if (player != null) {
			if (player.getMidpoint().distanceTo(this.getMidpoint()) < leashRange
				&& player.alive) {
				currPlayer = player;
			}
		}
		return currPlayer != null ? true : false;
	}

	public function knockback(facing:Int) {
		var angle = FlxAngle.angleFromFacing(facing);
		var vel = FlxPoint.get(FlxMath.fastCos(angle) * KNOCKBACK_FORCE,
			FlxMath.fastSin(angle) * KNOCKBACK_FORCE);
		vel.x = vel.x * -1;
		vel.y = vel.y * -1;
		switch (facing) {
			case FlxObject.LEFT:
			// var vel = FlxVelocity.velocityFromFacing(this, this.spd * 2);
			// this.velocity.subtractPoint(vel);
			case FlxObject.RIGHT:

			case FlxObject.UP:

			case FlxObject.DOWN:
		}

		this.velocity.subtractPoint(vel);
	}

	public function updateFacingRelationToPoint(point:FlxPoint) {
		var copy = point.copyTo(FlxPoint.weak(0, 0));
		var heightDiff = 30;
		var diffPoint = copy.subtractPoint(this.getPosition());
		var left = diffPoint.x < 0;
		var right = diffPoint.x > 0;
		var up = diffPoint.y < heightDiff.negate();
		var down = diffPoint.y > heightDiff;
		if (up) {
			facing = FlxObject.UP;
		} else if (down) {
			facing = FlxObject.DOWN;
		} else if (left) {
			facing = FlxObject.LEFT;
		} else if (right) {
			facing = FlxObject.RIGHT;
		}
	}
}