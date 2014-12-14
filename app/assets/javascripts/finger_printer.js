

var Detector = function() {
  var baseFonts = ['monospace', 'sans-serif', 'serif'];
  var testString = "mmmmmmmmmmlli";
  var testSize = '72px';
  var h = document.getElementsByTagName("body")[0];

  var s = document.createElement("span");
  s.style.fontSize = testSize;
  s.innerHTML = testString;
  var defaultWidth = {};
  var defaultHeight = {};
  for (var index in baseFonts) {
    s.style.fontFamily = baseFonts[index];
    h.appendChild(s);
    defaultWidth[baseFonts[index]] = s.offsetWidth;
    defaultHeight[baseFonts[index]] = s.offsetHeight;
    h.removeChild(s);
  }

  function detect(font) {
    var detected = false;
    for (var index in baseFonts) {
      s.style.fontFamily = font + ',' + baseFonts[index];
      h.appendChild(s);
      var matched = (s.offsetWidth != defaultWidth[baseFonts[index]] || s.offsetHeight != defaultHeight[baseFonts[index]]);
      h.removeChild(s);
      detected = detected || matched;
    }
    return detected;
  }

  this.detect = detect;
};

// ************************************************************************

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
// ************************************************************************

var browserPlugins = identify_plugins();

var detective = new Detector();
var fontDict = new Array();
var installedFonts = 0;
var uninstalledFonts = 0;

for(var i in window.fonts) {
  if (detective.detect(window.fonts[i]) == false) {
    fontDict.push(window.fonts[i] + " false")
    installedFonts ++;
  } else {
    fontDict.push(window.fonts[i] + " true")
    uninstalledFonts ++;
  }
}
    document.write(window.fonts)
    // document.write("browser is: " + navigator.appName);
    // document.write("browser version: " + navigator.appVersion);
    // document.write("cookies enabled?: " + navigator.cookieEnabled);
    // document.write("language?: " + navigator.language);
    // document.write("cookies enabled?: " + navigator.cookieEnabled);
    // document.write(installedFonts + " fonts installed");
    // document.write(uninstalledFonts + " fonts not installed");
    // document.write(browserPlugins.length + " characters in plugin string");
    // var browserPluginsSpaces = browserPlugins.split(" ");
    // document.write(browserPluginsSpaces.length + " spaces in plugin string");
    // document.write("user agent is: " + navigator.userAgent);
    //
    // document.write(browserPlugins);
    // for (var i = 0; i < navigator.plugins.length; i++) {
    //   document.write(navigator.plugins[i])
    // }
