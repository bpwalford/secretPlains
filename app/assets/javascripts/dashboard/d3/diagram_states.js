'use strict';

function collapseNodes(className, svg){
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
    .attr('x', focusedNodeX - 34)
    .attr('y', 280 - 39);

  d3.selectAll('.' + className)
    .transition()
    .delay(300)
    .style('display', 'block');
}

function inflateNodes(className, svg) {
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
    .attr('opacity', '0.3');

  svg.selectAll('.fingerprint-image')
    .transition()
    .attr('x', width/2 - 34)
    .attr('y', height/2 - 43);

  d3.selectAll('.' + className)
    .style('display', 'none');
}
