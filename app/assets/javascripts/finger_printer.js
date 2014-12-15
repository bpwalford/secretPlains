// get plugins
var pluginFinder = new PluginFinder;
var plugins = pluginFinder.identify();

// get fonts
var detective = new FontDetector();
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

// get other brower attributes
var browserVersion = navigator.appVersion
var cookies = navigator.cookieEnabled
var language = navigator.language
var userAgent = navigator.userAgent
// var pluginChars =  browserPlugins.length
// var pluginsSpaces = plugins.split(" ").length
