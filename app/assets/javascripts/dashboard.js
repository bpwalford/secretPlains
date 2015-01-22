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
  var width  = '570';
  var height = '570';
  var radius = '210';


// calculate node placement
// **************************************************************************
  function calculateTheta(i) {
    var scale = d3.scale.linear()
      .domain([0, data.length])
      .range([0, 2 * Math.PI]);
    return scale(i);
  }

  function calculateX(d, i) {
    var theta = calculateTheta(i);
    var x = (width/2) + radius * Math.sin(theta);
    d.x = x;
    return x;
  }

  function calculateY(d, i) {
    var theta = calculateTheta(i);
    var y = (height/2) + radius * Math.cos(theta);
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
      .attr('font-size', '0')

    svg.selectAll('line')
      .transition()
      .attr('opacity', '0')

    svg.selectAll('.fingerprint-image')
      .transition()
      .attr('x', 100 - 34)
      .attr('y', 100 - 49)

    d3.selectAll('.' + c)
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
      .attr('font-size', '15')

    svg.selectAll('line')
      .transition()
      .delay(300)
      .attr('opacity', '1')

    svg.selectAll('.fingerprint-image')
      .transition()
      .attr('x', width/2 - 34)
      .attr('y', height/2 - 49)

    d3.selectAll('.' + c)
      .style('display', 'none');
  }


// onload fingerprint defaults and styles
// **************************************************************************
  var svg = d3.select('#fingerprint')
    .append('svg')
    .attr('width', width)
    .attr('height', height);

  // Nodes
  // *********************************
  var circles = svg.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')

  circles.attr('cx', function(d, i) { return calculateX(d, i); })
         .attr('cy', function(d, i) { return calculateY(d, i); })
         .attr('r', small)
         .attr('class', 'small')
         .attr('fill', 'rgb(103, 175, 233)')

  // Fingerprint Image
  // *********************************
  var fingerprintImage = svg.append('svg:image')
    .attr('xlink:href', '/assets/fingerprint.png')
    .attr('height', '96')
    .attr('width', '69')
    .attr('x', width/2 - 34)
    .attr('y', height/2 - 49)
    .attr('class', 'fingerprint-image');

  // Lines
  // *********************************
  var lines = svg.selectAll('line')
    .data(data)
    .enter()
    .append('line');

  lines.attr('stroke', 'rgb(103, 175, 233)')
       .attr('stroke-width', '1')
       .attr('x1', width/2)
       .attr('y1', height/2)
       .attr('x2', function(d) { return d.x; })
       .attr('y2', function(d) { return d.y; })


  // Labels
  // *********************************
  var labels = svg.selectAll('text')
    .data(data)
    .enter()
    .append('text')
    .text(function(d) { return d.type });

  labels.attr('x', function(d) { return d.x - ((small/2) + 20)})
        .attr('y', function(d) { return d.y + 3 })
        .attr('font-size', '15')
        .attr('fill', 'silver');


// Click events
// **************************************************************************
  circles.on('click', function(d) {
    d3.select(this)
      .attr('class', (this.classList[0] === 'big' ? 'small' : 'big'));
    if (this.classList[0] === 'big') {
      collapseNodes(d.class);
      d3.select(this)
        .transition()
        .delay(300)
        .attr('cx', 100)
        .attr('cy', 100)
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

//Text Boxes
// **************************************************************************
  d3.select('.attributes').selectAll('div')
    .data(data)
    .enter()
    .append('div')
    .attr('class', function(d) { return d.class + ' attribute'; })

  var foo = $('.attribute')

  for (var i = 0; i < data.length; i++) {
    $(foo[i]).text(data[i].val);
  }

});




// center bubble labels
// draft bubble contents
