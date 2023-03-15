package;

import sys.io.File;
import ui.DialogueBox;
import scripting.HScriptBase;

class PlayState extends BaseState {

	public var script:HScriptBase;
	public static var instance:PlayState;
	var box:DialogueBox;
	override public function new() super(false);
	override public function create() {
		instance = this;
		super.create();
		if (@:privateAccess DialogueBox.seenAmount == 0) {
			File.saveContent("assets/scripts/tutorial/Script.hx", 'function create() {
	var e = new FlxSprite().makeGraphic(200, 200, 0xffffffff);
	e.screenCenter();
	add(e);
}');
		}
		script = new HScriptBase("assets/scripts/tutorial/Script.hx");
		script.call("create");
		add(box = new DialogueBox());
	}

	override public function update(elapsed:Float) {
		script.call("update", [elapsed]);
		super.update(elapsed);
	}
}
