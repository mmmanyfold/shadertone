// Copied from https://www.shadertoy.com/view/MslGzn 2013/03/04

// Available as Mac Screensaver.  Code/Downloads here:
// https://bitbucket.org/rallen/quasicrystalscreensaver/wiki/Home

const float PI = 3.1415926535897931;
const float ra = 0.2 / 5.0 * 2.0 * PI;
const float ga = 5.0 / 3.0 * 2.0 * PI;
const float ba = 2.0 / 3.0 * 2.0 * PI;

// all of these can be played with
const float scale = 15.0;
const float tscale = 7.0;
const float xpixels = 3.0;
const float ypixels = 3.0;
const int symmetry = 5;

// tap into Overtone's volume
uniform float iOvertoneVolume;

float adj(float n, float m)
{
    return scale * ((2.0 * n / (m-1.0)) - 1.0);
}

vec2 point(vec2 src)
{
    return vec2(adj(src.x,ypixels), adj(src.y,ypixels));
}

float wave(vec2 p, float th)
{
    float t = fract(iGlobalTime/tscale);
    t *= 2.0 * PI;
    float sth = sin(th);
    float cth = cos(th);
    float w = (cos (cth*p.y + sth*p.x + t) + 1.0) / 2.0;
    // make the waves higher @ higher volumes
    w *= clamp(50.0*iOvertoneVolume, 0.25, 2.0);
    return w;
}

float combine(vec2 p)
{
    float sum = 0.0;
    for (int i = 0; i < symmetry; i++)
    {
        sum += wave(point(p), float(i)*PI/float(symmetry));
    }
    return mod(floor(sum), 2.0) == 0.0 ? fract(sum) : 1.0 - fract(sum);
}

void main(void)
{
    vec2 vUV = (gl_FragCoord.xy / iResolution.xy) + vec2(1.0,1.0);
    float s = 0.0;
    vec4 c;

    s = combine(vec2(vUV.y*xpixels, vUV.x*ypixels));

     // clut select
     if(s<=0.15) {
         c = mix( vec4( 58.0/255.0,117.0/255.0, 78.0/255.0, 0.0),
		  vec4(175.0/255.0,207.0/255.0, 93.0/255.0, 0.0),
                  s*4.0 );
     } else if(s<=0.5) {
         c = mix( vec4(200.0/255.0,207.0/255.0, 193.0/255.0, 0.0),
                  vec4(215.0/255.0,232.0/255.0,135.0/255.0, 0.0),
                  s*4.0-1.0 );
     } else if(s<=0.75) {
         c = mix( vec4(100.0/255.0,232.0/255.0,135.0/255.0, 0.0),
                  vec4(194.0/255.0,138.0/255.0, 79.0/255.0, 0.0),
                  s*4.0-2.0 );
     } else {
         c = mix( vec4(124.0/255.0,220.0/255.0,125.0/255.0, 0.0),
                  vec4(145.0/255.0, 170.0/255.0, 256.0/255.0, 0.0),
                  s*4.0-3.0 );
     }

     gl_FragColor = c;
}