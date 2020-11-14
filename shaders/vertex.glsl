uniform float time;
varying vec2 vUv;
varying vec2 vUv1;
varying vec4 vPosition;

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform vec2 pixels;
uniform vec2 uvRate1;

void main() {
  vUv = uv;
  vec4 mvPosition = modelViewMatrix * vec4( position, 1. );
  gl_PointSize = 5000. * ( 1. / - mvPosition.z );
  //when particles will be more far from the camera they will be smaller
  gl_Position = projectionMatrix * mvPosition;
}