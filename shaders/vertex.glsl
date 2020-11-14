void main() {
  vUv = uv;
  vec4 mvPosition = modelViewMatrix * vec4( position, 1. );
  gl_PointSize = 50. * ( 1. / - mvPosition.z );
  //when particles will be more far from the camera they will be smaller
  gl_Position = projectionMatrix * mvPosition;
}