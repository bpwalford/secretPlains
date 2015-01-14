FingerPrinter = function(){

  fingerPrint = {}

  var pluginFinder = new PluginFinder;
  var plugins = pluginFinder.identify();
  fingerPrint['plugins'] = plugins

  var detective = new FontDetector();
  var fontMap = new Array();
  for(var i in window.fonts) {
    if (detective.detect(window.fonts[i]) == false) {
      fontMap.push(window.fonts[i] + "|false")
    } else {
      fontMap.push(window.fonts[i] + "|true")
    }
  }
  fingerPrint['fonts'] = fontMap

  var browserVersion = navigator.appVersion
  fingerPrint['version'] = browserVersion
  var cookies = navigator.cookieEnabled
  fingerPrint['cookies'] = cookies
  var language = navigator.language
  fingerPrint['language'] = language
  var userAgent = navigator.userAgent
  fingerPrint['agent'] = userAgent

  this.fingerPrint = fingerPrint
}
