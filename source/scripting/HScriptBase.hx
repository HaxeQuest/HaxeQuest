package scripting;

import hscript.Interp;
import hscript.Parser;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;

class HScriptBase implements IFlxDestroyable {
    public function destroy() {
        interp = null;
        parser = null;
    }

    public final function set(k:String, v:Dynamic) {
        if (interp != null) interp.variables.set(k, v);
    }

    public final function get(k:String) {
        if (interp != null) return interp.variables.get(k);
        return null;
    }

    public final function call(e:String, m:Array<Dynamic> = null) {
        if (m == null) m = [];
        try {
            return interp.callMethod(e, m);
        } catch(e) {trace(e);}
        return null;
    }

    public final function doString(s:String) {
        if (interp != null) try {
            var e:hscript.Expr = parser.parseString(s);
            interp.execute(e);
        } catch(e:Dynamic) {openfl.Lib.application.window.alert(e, "HScript Error");}
    }

    public final function _trace(s:String) {
        var posInfos:haxe.PosInfos = interp.posInfos();
        Sys.println('${fileName}:${posInfos.lineNumber}: $s');
    }

    public var interp:Interp;
    public var parser:Parser;
    public var fileName:String;

    public function new(fileName:String) {
        interp = new Interp();
        parser = new Parser();
        this.fileName = fileName;
        initVariables();
        doString(sys.io.File.getContent(fileName));
    }

    public function initVariables() {
        set("math", Math);
        set("trace", _trace);
        set("add", PlayState.instance.add);
        set("remove", PlayState.instance.remove);
        set("insert", PlayState.instance.insert);
        set("state", flixel.FlxG.state);
    }
}