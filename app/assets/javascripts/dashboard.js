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
    {type: 'screen', val: json.screen},
    {type: 'browser version', val: json.browser_version},
    {type: 'user agent', val: json.user_agent},
  ]

  var small  = 70;
  var big    = 300;
  var width  = '1110';
  var height = '700';
  var radius = '250';


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
  function randomRgbNum() {
    return Math.round(Math.random()*255).toString();
  }

  function collapseNodes(){
    svg.selectAll('.small')
      .transition()
      .attr('r', '0');
  }

  function inflateNodes() {
    svg.selectAll('.small')
      .transition()
      .delay(300)
      .attr('r', small);
  }


  // fingerprint canvas
  var svg = d3.select('#fingerprint')
    .append('svg')
    .attr('width', width)
    .attr('height', height);


  // default circle attributes
  var circles = svg.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')
    .append('text')
    .text(function(d) { return d.val })

  circles
    .attr('cx', function(d, i) {
      return calculateX(d, i);
    })
    .attr('cy', function(d, i) {
      return calculateY(d, i);
    })
    .attr('r', small)
    .attr('class', 'small')
    // .attr('fill', function() {
    //   return  'rgb(' + randomRgbNum() + ', ' +
    //                    randomRgbNum() + ', ' +
    //                    randomRgbNum() + ')';
    // })
    .attr('fill', 'rgb(103, 175, 233)')
    .attr('stroke', 'silver')
    .attr('stroke-width', '5')

  // circles on click alterations
  circles
    .on('click', function(d) {
      d3.select(this)
        .attr('class', (this.classList[0] === 'big' ? 'small' : 'big'));
      if (this.classList[0] === 'big') {
        collapseNodes();
        d3.select(this).transition()
                       .delay(300)
                       .attr('cx', width/2)
                       .attr('cy', height/2)
                       .attr('r', big);
      } else {
        inflateNodes();
        d3.select(this).transition()
                       .attr('r', small)
                       .attr('cx', function(d) { return d.x })
                       .attr('cy', function(d) { return d.y });
      }
    })
});
