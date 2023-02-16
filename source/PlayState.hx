package;

import scripting.HScriptBase;

class PlayState extends BaseState {

	var script:HScriptBase;
	public static var instance:PlayState;
	override public function create() {
		instance = this;
		super.create();
		script = new HScriptBase("assets/scripts/test.hxs");
		script.call("create");
		script.call("postCreate");
	}

	override public function update(elapsed:Float) {
		script.call("update", [elapsed]);
		super.update(elapsed);
		script.call("postUpdate", [elapsed]);
	}
}
