package game.char;

import flixel.math.FlxVector;
import game.objects.Capsule;
import flixel.FlxObject;
import flixel.math.FlxMath;

class Player extends Actor {
	public static inline var MOVE_SPEED:Int = 200;
	public static inline var GRAVITY:Float = 900;
	public static inline var JUMP_FORCE:Float = 500;
	public static inline var INVINCIBLE_TIME:Float = 1.5;
	public static inline var CAPSULE_SPEED:Float = 400;

	/**
	 * Time between each bullet, to prevent spamming
	 */
	public static inline var BULLET_CD:Float = 0.2;

	public static inline var STICK_CAP = 5;
	public static inline var HEALTH_CAP = 4;

	public var state:State;
	public var invincible:Bool;
	public var nipStickCount:Int;
	public var playerCapsuleGrp:FlxTypedGroup<Capsule>;
	public var bulletCD:Float = 0;

	public function new(x:Float, y:Float,
			capsuleGroup:FlxTypedGroup<Capsule>) {
		super(x, y, null);
		this.drag.x = 500;
		this.invincible = false;
		this.nipStickCount = 0;
		this.health = HEALTH_CAP;
		this.bulletCD = BULLET_CD;
		this.playerCapsuleGrp = capsuleGroup;
		setupBullets();
		FlxG.state.add(this.playerCapsuleGrp);
		makeGraphic(16, 16, KColor.BLUE, true);
	}

	public function setupBullets() {
		for (i in 0...playerCapsuleGrp.maxSize) {
			var capsule = new Capsule();
			capsule.kill();
			playerCapsuleGrp.add(capsule);
		}
	}

	override public function update(elapsed:Float) {
		updateMovement(elapsed);
		updateFiring(elapsed);
		super.update(elapsed);
		applyPhysics(elapsed);
	}

	public function updateFiring(elapsed:Float) {
		var fireButton = FlxG.keys.anyJustPressed([Z]);
		// Fire projectile when the firing button is pressed
		bulletCD -= elapsed;
		if (fireButton && bulletCD <= 0) {
			var capsule = playerCapsuleGrp.recycle();
			var fireVector = new FlxVector(this.velocity.x / this.velocity.x,
				0);
			var pos = this.getPosition();
			capsule.setPosition(pos.x, pos.y);
			capsule.facing = this.facing;
			capsule.velocity.x = fireVector.x * CAPSULE_SPEED;
			bulletCD = BULLET_CD;
		}
	}

	public function updateMovement(elapsed:Float) {
		var left = FlxG.keys.anyPressed([A, LEFT]);
		var right = FlxG.keys.anyPressed([D, RIGHT]);
		var up = FlxG.keys.anyJustPressed([W, UP]);

		if ((left || right || up)) {
			if (left) {
				velocity.x = -MOVE_SPEED;
			} else if (right) {
				velocity.x = MOVE_SPEED;
			}
			if (up) {
				if (this.isTouching(FlxObject.FLOOR)) {
					velocity.y -= JUMP_FORCE;
				}
			}
		}
	}

	public function applyPhysics(elapsed:Float) {
		acceleration.y = GRAVITY;
		// bound to the axis
	}

	public function addHealth(value:Int) {
		this.health = (this.health + value).clampf(0, HEALTH_CAP);
	}

	public function addStick(amount:Int) {
		this.nipStickCount = (this.nipStickCount + amount).clamp(0, STICK_CAP);
	}

	public function takeDamage(damage:Int) {
		this.health = (this.health - damage).clampf(0, HEALTH_CAP);
		FlxG.camera.shake(0.05, 0.05);
		this.invincible = true;
		this.flicker(INVINCIBLE_TIME, 0.04, true, false, (_) -> {
			this.invincible = false;
		});
	}
}