// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and http://vimeo.com/51993089 @ the 0min 44s mark
// For Shadertone, tap into Overtone's volume...
uniform float iOvertoneVolume;
void main(void)
{
    vec2 uv =  2.0*(gl_FragCoord.yx/iResolution.yx) - 1.0;
    vec2 uv2 = 2.0*(gl_FragCoord.yx/iResolution.yx) - 1.0;
    vec2 uv3 = 2.0*(gl_FragCoord.yx/iResolution.yx) - 1.0;
    // equvalent to the video's spec.y, I think
    float spec_y = 0.21 + 10.0*iOvertoneVolume;
    float col = 0.333;
    float col2 = 0.255;
    float col3 = 0.155;
    uv.x += sin(iGlobalTime * 1.0 + uv.y*1.5)*spec_y;
    uv2.x += sin(iGlobalTime * -1.0 + uv.y*1.5)*spec_y;
    uv3.x += sin(iGlobalTime * 2.0 + uv.y*1.5)*spec_y;
    col += abs(0.16/uv.x) * spec_y;
    col2 += abs(0.16/uv2.x) * spec_y;
    col3 += abs(0.16/uv3.x) * spec_y;
    gl_FragColor = vec4(col,col2,col3,0.10);
}
