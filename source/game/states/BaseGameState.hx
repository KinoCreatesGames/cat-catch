package game.states;

import flixel.addons.display.FlxBackdrop;
import game.objects.Capsule;
import game.SceneUtils.gotoPause;
import game.shaders.OutlineShader;
import game.SceneUtils.gotoSave;
import game.objects.Interactable;
import game.objects.Save;
import game.objects.Collectible;
import game.objects.PawHeart;
import game.objects.NipStick;

class BaseGameState extends BaseLDTkState {
	// Groups
	public var currentInteractable:Interactable;

	override function create() {
		super.create();
	}

	override public function createEntities() {
		super.createEntities();
		spawnPlayer();
		spawnCollectibles();
		spawnInteractables();
		spawnEnemies();
	}

	override public function createLevelInformation() {
		createLevelMap();
	}

	public function spawnPlayer() {
		lvl.l_Entities.all_Player.iter((ePlayer) -> {
			var capsuleGroup = new FlxTypedGroup<Capsule>(50);
			player = new Player(ePlayer.pixelX, ePlayer.pixelY, capsuleGroup);
			entityGrp.add(player);
		});
		// Add camera to follow the player in this function
		FlxG.camera.follow(player, PLATFORMER);
	}

	public function spawnCollectibles() {
		lvl.l_Entities.all_Heart.iter((eHeart) -> {
			collectibleGrp.add(new PawHeart(eHeart.pixelX, eHeart.pixelY));
		});

		lvl.l_Entities.all_Stick.iter((eStick) -> {
			collectibleGrp.add(new NipStick(eStick.pixelX, eStick.pixelY));
		});
	}

	public function spawnInteractables() {
		lvl.l_Entities.all_Save.iter((eSave) -> {
			interactableGrp.add(new Save(eSave.pixelX, eSave.pixelY));
		});
	}

	public function spawnEnemies() {}

	override public function processCollision() {
		FlxG.overlap(player, collectibleGrp, playerTouchCollectible);
		var interactableOverlapped = FlxG.overlap(player, interactableGrp,
			playerTouchInteractable);
		if (!interactableOverlapped) {
			currentInteractable = null;
		}
		// Level collision
		FlxG.collide(player, lvlGrp);
		FlxG.worldBounds.set();
	}

	public function playerTouchCollectible(player:Player,
			collectible:Collectible) {
		var collectibleType = Type.getClass(collectible);
		switch (collectibleType) {
			case PawHeart:
				player.addHealth(1);
				collectible.kill();
			case NipStick:
				player.addStick(1);
				collectible.kill();
			case _:
				// Do nothing
		}
	}

	public function playerTouchInteractable(player:Player,
			interactable:Interactable) {
		var interactableType = Type.getClass(interactable);
		// Set up the interactable and update the shader
		if (currentInteractable == null) {
			currentInteractable = interactable;
			currentInteractable.shader = new OutlineShader();
		}
		switch (interactableType) {
			case Save:
				var actionButton = FlxG.keys.anyJustPressed([Z]);
				if (actionButton) {
					gotoSave(this);
				}
			case _:
				// Do nothing
		}
	}

	override public function processLevel(elapsed:Float) {
		processLevelStateChange(elapsed);
		// Interactable Updates
		updateCurrentInteractable(elapsed);
	}

	public function processLevelStateChange(elapsed:Float) {
		var pausePressed = FlxG.keys.anyJustPressed([P, ESCAPE]);
		if (pausePressed) {
			gotoPause(this);
		}
	}

	public function updateCurrentInteractable(elapsed:Float) {
		if (currentInteractable != null) {
			// Shader Update
			if (currentInteractable.shader != null) {
				var shaderType = Type.getClass(currentInteractable.shader);
				switch (shaderType) {
					case OutlineShader:
						var outlineShader:OutlineShader = cast currentInteractable.shader;
						outlineShader.update(elapsed);
					case _:
						// Do nothing
				}
			}
		}
	}
}