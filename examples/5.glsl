// The shadertoy uniform variables are available by default.

// It is necessary to add the Overtone vars.
uniform float iOvertoneVolume;

void main(void) {
  vec2 uv = (gl_FragCoord.xy / iResolution.xy);
  // find the center and use distance from the center to vary the
  // green component
  vec2 uv2 = uv - 0.5;
  float r = sqrt(uv2.y*uv2.x + uv.y*uv2.y);
  gl_FragColor = vec4(uv.x,
                      15.0*iOvertoneVolume*(10-r),
                      5.2*cos(3.0*iGlobalTime)+0.5,
                      3.6);
}
