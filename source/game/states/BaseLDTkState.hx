package game.states;

import game.objects.Interactable;
import groups.CollectibleGroup;
import flixel.group.FlxSpriteGroup;

class BaseLDTkState extends FlxState {
	public var completeLevel:Bool;
	public var gameOver:Bool;

	// Singular Entities
	public var player:Player;
	// Groups
	public var backgroundGrp:FlxSpriteGroup;
	public var lvlGrp:FlxSpriteGroup;
	public var decorationGrp:FlxSpriteGroup;
	public var collectibleGrp:CollectibleGroup;
	public var interactableGrp:FlxTypedGroup<Interactable>;
	public var enemyGrp:FlxTypedGroup<Enemy>;
	public var entityGrp:FlxTypedGroup<Actor>;
	public var doorGrp:FlxSpriteGroup;
	public var hazardGrp:FlxSpriteGroup;
	public var HUD:FlxSpriteGroup;

	public var project:ldtkData.LDTkProj;
	public var lvl:ldtkData.LDTkProj.LDTkProj_Level;

	override public function create() {
		super.create();
		project = Globals.ldtkProj;
		completeLevel = false;
		gameOver = false;
	}

	public function createLevel(?level:ldtkData.LDTkProj.LDTkProj_Level) {
		if (level != null) {
			lvl = level;
		}

		createGroups();
		createLevelInformation();
		createEntities();
		createUI();
		addGroups();
	}

	public function createEntities() {}

	/**
		* Creates the groups that are being used on the level
				* ```haxe
		 enemyGrp = new FlxTypedGroup<Enemy>();
		 levelGrp = new FlxTypedGroup<FlxTilemap>();
		 decorationGrp = new FlxTypedGroup<FlxTilemap>();
				* ```
	 */
	public function createGroups() {
		enemyGrp = new FlxTypedGroup<Enemy>();
		lvlGrp = new FlxSpriteGroup();
		decorationGrp = new FlxSpriteGroup();
		hazardGrp = new FlxSpriteGroup();
		backgroundGrp = new FlxSpriteGroup();
		doorGrp = new FlxSpriteGroup();
		entityGrp = new FlxTypedGroup<Actor>();
		collectibleGrp = new CollectibleGroup();
		interactableGrp = new FlxTypedGroup<Interactable>();
	}

	/**
	 * Creates the level information for the level, including
	 		* the actual tiled level map.
	 */
	public function createLevelInformation() {
		// createLevelMap -- use this to create your level
		// Additional Elements Below UI
	}

	public function createLevelMap() {
		createBackgroundLayer();
		createLevelLayer();
	}

	/**
	 * Creates the background layer with no collision detection.
	 */
	public function createBackgroundLayer() {
		lvl.l_Background.render(backgroundGrp);
		// Tint Background
		backgroundGrp.color = 0xF0C0C0C0;
	}

	/**
	 * Creates the level with collision detection.
	 */
	public function createLevelLayer() {
		lvl.l_Level.render(lvlGrp);
		lvl.l_AutoTiles.render(lvlGrp);
		lvlGrp.members.iter((tile) -> {
			var gridSize = lvl.l_AutoTiles.gridSize;
			tile.width = gridSize;
			tile.height = gridSize;
		});
		lvlGrp.solid = true;
		lvlGrp.immovable = true;
	}

	/**
	 * Function for creating the UI for the game.
	 */
	public function createUI() {}

	/**
		* Add additional groups to your tiled map
		* 
		* ```haxe
			add(lvlGrp);
			add(decorationGrp);
			add(enemyGrp);
			* ```
	 */
	public function addGroups() {
		add(backgroundGrp);
		add(lvlGrp);
		add(decorationGrp);
		add(hazardGrp);
		add(doorGrp);
		add(interactableGrp);
		add(enemyGrp);
		add(entityGrp);
		add(collectibleGrp);
		add(HUD);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		// Add process for any tile information
		processCollision();
		processLevel(elapsed);
	}

	/**
	 * Used for handling any collisions within the level.
	 */
	public function processCollision() {}

	/**
	 * Used for any processing of the level in the update function.
	 * @param elapsed 
	 */
	public function processLevel(elapsed:Float) {}
}