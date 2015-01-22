'use strict';

$.get('/user_fingerprint')
  .then(function(json) {

  var data = [
    {type: 'cookies', val: json.cookies},
    {type: 'plugins', val: json.plugins},
    {type: 'country', val: json.country},
    {type: 'ip', val: json.ip},
    {type: 'fonts', val: json.fonts},
    {type: 'language', val: json.language},
    {type: 'screen size', val: json.screen},
    {type: 'browser version', val: json.browser_version},
    {type: 'user agent', val: json.user_agent},
  ]

  var small  = 60;
  var big    = 200;
  var width  = '570';
  var height = '570';
  var radius = '210';
  // var small  = 70;
  // var big    = 300;
  // var width  = '1110';
  // var height = '700';
  // var radius = '250';


  // calculate node placement
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

  // helper functions
  function collapseNodes(){
    svg.selectAll('.small')
      .transition()
      .attr('r', '0');

    svg.selectAll('text')
      .transition()
      .attr('font-size', '0')

    svg.selectAll('line')
      .transition()
      .attr('opacity', '0')
  }

  function inflateNodes() {
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
  }


  // canvas
  var svg = d3.select('#fingerprint')
    .append('svg')
    .attr('width', width)
    .attr('height', height);


  // circle attributes
  var circles = svg.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')

  circles.attr('cx', function(d, i) { return calculateX(d, i); })
         .attr('cy', function(d, i) { return calculateY(d, i); })
         .attr('r', small)
         .attr('class', 'small')
         .attr('fill', 'rgb(103, 175, 233)')
        //  .attr('stroke-width', '5')


  // line attributes
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


  // text attributes
  var labels = svg.selectAll('text')
    .data(data)
    .enter()
    .append('text')
    .text(function(d) { return d.type });

  labels.attr('x', function(d) { return d.x - ((small/2) + 20)})
        .attr('y', function(d) { return d.y + 3 })
        .attr('font-size', '15')
        .attr('fill', 'silver');


  // circles on click alterations
  circles.on('click', function(d) {
    d3.select(this)
      .attr('class', (this.classList[0] === 'big' ? 'small' : 'big'));
    if (this.classList[0] === 'big') {
      collapseNodes();
      d3.select(this)
        .transition()
        .delay(300)
        .attr('cx', width/2)
        .attr('cy', height/2)
        .attr('r', big);
    } else {
      inflateNodes();
      d3.select(this)
        .transition()
        .attr('r', small)
        .attr('cx', function(d) { return d.x })
        .attr('cy', function(d) { return d.y });
    }
  })
});




// center bubble labels
// draft bubble contents
// make text clickable (maybe)
// fill focus bubbles with content
