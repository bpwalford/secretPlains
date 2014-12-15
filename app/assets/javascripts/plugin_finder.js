// thank you to panopticlick for the sweet function
function identify_plugins(){
  var plugins = "";
  if (navigator.plugins) {
    var np = navigator.plugins;
    var plist = new Array();
    for (var i = 0; i < np.length; i++) {
      plist[i] = np[i].name + "; ";
      plist[i] += np[i].description + "; ";
      plist[i] += np[i].filename + ";";
      for (var n = 0; n < np[i].length; n++) {
        plist[i] += " (" + np[i][n].description +"; "+ np[i][n].type +
        "; "+ np[i][n].suffixes + ")";
      }
      plist[i] += ". ";
    }
    plist.sort();
    for (i = 0; i < np.length; i++) {
      plugins+= "Plugin "+i+": " + plist[i];
    }
  }
  if (plugins == "") {
    var pp = new Array();
    pp[0] = "Java"; pp[1] = "QuickTime"; pp[2] = "DevalVR"; pp[3] = "Shockwave";
    pp[4] = "Flash"; pp[5] = "WindowsMediaplayer"; pp[6] = "Silverlight";
    pp[7] = "VLC";
    var version;
    for ( p in pp ) {
      version = PluginDetect.getVersion(pp[p]);
      if (version)
        plugins += pp[p] + " " + version + "; "
    }
    plugins += ieAcrobatVersion();
  }
  return plugins;
}
