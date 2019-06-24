width = 960
height = 600
active = d3.select(null)

svg = d3.select('#map-ctn')
  .append('svg')
  .attr('width', width)
  .attr('height', height)

svg.append("rect")
  .attr("class", "background")
  .attr("width", width)
  .attr("height", height)
  .on("click", reset)

g = svg.append("g")
  .style("stroke-width", "1px")

xym = d3.geo.conicEquidistantJapan()
  .translate([width/ 2 + 150, height/ 2])
  .scale(2500)

path = d3.geo.path().projection(xym)


d3.json 'nihon.geo.json', (data) ->

  g.selectAll('path').data(data.features)
    .enter()
    .append('path')
    .attr('d', path)
    .attr('class',"prefecture")
    .style('fill', ->'rgba(58,70,14,0.19)')
    .on('mouseover', (e) ->
        d3.select(this).style('fill', '#6187aa')
        return)
    .on('mouseout', (e) ->
        d3.select(this).style('fill', 'rgba(58,70,14,0.19)')
        return)
    .on('click', clicked)

  g.append("path")
    .style("fill","none")
    .style("stroke","#ff1500")
    .attr("d", xym.getCompositionBorders())

  return

clicked = (d)->
  if active.node() == this
    reset()
    return
  console.log d.properties.nam, d.properties.nam_ja
  active.classed('active', false)
  active = d3.select(this).classed('active', true)

  bounds = path.bounds(d)
  dx = bounds[1][0] - (bounds[0][0])
  dy = bounds[1][1] - (bounds[0][1])
  x = (bounds[0][0] + bounds[1][0]) / 2
  y = (bounds[0][1] + bounds[1][1]) / 2
  scale = .9/ Math.max(dx/width, dy / height)
  translate = [
    width / 2 - (scale * x)
    height / 2 - (scale * y)
  ]

  g.transition().duration(750)
    .style('stroke-width', 1.5 / scale + 'px')
    .attr('transform', 'translate(' + translate + ')scale(' + scale + ')')


reset = () ->
  console.log "here"
  active.classed("active", false)
  active = d3.select(null)

  g.transition()
    .duration(750)
    .style("stroke-width", "1px")
    .attr("transform", "")
  return