varying vec2 vUv;
varying vec3 vPos;
varying vec2 vCoordinates;
attribute vec3 aCoordinates;
attribute float aSpeed;
attribute float aOffset;

attribute float aDirection;
attribute float aPress;

uniform float move;
uniform float time;

uniform vec2 mouse;
uniform float mousePressed;

uniform float transition;

void main() {
  vUv = uv;

//NOT STABLE
vec3 pos = position;
pos.x += sin(move*aSpeed)*3. ;
pos.y += sin(move*aSpeed)*3. ;
pos.z = mod(position.z + move*200.*aSpeed + aOffset, 2000.) - 1000.;
//dzięki mod ZAWSZE będziemy widzieć cząśteczki


//STABLE 
vec3 stable = position;
float dist = distance(stable.xy,mouse);
float area = 1. - smoothstep(0.,300.,dist);

stable.x += 50.*sin(0.11*time*aPress)*aDirection*area*mousePressed;
stable.y += 50.*sin(0.11*time*aPress)*aDirection*area*mousePressed;
stable.z += 200.*cos(0.11*time*aPress)*aDirection*area*mousePressed;

pos = mix(pos,stable,transition);

  vec4 mvPosition = modelViewMatrix * vec4( pos, 1. );
  // vec4 mvPosition = modelViewMatrix * vec4( stable, 1. );
  gl_PointSize = 2500. * ( 1. / - mvPosition.z );
  //when particles will be more far from the camera they will be smaller
  gl_Position = projectionMatrix * mvPosition;

  vCoordinates = aCoordinates.xy;
  vPos = pos;
}