// from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1335128437

precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

const float temperature = 1500.0;
const float temperatureStrength = 1.0;

#define WithQuickAndDirtyLuminancePreservation
const float LuminancePreservationFactor = 1.0;

const float HCV_EPSILON = 1e-10;

#ifndef saturate
#define saturate(v) clamp(v, 0.0, 1.0)
#endif

// Converts from pure Hue to linear RGB
vec3 hue_to_rgb(float hue)
{
    float R = abs(hue * 6.0 - 3.0) - 1.0;
    float G = 2.0 - abs(hue * 6.0 - 2.0);
    float B = 2.0 - abs(hue * 6.0 - 4.0);
    return saturate(vec3(R,G,B));
}

// Converts from HSV to linear RGB
vec3 hsv_to_rgb(vec3 hsv)
{
    vec3 rgb = hue_to_rgb(hsv.x);
    return ((rgb - 1.0) * hsv.y + 1.0) * hsv.z;
}

// Converts a value from linear RGB to HCV (Hue, Chroma, Value)
vec3 rgb_to_hcv(vec3 rgb)
{
    // Based on work by Sam Hocevar and Emil Persson
    vec4 P = (rgb.g < rgb.b) ? vec4(rgb.bg, -1.0, 2.0/3.0) : vec4(rgb.gb, 0.0, -1.0/3.0);
    vec4 Q = (rgb.r < P.x) ? vec4(P.xyw, rgb.r) : vec4(rgb.r, P.yzx);
    float C = Q.x - min(Q.w, Q.y);
    float H = abs((Q.w - Q.y) / (6.0 * C + HCV_EPSILON) + Q.z);
    return vec3(H, C, Q.x);
}

// Converts from linear RGB to HSV
vec3 rgb_to_hsv(vec3 rgb)
{
    vec3 HCV = rgb_to_hcv(rgb);
    float S = HCV.y / (HCV.z + HCV_EPSILON);
    return vec3(HCV.x, S, HCV.z);
}

// function from https://www.shadertoy.com/view/4sc3D7
// valid from 1000 to 40000 K (and additionally 0 for pure full white)
vec3 colorTemperatureToRGB(const in float temperature) {
    // values from: http://blenderartists.org/forum/showthread.php?270332-OSL-Goodness&p=2268693&viewfull=1#post2268693
    mat3 m = (temperature <= 6500.0) ? mat3(vec3(0.0, -2902.1955373783176, -8257.7997278925690),
                                            vec3(0.0, 1669.5803561666639, 2575.2827530017594),
                                            vec3(1.0, 1.3302673723350029, 1.8993753891711275))
                                     : mat3(vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
                                            vec3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
                                            vec3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));
    return mix(clamp(vec3(m[0] / (vec3(clamp(temperature, 1000.0, 40000.0)) + m[1]) + m[2]), vec3(0.0), vec3(1.0)),
               vec3(1.0), smoothstep(1000.0, 0.0, temperature));
}

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    // RGB
    vec3 color = vec3(pixColor[0], pixColor[1], pixColor[2]);

#ifdef WithQuickAndDirtyLuminancePreservation
    color *= mix(1.0, dot(color, vec3(0.2126, 0.7152, 0.0722)) / max(dot(color, vec3(0.2126, 0.7152, 0.0722)), 1e-5),
                 LuminancePreservationFactor);
#endif

    color = mix(color, color * colorTemperatureToRGB(temperature), temperatureStrength) * 0.7;

    vec3 hsv = rgb_to_hsv(color);
    hsv.z *= 0.5;
    vec3 rgb = hsv_to_rgb(hsv);


    vec4 outCol = vec4(rgb, pixColor[3]);

    gl_FragColor = outCol;
}
