package game.states;

class CreditsSubState extends FlxSubState {
	public var titleText:TitleText;
	public var creditsText:GText;

	override public function create() {
		createTitle();
		createCreditsText();
		super.create();
	}

	public function createTitle() {}

	public function createCreditsText() {}
}