package game.char;

import flixel.math.FlxVelocity;
import flixel.util.FlxPath;

class Cat extends Enemy {
	public static inline var LEASH_RANGE:Float = 250;
	public static inline var DETECTION_RANGE:Float = 120;

	public var catType:CatType;

	public var attackMode:Bool;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			catType:CatType) {
		super(x, y, path, null);
		this.path = new FlxPath(walkPath);
		this.spd = 40;
		this.range = DETECTION_RANGE;
		this.leashRange = LEASH_RANGE;
		this.catType = catType;
		this.attackMode = false;
		this.path.start(null, spd, FlxPath.LOOP_FORWARD);
		makeGraphic(16, 16, KColor.WINTER_SKY);
	}

	override public function idle(elapsed:Float) {
		if (playerInRange()) {
			this.path.cancel();
			ai.currentState = nextIdleState();
		} else {
			var currentPoint = this.path.activePathNode();
			updateFacingRelationToPoint(currentPoint);
		}
	}

	public function nextIdleState() {
		return switch (catType) {
			case Passive:
				runAway;
			case Aggressive:
				attacking;
			case EscapeArtist:
				hide;
			case Glutton:
				gluttonRun;
			case Kind:
				approach;
		}
	}

	public function gluttonRun(elapsed:Float) {
		if (playerInLeashRange()) {
			// Run in the opposite direction
			var oppositePoint = player.getMidpoint().copyTo(new FlxPoint(0, 0));
			oppositePoint.x = oppositePoint.x.negatef();
			FlxVelocity.moveTowardsPoint(this, oppositePoint, spd);
			updateFacingRelationToPoint(oppositePoint);
		} else {
			// Return to the original path position
			returnToIdle();
		}
	}

	public function runAway(elapsed:Float) {
		if (playerInLeashRange()) {
			// Run in the opposite direction
			var oppositePoint = player.getMidpoint().copyTo(new FlxPoint(0, 0));
			oppositePoint.x = oppositePoint.x.negatef();
			FlxVelocity.moveTowardsPoint(this, oppositePoint, spd);
			updateFacingRelationToPoint(oppositePoint);
		} else {
			// Return to the original path position
			returnToIdle();
		}
	}

	public function hide(elapsed:Float) {
		if (playerInLeashRange()) {
			// Run in the opposite direction
			var oppositePoint = player.getMidpoint().copyTo(new FlxPoint(0, 0));
			oppositePoint.x = oppositePoint.x.negatef();
			FlxVelocity.moveTowardsPoint(this, oppositePoint, spd);
			updateFacingRelationToPoint(oppositePoint);
		} else {
			// Return to the original path position
			returnToIdle();
		}
	}

	public function approach(elapsed:Float) {
		if (playerInRange()) {
			FlxVelocity.moveTowardsObject(this, player, spd);
			updateFacingRelationToPoint(player.getPosition());
		} else {
			returnToIdle();
		}
	}

	public function attacking(elapsed:Float) {
		if (playerInLeashRange()) {
			// Also will have an attack hitbox
			FlxVelocity.moveTowardsObject(this, player, spd);
			updateFacingRelationToPoint(player.getPosition());
		} else {
			returnToIdle();
		}
	}

	public function returnToIdle() {
		this.path.start(walkPath, spd, FlxPath.LOOP_FORWARD);
		ai.currentState = idle;
	}
}