function create() {
    var e = new FlxSprite().makeGraphic(200, 200, 0xffffffff);
    e.screenCenter();
    add(e);
}