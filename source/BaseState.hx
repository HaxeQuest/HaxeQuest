package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class BaseState extends flixel.FlxState {
	private var showText:Bool;
	private var showBG:Bool;

	override public function new(showText:Bool = true, showBG:Bool = true) {
		this.showText = showText;
		this.showBG = showBG;
		super();
	}

	var txt:FlxText;
	var txt2:FlxText;
	var bg:FlxSprite;

	static inline final STATE_TXT_BODY = 'To hide this text, make sure your super call contains false as an argument.
    To hide the background, add another false to the arguments.';

	override public function create() {
		super.create();
		if (showBG) {
			bg = new FlxSprite().loadGraphic("assets/images/ui/BaseStateBG.png");
			add(bg);
		}
		if (showText) {
			txt = new FlxText(0, 0, FlxG.width, Type.getClassName(Type.getClass(this))).setFormat(null, 64, 0xffffffff, "center");
			txt.y = (FlxG.height / 2) - txt.height - 8;
			add(txt);
			txt2 = new FlxText(0, (FlxG.height / 2) + 8, FlxG.width, STATE_TXT_BODY).setFormat(null, 16, 0xffffffff, "center");
			add(txt2);
		}
	}
}
