width = 960
height = 700

svg = d3.select('#map-holder')
  .append('svg')
  .attr('width', width)
  .attr('height', height)

xym = d3.geo.albers()
path = d3.geo.path().projection(xym)

xym.origin([134, 25])
xym.translate([350, 745])
xym.parallels([24.6, 43.6])
xym.scale(1980)

d3.json 'nihon.geo.json', (data) ->
  svg.selectAll('path').data(data.features)
    .enter()
    .append('path')
    .attr('d', path)
    .style('fill', ->'#44aaee')
    .on('mouseover', (e) ->
        d3.select(this).style('fill', '#5522aa')
        return)
    .on 'mouseout', (e) ->
        d3.select(this).style('fill', '#44aaee')
        return
  return
