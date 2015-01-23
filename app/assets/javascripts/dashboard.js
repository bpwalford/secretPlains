'use strict';

$.get('/user_fingerprint')
  .then(function(json) {

// data and constants
// **************************************************************************
  var data = [
    {type: 'cookies',         class: 'cookies',         val: json.cookies},
    {type: 'plugins',         class: 'plugins',         val: json.plugins},
    {type: 'country',         class: 'country',         val: json.country},
    {type: 'ip',              class: 'ip',              val: json.ip},
    {type: 'fonts',           class: 'fonts',           val: json.fonts},
    {type: 'language',        class: 'language',        val: json.language},
    {type: 'screen size',     class: 'screen-size',     val: json.screen},
    {type: 'browser version', class: 'browser-version', val: json.browser_version},
    {type: 'user agent',      class: 'user-agent',      val: json.user_agent},
  ]

  var small  = 60;
  var big    = 100;
  var width  = '1100';
  var height = '570';
  var radius = '210';
  var font = '15';


// calculate node placement
// **************************************************************************
  function calculateTheta(i) {
    var scale = d3.scale.linear()
      .domain([0, data.length])
      .range([0, 2 * Math.PI]);
    return scale(i);
  }

  function calculateX(d, i, r) {
    var theta = calculateTheta(i);
    var x = (width/2) + r * Math.sin(theta);
    d.x = x;
    return x;
  }

  function calculateY(d, i, r) {
    var theta = calculateTheta(i);
    var y = (height/2) + r * Math.cos(theta);
    d.y = y;
    return y;
  }


// collapse and inflate full print sequences
// **************************************************************************
  function collapseNodes(c){
    svg.selectAll('.small')
      .transition()
      .attr('r', '0');

    svg.selectAll('text')
      .transition()
      .attr('font-size', '0');

    svg.selectAll('line')
      .transition()
      .attr('opacity', '0');

    svg.selectAll('.fingerprint-image')
      .transition()
      .delay(300)
      .attr('x', width - 144)
      .attr('y', 100 - 39);

    d3.selectAll('.' + c)
      .transition()
      .delay(600)
      .style('display', 'block');
  }

  function inflateNodes(c) {
    svg.selectAll('.small')
      .transition()
      .delay(300)
      .attr('r', small);

    svg.selectAll('text')
      .transition()
      .delay(300)
      .attr('font-size', font);

    svg.selectAll('line')
      .transition()
      .delay(300)
      .attr('opacity', '1');

    svg.selectAll('.fingerprint-image')
      .transition()
      .attr('x', width - 69)
      .attr('y', '0');

    d3.selectAll('.' + c)
      .style('display', 'none');
  }


// draw canvas
// **************************************************************************
  var svg = d3.select('#fingerprint')
    .append('svg')
    .attr('width', width)
    .attr('height', height);


// drop shadow filter
// **************************************************************************
  var defs = svg.append("defs");

  var filter = defs.append("filter")
  .attr("id", "dropshadow")

  filter.append("feGaussianBlur")
  .attr("in", "SourceAlpha")
  .attr("stdDeviation", 4)
  .attr("result", "blur");
  filter.append("feOffset")
  .attr("in", "blur")
  .attr("dx", 2)
  .attr("dy", 2)
  .attr("result", "offsetBlur");

  var feMerge = filter.append("feMerge");

  feMerge.append("feMergeNode")
  .attr("in", "offsetBlur")
  feMerge.append("feMergeNode")
  .attr("in", "SourceGraphic");


// draw daigram elements
// **************************************************************************
  var lines = svg.selectAll('line')
    .data(data)
    .enter()
    .append('line');

  var circles = svg.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')

  var fingerprintImage = svg.append('svg:image')

  var labels = svg.selectAll('text')
    .data(data)
    .enter()
    .append('text')
    .text(function(d) { return d.type });


// add attributes to svg elements
// **************************************************************************
  circles.attr({
    'cx': function(d, i) { return calculateX(d, i, radius); },
    'cy': function(d, i) { return calculateY(d, i, radius); },
    'r': small,
    'class': 'small',
    'fill': 'rgb(103, 175, 233)',
    'filter': 'url(#dropshadow)',
  });

  fingerprintImage.attr({
    'xlink:href': '/assets/images/fingerprint.png',
    'height': '96',
    'width': '69',
    'x': width - 69,
    'y': '0',
    'class': 'fingerprint-image',
  });

  lines.attr({
    'stroke': 'rgb(103, 175, 233)',
    'stroke-width': '1',
    'x1': width - 34,
    'y1': '49',
    'x2': function(d) { return d.x; },
    'y2': function(d) { return d.y; },
  });

  labels.attr({
    'x': function(d) {
      var attrs = d3.select(this).node().getBBox();
      return d.x - attrs.width/2 - 3;
    },
    'y': function(d) {
      var attrs = d3.select(this).node().getBBox();
      return d.y + attrs.height/2 - 3;
    },
    'font-size': font,
    'fill': 'gray'
  });


// circle event listeners
// **************************************************************************
  circles.on('click', function(d) {
    d3.select(this)
      .attr('class', (this.classList[0] === 'big' ? 'small' : 'big'));
    if (this.classList[0] === 'big') {
      collapseNodes(d.class);
      d3.select(this)
        .transition()
        .delay(300)
        .attr('cx', width - 110)
        .attr('cy', 110)
        .attr('r', big);
    } else {
      inflateNodes(d.class);
      d3.select(this)
        .transition()
        .attr('r', small)
        .attr('cx', function(d) { return d.x })
        .attr('cy', function(d) { return d.y });
    }
  })

  circles.on('mouseover', function() {
    d3.select(this)
      .transition()
      .attr('opacity', '0.7');
  });

  circles.on('mouseout',  function() {
    d3.select(this)
      .transition()
      .attr('opacity', '1');
  });

// Text Boxes
// **************************************************************************
  function parsePlugins(plugins, elem) {
    var $list = $(elem).append('<ul></ul>').find('ul');
    for (var i = 0; i < plugins.length; i++) {
      $list.append('<li>' + plugins[i] + '</li>')
    }
  }

  function parseFonts(fontsObj, elem) {
    var $list = $(elem).append('<ul></ul>').find('ul');
    var $inLi = $list.append('<li>' + fontsObj.installed +'</li>');
    var $unLi = $list.append('<li>' + fontsObj.uninstalled + '</li>');
  }

  // create attribute div
  d3.select('.attributes').selectAll('div')
    .data(data)
    .enter()
    .append('div')
    .attr('class', function(d) { return d.class + ' attribute'; });

  var attrList = $('.attribute')

  // create attribute title
  d3.select('.labels').selectAll('div')
    .data(data)
    .enter()
    .append('div')
    .attr('class', function(d) { return d.class + ' label'; });

  var labelList = $('.label')

  // **** this works b/c attrList and data are in the same order **** //
  for (var i = 0; i < data.length; i++) {
    var elem = attrList[i];
    var datum = data[i].val;

    if (data[i].type === 'plugins') {
      parsePlugins(datum, elem);
    } else if (data[i].type === 'fonts') {
      parseFonts(datum, elem);
    } else {
      $(elem).text(datum);
    }

    $(labelList[i]).text(data[i].type)
  }
});

// style print attributes
// write descriptions (not sure where to put those)
// fix navbar for login users
// fix difference calculations
// build comparing interface
// add ui nav buttons
// build graphing interface
