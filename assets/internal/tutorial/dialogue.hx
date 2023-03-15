/**
    example of DialogueStuff:
    {
        text: "heyyyyy bae",
        speaker: "Narrator",
        callback: () -> {
            trace("This is a callback!");
        }
    }
**/

import flixel.FlxG;
import ui.DialogueBox;
import flixel.FlxSprite;

var importSprite:FlxSprite;
var black:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xff000000);

var dialogue;

function create() {
    dialogue = getDialogue();
    trace(dialogue);
}

function getDialogue() {
    black.visible = false;
    insert(state.members.indexOf(box), black);
    importSprite = new FlxSprite().loadGraphic("assets/images/tutorial/importExample.png");
    importSprite.screenCenter();
    importSprite.visible = false;
    add(importSprite);
    else if (DialogueBox.seenAmount > 0 && mainScript.interp.variables.exists("FlxSprite")) {
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
                var e = new FlxText(0, 10, FlxG.width, "End of demo!").setFormat(null, 32, 0xffffffff, "center");
                e.screenCenter();
                add(e);
                box.visible = false;
            }
        }];
    } else if (DialogueBox.seenAmount > 0) {
        return [{
            text: "Not quite! Remember, FlxSprite will need to be imported into the script file!\n'assets/scripts/tutorial/Script.hx'",
            speaker: "Narrator",
            callback: () -> { add(box.reloadButton); }
        }];
    }
    return [{
        text: "Welcome to Haxe Quest! Let's get started with our first lesson: imports.",
        speaker: "Narrator"
    }, {
        text: "Imports are incredibly important and will need to be placed at the top of a file before you can use whatever you're importing.",
        speaker: "Narrator",
    }, {
        text: "Here's an example of an import of FlxSprite, a very important class.",
        speaker: "Narrator",
        callback: () -> { importSprite.visible = true; }
    }, {
        text: "'flixel' is the package of the class. All package directories will need to be included, separated by dots.",
        speaker: "Narrator"
    }, {
        text: "Now it's time for you to try this out. There's supposed to be a square here... but there isn't."
        speaker: "Narrator",
        callback: () -> { importSprite.visible = false; }
    }, {
        text: "With what you can learned, you can fix this. Go to:\n'assets/scripts/tutorial/Script.hx'\nand see if you can fix it! Good luck!",
        speaker: "Narrator",
        callback: () -> 
    }];

}