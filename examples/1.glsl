uniform float iOvertoneVolume;
uniform float t0;
void main(void)
{
      // * MORE HUE/SATURATION: vec3(down)
    vec3  c      = vec3(0.5);
    float act    = abs(cos(iGlobalTime));
    vec2  uv     = gl_FragCoord.xy/iResolution.xy;
    float aspect = iResolution.x / iResolution.y;
    vec2  ar     = vec2( (aspect < 1.0) ? 1.0/aspect : 1.0,
                         (aspect < 1.0) ? 1.0 : 1.0/aspect);
    uv *= ar;

      // * GO FASTER: iGlobalTime/down
    uv *= (3.0 + 3.0*sin(iGlobalTime/2.0));
    for(int i = 0; i < 6; i++) {
        vec2 xy  = vec2(sin(iGlobalTime-11.0*abs(t0)+6.28*(i/6.0)),
                        cos(iGlobalTime+23.0*abs(t0)+6.28*(i/6.0)));
        vec2 uv2 = uv - 2.0*ar + xy;
        float r  = sqrt(uv2.x*uv2.x + uv2.y*uv2.y);

          // * MORE QUIVER: vec3(up)
        c += (vec3(10,0.15*(1.0-act),0.1*(act)) *
              vec3(min(0.9,pow(r,8.0)*3*iOvertoneVolume)));
        c += (vec3(-4.0*act,0.0,0.5*act) *
              vec3(max(0.0,4.0*pow(1.5*t0+0.5,0.5)*(1.0-r)-1.6)));
    }
    gl_FragColor = vec4(c, 2.0);
}
