function buildAndRun() {
    trace("Building...");
    Sys.setCwd(currentPath);
    var p = new Process("lime", ["build", "neko"]);
    p.close();
    trace("Running...");
    var pe = new Process("lime", ["run", "neko"]);
    pe.close();
}