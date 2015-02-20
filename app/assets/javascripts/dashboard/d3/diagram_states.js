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
    .attr('x', Diagram.focusedNodeX - 34)
    .attr('y', 280);

  d3.selectAll('.' + className)
    .transition()
    .delay(300)
    .style('display', 'block');
}

function inflateNodes(className, svg) {
  svg.selectAll('.small')
    .transition()
    .delay(300)
    .attr('r', Diagram.small);

  svg.selectAll('text')
    .transition()
    .delay(300)
    .attr('font-size', Diagram.font);

  svg.selectAll('line')
    .transition()
    .delay(300)
    .attr('opacity', '0.3');

  svg.selectAll('.fingerprint-image')
    .transition()
    .attr('x', Diagram.width/2 - 34)
    .attr('y', Diagram.height/2 - 43);

  d3.selectAll('.' + className)
    .style('display', 'none');
}
