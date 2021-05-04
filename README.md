# ***ShaderFold***

> Defold-compatible boilerplate shader for porting ShaderToy code.

-----

![ShaderFold Demo](assets/shaderfold_demo01.gif "ShaderFold Demo")

-----

## **Notes**

This is a basic Defold project template for porting ShaderToy shaders.  
To learn how to port ShaderToy shaders to Defold, check out the [Official Defold ShaderToy Tutorial](https://defold.com/tutorials/shadertoy/).  
See [DefFX](https://github.com/subsoap/deffx), [Defold Shader Examples](https://github.com/subsoap/defold-shader-examples), [Defold Shaders](https://github.com/subsoap/defold-shaders), and [Pixel Planets](https://github.com/selimanac/defold-pixel-planets) for Defold-specific shaders implemented with best practices.

The goal of this project is to provide a template for porting and playing with code, not reimplement every ShaderToy input.

This is in development, not well tested, and suffers multiple issues. Many shaders require fine tuning for resolution and input parity.  
Feel free to [start a discussion](https://github.com/trainingmode/BulletFold/discussions/new) for any problems you encounter or improvements.

-----

## **Supported Features**

- iResolution  
- iTime  
- iTimeDelta  
- iFrame  
- iMouse  
- iChannel0

-----

## **Installation**

*TO DO...*

-----

## **Quick Start**

Please see the [shader.fp](shaders/shader.fp) Fragment Program for a basic implementation.

### *Material*

The [shader.material](defold://open?path=/shaders/shader.material) defines constants used by the shader.  
Texture Samplers defined within the Material will automatically appear in the Model's properties.

### *Model*

The shader renders onto the `shader_model` Model Component within the `ShaderFold` GameObject in the [main.collection](defold://open?path=/main/main.collection).

### *Script*

Updates to shader constants are pushed from the [fold.script](main/fold.script) Script Component within the `ShaderFold` GameObject in the [main.collection](defold://open?path=/main/main.collection).

-----

## **API**

### Fragment Constants

## iTimeFrame `vector4`

- [***x***] `iTime` The total time, in seconds.

- [***y***] `iTimeDelta` The time elapsed since the previous frame, in seconds.

- [***z***] `iFrame` The frame count.

- [***w***] `unused`

    ```lua
    time = iTimeFrame.x;
    timeDelta = iTimeFrame.y;
    frame = iTimeFrame.z;
    ```

## iResolution `vector4`

- [***x***] `iResolution.x` The screen width, in pixels.

- [***y***] `iResolution.y` The screen height, in pixels.

- [***z***] `unused`

- [***w***] `unused`

    ```lua
    resolution = iResolution.xy;
    ```

## iMouse `vector4`

- [***x***] `iMouse.x` The current Mouse x-position, if the Mouse Button is held.

- [***y***] `iMouse.y` The current Mouse y-position, if the Mouse Button is held.

- [***z***] `iMouse.z` Contains both the Mouse Click y-position and the Mouse Down state.

    - `sign(iMouse.z)` The Mouse Down state.

    - `abs(iMouse.z)` The Mouse Click y-position.

- [***w***] `iMouse.w` Contains both the Mouse Click x-position and the Mouse Click state. ShaderToy Click = Defold `action.pressed`.

    - `sign(iMouse.w)` The Mouse Click state.

    - `abs(iMouse.w)` The Mouse Click x-position.

    ```lua
    if (sign(iMouse.w) > 0) color.rg *= abs(iMouse.wz) / iResolution.x;
    ```

### I/O

## var_texcoord0 `vector2`

- [***xy***] `in fragCoord` The input fragment position. Supplied to the Fragment Program by the Vertex Program.

    ```lua
    vec2 uv = var_texcoord0.xy / iResolution.xy - 0.5;
    uv.y *= iResolution.y / iResolution.x;
    ```

## gl_FragColor `vector4`

- `out fragColor` The output fragment color.

- [***x***] `red` The output red channel value.

- [***y***] `green` The output green channel value.

- [***z***] `blue` The output blue channel value.

- [***w***] `alpha` The output color transparency.

    ```lua
    gl_FragColor = sampler2D(iChannel0, uv);
    ```

-----

## Credits

ShaderFold is based on [Input - Mouse](https://www.shadertoy.com/view/Mss3zH) by [iq (Inigo Quilez)](https://www.iquilezles.org/) and [tuto: new mouse events](https://www.shadertoy.com/view/3dcBRS) by [FabriceNeyret2](http://evasion.imag.fr/Membres/Fabrice.Neyret/).
