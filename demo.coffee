WIDTH = 700
HEIGHT = 700
NEAR = 0.1
VIEW_ANGLE = 45
ASPECT = WIDTH / HEIGHT
NEAR = 0.1
FAR = 10000

renderer = new THREE.WebGLRenderer antialias: true
camera = new THREE.OrthographicCamera -100, 100, 100, -100
#camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
scene = new THREE.Scene

camera.position.z = 300
renderer.setSize(WIDTH, HEIGHT)

$("#container").append renderer.domElement

scatterPlot = new THREE.Object3D
pointGeo = new THREE.Geometry
material = new THREE.ParticleBasicMaterial vertexColors: true, size: 1

for x in [-100..100] by 2
  for y in [-100..100] by 2
    pointGeo.vertices.push(new THREE.Vertex(new THREE.Vector3(x,y,0)))
    pointGeo.colors.push(new THREE.Color(0xFF0000))

points = new THREE.ParticleSystem pointGeo, material
scatterPlot.add points
scene.add scatterPlot

#pointLight = new THREE.PointLight 0xFFFFFF
#pointLight.position.x = 60
#pointLight.position.z = 100
#pointLight.position.y = 130
#scene.add pointLight

render = ->
  camera.position.y += 1 if moving.up
  camera.position.y -= 1 if moving.down
  camera.position.x += 1 if moving.right
  camera.position.x -= 1 if moving.left
  renderer.render(scene, camera)

# shim layer with setTimeout fallback
requestAnimFrame = (->
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          window.oRequestAnimationFrame      ||
          window.msRequestAnimationFrame     || (callback, element) -> window.setTimeout(callback, 1000 / 60)
)()

animloop = ->
  requestAnimFrame animloop, renderer.domElement
  render()

moving =
  up: false
  down: false
  left: false
  right: false

$(document).on "keydown", (e) ->
  switch e.which
    when 37
      moving.left = true
      e.preventDefault()
    when 39
      moving.right = true
      e.preventDefault()
    when 38
      moving.up = true
      e.preventDefault()
    when 40
      moving.down = true
      e.preventDefault()

$(document).on "keyup", (e) ->
  switch e.which
    when 37 then moving.left = false
    when 39 then moving.right = false
    when 38 then moving.up = false
    when 40 then moving.down = false
  e.preventDefault()

animloop()
