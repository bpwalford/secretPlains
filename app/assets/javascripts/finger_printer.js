// $(document).ready(function() {

  // find browser plugins
  var finder = new PluginFinder();
  var plugins = PluginFinder.identify_plugins;

  // find fonts
  var detective = new FontDetector();
  var fontDict = new Array();
  var installedFonts = 0;
  var uninstalledFonts = 0;

  for(var i in window.fonts) {
    if (detective.detect(window.fonts[i]) == false) {
      fontDict.push(window.fonts[i] + " false")
      // installedFonts ++;
    } else {
      fontDict.push(window.fonts[i] + " true")
      // uninstalledFonts ++;
    }
  }

  // easily attainable browser attributes
  var browserVersion = navigator.appVersion

  var cookies = navigator.cookieEnabled

  var language = navigator.language

  // var pluginChars =  plugins.length

  // var pluginsSpaces = plugins.split(" ").length

  var userAgent = navigator.userAgent

// )};
