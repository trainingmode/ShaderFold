////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                    _ . , _ , . _ # ] S H A D E R F O L D [ # _ . , _  , . _                    //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
//  Defold-compatible boilerplate shader for porting ShaderToy code.                              //
////////////////////////////////////////////////////////////////////////////////////////////////////
// INPUT                                                                                          //
//    1. iTimeFrame:                                                                              //
//        - iTimeFrame.x = Total time.                                                            //
//        - iTimeFrame.y = Time elapsed since the previous frame.                                 //
//        - iTimeFrame.z = Frame count.                                                           //
//    2. iResolution:                                                                             //
//        - iResolution.x = Screen width.                                                         //
//        - iResolution.y = Screen height.                                                        //
//    3. iMouse:                                                                                  //
//        - iMouse.x = Current mouse x-position.                                                  //
//        - iMouse.y = Current mouse y-position.                                                  //
//        - sign(iMouse.z) = Mouse button held state.                                             //
//        - sign(iMouse.w) = Mouse button click state. ShaderToy Click = Defold action.pressed.   //
//        - abs(iMouse.z) = Mouse click x-position.                                               //
//        - abs(iMouse.w) = Mouse click y-position.                                               //
////////////////////////////////////////////////////////////////////////////////////////////////////
// CREDITS                                                                                        //
// - ShaderToy Mouse Input by iq: https://www.shadertoy.com/view/Mss3zH                           //
// - tuto: new mouse events by FabriceNeyret2: https://www.shadertoy.com/view/3dcBRS              //
////////////////////////////////////////////////////////////////////////////////////////////////////
// v0.1 | May 03, 2021 | Please, Frost Responsibly | Made with <3 by Tubcake Games                //
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// Input

varying mediump vec2 var_texcoord0;

uniform lowp vec4 iMouse;
uniform lowp vec4 iTimeFrame;
uniform lowp vec4 iResolution;
uniform lowp sampler2D iChannel0;

uniform lowp vec4 tint;

////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal

lowp float time;
lowp float timeDelta;
lowp float frame;
lowp vec2 resolution;
lowp vec4 mouse;

////////////////////////////////////////////////////////////////////////////////////////////////////
// Functions

float animateColor(float time, float scale) { return clamp(sin(time*scale)*.3 + .75, 0., 1.); }

////////////////////////////////////////////////////////////////////////////////////////////////////
// Shader
////////////////////////////////////////////////////////////////////////////////////////////////////

void main()
{
    // Inputs
    time = iTimeFrame.x;
    timeDelta = iTimeFrame.y;
    frame = iTimeFrame.z;
    resolution = iResolution.xy;
    mouse = iMouse;
    //vec2 fragCoord = var_texcoord0.xy;

    // Control Time if the Mouse is Held
    if (0 < mouse.z) time = length(-resolution.xy + mouse.xy) * 2.;

    // Sample Texture and Animate Color
    vec4 color = texture2D(iChannel0, var_texcoord0.xy);
    color.x *= animateColor(time, 2.);
    color.y *= animateColor(time, 3.);
    color.z *= animateColor(time, 4.);

    // Apply Tint and Output Color
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w); // Pre-multiply alpha since all runtime textures already are
    gl_FragColor = color * tint_pm;
}
