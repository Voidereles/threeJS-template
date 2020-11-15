varying vec2 vUv;
varying vec2 vCoordinates;
attribute vec3 aCoordinates;

void main() {
  vUv = uv;
  vec4 mvPosition = modelViewMatrix * vec4( position, 1. );
  gl_PointSize = 1000. * ( 1. / - mvPosition.z );
  //when particles will be more far from the camera they will be smaller
  gl_Position = projectionMatrix * mvPosition;

  vCoordinates = aCoordinates.xy;
}