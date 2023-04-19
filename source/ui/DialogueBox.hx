package ui;

import flixel.input.actions.FlxAction;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import scripting.HScriptBase;
import flixel.FlxG;

class DialogueBox extends flixel.group.FlxGroup {
    var script:HScriptBase;
    var dialogueTxt:FlxText;
    var dialogueSprite:FlxSprite;
    var speakerText:FlxText;
    var dialogue:Array<DialogueStuff> = [];
    var reloadButton:FlxButton;
    var currentIndex:Int = 0;
    static var seenAmount:Int = 0;
    var loadedDialogue:Bool = false;
    var spaceToContinue:FlxText;
    public override function new() {
        super();
        dialogueSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * .75), Std.int(FlxG.height / 4), 0xff333333);
        dialogueSprite.screenCenter(X);
        dialogueSprite.y = FlxG.height - dialogueSprite.height;
        add(dialogueSprite);
        dialogueTxt = new FlxText(0, 0, dialogueSprite.width - 10, "");
        dialogueTxt.setFormat(null, 24, 0xffffffff, "center");
        dialogueTxt.screenCenter(X);
        dialogueTxt.y = dialogueSprite.y + 10;
        add(dialogueTxt);
        speakerText = new FlxText(0, 0, dialogueSprite.width - 10, "");
        speakerText.setFormat(null, 18, 0xffffffff, "center");
        speakerText.screenCenter(X);
        speakerText.y = dialogueSprite.y - 22;
        add(speakerText);
        spaceToContinue = new FlxText(0, 0, dialogueSprite.width - 10, "Press space to continue");
        spaceToContinue.setFormat(null, 18, 0xffffffff, "center");
        spaceToContinue.screenCenter(X);
        spaceToContinue.y = dialogueSprite.y + dialogueSprite.height - 22;
        add(spaceToContinue);
        reloadButton = new FlxButton(0, 10, "Reload", function() {
            FlxG.resetState();
        });
        reloadButton.screenCenter(X);
        script = new HScriptBase("assets/internal/tutorial/dialogue.hx");
        script.set("mainScript", PlayState.instance.script);
        script.set("box", this);
        script.interp.callMethod("create", []);
        dialogue = script.interp.variables["dialogue"];
        trace(dialogue);
        if (dialogue == null) {
            dialogue = getDialogue();
        }
        loadedDialogue = true;
        loadDialogue();
        seenAmount++;
    }

    public function loadDialogue() {
        if (loadedDialogue) {
            if (currentIndex >= dialogue.length) {
                visible = false;
                return;
            }
            var currentDialogue = dialogue[currentIndex];
            dialogueTxt.text = currentDialogue.text;
            speakerText.text = currentDialogue.speaker;
            if (currentDialogue.callback != null) {
                currentDialogue.callback();
            }
        }
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.SPACE) {
            currentIndex++;
            loadDialogue();
        }
    }
    var importSprite:FlxSprite;
    var black:FlxSprite;

    function getDialogue():Array<DialogueStuff> {
        black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xff000000);
        black.visible = false;
        insert(FlxG.state.members.indexOf(this), black);
        importSprite = new FlxSprite().loadGraphic("assets/images/tutorial/importExample.png");
        importSprite.screenCenter();
        importSprite.visible = false;
        add(importSprite);
        if (DialogueBox.seenAmount >= 3) importSprite.visible = true;
        if (DialogueBox.seenAmount > 0 && PlayState.instance.script.interp.variables.exists("FlxSprite")) {
            importSprite.visible = false;
            return [{
                text: "Great job! You've got the square to show up!",
                speaker: "Narrator",
                callback: () -> {}
            }, {
                text: "Unfortunately, that's the end for now, but I'm excited to see you for more soon!",
                speaker: "Narrator",
                callback: () -> { black.visible = true; }
            }, {
                text: "",
                speaker: "",
                callback: () -> { 
                    var b = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xff000000);
                    FlxG.state.add(b);
                    var e = new FlxText(0, 10, FlxG.width, "End of demo!").setFormat(null, 32, 0xffffffff, "center");
                    e.screenCenter();
                    FlxG.state.add(e);
                    visible = false;
                }
            }];
        } else if (DialogueBox.seenAmount > 0) {
            return [{
                text: "Not quite! Remember, FlxSprite will need to be imported into the script file with the proper package syntax!\n'assets/scripts/tutorial/Script.hx'",
                speaker: "Narrator",
                callback: () -> { 
                    PlayState.instance.add(reloadButton); 
                }
            }];
        }
        return [{
            text: "Welcome to Haxe Quest! Let's get started with our first lesson: imports.",
            speaker: "Narrator"
        }, {
            text: "Imports are incredibly important and will need to be placed at the top of a file before you can use whatever you're importing.",
            speaker: "Narrator",
        }, {
            text: "Here's an example of an import of FlxSprite, a very important class for drawing sprites to the screen.",
            speaker: "Narrator",
            callback: () -> { importSprite.visible = true; }
        }, {
            text: "'flixel' is the package of the class. All package directories will need to be included, separated by dots.",
            speaker: "Narrator"
        }, {
            text: "Now it's time for you to try this out. There's supposed to be a square here...\nbut there isn't.",
            speaker: "Narrator",
            callback: () -> { importSprite.visible = false; }
        }, {
            text: "With what you can learned, you can fix this. Open:\n'assets/scripts/tutorial/Script.hx'\nin your IDE and see if you can fix it! Hit the reload button when you're done. Good luck!",
            speaker: "Narrator",
            callback: () -> { PlayState.instance.add(reloadButton);}
        }];
    }
}

typedef DialogueStuff = {
    var text:String;
    var speaker:String;
    @:optional var callback:Null<Void->Void>;
}