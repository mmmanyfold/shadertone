// uses iChannel0 for fft
uniform float iOvertoneVolume;

// find the magnitude of hz in the FFT.  range is 0..1(ish)
float hz(float hz)
{
    float u = hz/22050.0;
    return texture2D(iChannel0,vec2(u,0.25)).x;
}

void main(void)
{
    vec2 uv = 2.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    uv.x *= iResolution.x/iResolution.y;  // fix aspect ratio

    // 3 dancing magenta, cyan & yellow sine waves

      // * GO WIDER: v1 = up

    float v1 = 1.5 + 9.0*iOvertoneVolume;
    float v2 = 0.8 + 0.5*hz(800);
    float v3 = 0.1 + 0.5*hz(8000);
    vec3 col = vec3(0.0, 0.0, 0.0);

      // * GO FASTER: sin(up)

    float v1x = uv.y + cos(2.0*iGlobalTime + 5.5*uv.x)*v3;
    float v2x = uv.x + 0.0 + sin(1.2*iGlobalTime + 1.5*uv.y)*v2;
    float v3x = uv.x - 0.25 + cos(3.1*iGlobalTime + 5.2*uv.y)*v3;
    col += vec3(5.0,5.0,0.0) * abs(0.066/v1x) * v3;
    col += vec3(5.0,0.0,0.0) * abs(0.066/v2x) * v2;
    col += vec3(0.0,0.0,3.0) * abs(0.066/v3x) * v1;

    // with a lighted disco floor pattern
    float uvy2 = 0.25*iGlobalTime-uv.y;
    float a1 = max(0.0,0.15*hz(200)) *
        max(0.0,min(1.0,sin(10*uvy2)));
    col += vec3(0.5,0.5,0.5) * a1;

    gl_FragColor = vec4(col,0.5);
}
