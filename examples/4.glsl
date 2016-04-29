// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and http://vimeo.com/51993089 @ the 0min 44s mark
// For Shadertone, tap into Overtone's volume...
uniform float iOvertoneVolume;
void main(void)
{
    vec2 uv = 3.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    vec2 uv2 = 3.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    vec2 uv3 = 3.0*(gl_FragCoord.xy/iResolution.xy) - 1.0;
    vec2 uv4 = 4.0*(gl_FragCoord.xy/iResolution.xy) - 2.0;
    // equvalent to the video's spec.y, I think
    float spec_y = 0.1 + 5.0*iOvertoneVolume;
    float col = 0.5;
    float col2 = 0.09;
    float col3 = 0.055;
    float col4 = 0.02;
    uv.x += sin(iGlobalTime * 6.0 + uv.y*1.5)*spec_y;
    uv2.x += sin(iGlobalTime * 6.0 + uv2.y*1.5)*spec_y;
    uv3.x += sin(iGlobalTime * -6.0 + uv3.y*1.5)*spec_y;
    uv4.x += sin(iGlobalTime * -6.0 + uv.y*2.5)*spec_y;
    col += abs(0.066/uv.x) * spec_y;
    col2 += abs(1.066/uv2.x) * spec_y;
    col3 += abs(2.16/uv3.x) * spec_y;
    col4 += abs(0.16/uv4.x) * spec_y;    
    gl_FragColor = vec4(col,col2,col3,col4);
}
