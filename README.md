# LxWaveLayer
    Easily add wave animation.

### Installation
    You only need drag LxWaveLayer.h and LxWaveLayer.m to your project.

### CocoaPods
    pod 'LxWaveLayer', '~> 1.0.1'

### Support
    Minimum support iOS version: iOS 6.0

### Usage
```objc
    #import "LxWaveLayer.h"

    //  setup
    _waveLayer = [LxWaveLayer layer];
    [_waveLayer deployOnView:SUPER_VIEW];

    //  begin animation
    [_waveLayer beginWaveAnimation];

    //  stop animation
    [_waveLayer stopWaveAnimation];

    //  adjust property
    _waveLayer.fillColor = WAVE_COLOR.CGColor;
    _waveLayer.waveHeight = 180;
    _waveLayer.waveAmplitude = 6;
    _waveLayer.wavePeriod = 270;
    _waveLayer.waveSpeed = 240;
    _waveLayer.wavePhase = 80;

```

### License
    LxWaveLayer is available under the MIT License. See the LICENSE file for more info.