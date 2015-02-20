// calculate circle x and y
// ****************************************************************************
function calculateTheta(data, index) {
  var scale = d3.scale.linear()
  .domain([0, data.length])
  .range([0, 2 * Math.PI]);
  return scale(index);
}

function calculateX(obj, index, radius, data) {
  var theta = calculateTheta(data, index);
  var x = (Diagram.width/2) + radius * Math.sin(theta);
  obj.x = x;
  return x;
}

function calculateY(obj, index, radius, data) {
  var theta = calculateTheta(data, index);
  var y = (Diagram.height/2) + radius * Math.cos(theta);
  obj.y = y;
  return y;
}


// build attribute text boxes
// ****************************************************************************
function parsePlugins(plugins, elem) {
  var $list = $(elem).append('<ul></ul>').find('ul');
  for (var i = 0; i < plugins.length; i++) {
    $list.append('<li>' + plugins[i] + '</li>');
  }
}

function formatFonts(list) {
  var formatted = '';

  for (var i = 0; i < list.length; i++) {
    formatted += list[i] + ', ';
  }

  return formatted;
}

function parseFonts(fontsObj, elem) {
  var $list = $(elem).append('<ul></ul>').find('ul');

  $list.append('<h4>' + 'installed fonts' + '</h4>');
  var installed = formatFonts(fontsObj.installed);
  $list.append('<li>' + installed +'</li>');

  var uninstalled = formatFonts(fontsObj.uninstalled);
  $list.append('<h4>' + 'uninstalled fonts' + '</h4>');
  $list.append('<li>' + uninstalled + '</li>');
}
