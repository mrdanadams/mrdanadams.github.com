---
layout: post
title: "Creating a custom OpenLayers build by profiling usage"
date: 2012-08-18 12:45
comments: true
categories: 
tags:
- javascript
- rails
---

[OpenLayers](http://openlayers.org/) is a great library for integrating maps especially when creating custom mapping interfaces. However, with great functionality can come great size. Weighing in at nearly 1MB for the full library, you should pair it down to only the modules used.

[openlayers-instrumenter](https://github.com/mrdanadams/openlayers-instrumenter) creates a custom OpenLayers build profile by instrumenting the JavaScript dynamically and tracking what's used.

<!-- more -->

## Instrument the OpenLayers JS

Load the instrumenter after OpenLayers but before using it:

```html
<script src="lib/OpenLayers-2.12/lib/OpenLayers.js"></script>
<script src="lib/openlayers-instrumenter.js"></script>
<script src="you-app-code.js"></script>
```

  **Note:** It's not for production use so only include it while creating the build profile.

Load your page. About 2 seconds after page load, you'll see something like this console.log'd:

```
[first]

[last]

[include]
OpenLayers/Map.js
OpenLayers/BaseTypes/Size.js
OpenLayers/BaseTypes/Bounds.js
OpenLayers/Util.js
OpenLayers/BaseTypes/Element.js
OpenLayers/Events.js
OpenLayers/Function.js
OpenLayers/Event.js
OpenLayers/String.js
OpenLayers/Control/Navigation.js
OpenLayers/Control/Zoom.js
OpenLayers/Control/ArgParser.js
OpenLayers/Control/Attribution.js
OpenLayers/Handler/Click.js
OpenLayers/Control/DragPan.js
OpenLayers/Control/ZoomBox.js
OpenLayers/Handler/Drag.js
OpenLayers/Handler/Box.js
OpenLayers/Handler/MouseWheel.js
OpenLayers/Control/PinchZoom.js
OpenLayers/Handler/Pinch.js
OpenLayers/Events/buttonclick.js
OpenLayers/Layer/WMS.js
OpenLayers/Layer/Vector.js
OpenLayers/Renderer/SVG.js
OpenLayers/StyleMap.js
OpenLayers/Style.js
OpenLayers/Projection.js
OpenLayers/Control/LayerSwitcher.js
OpenLayers/Lang.js
OpenLayers/Control/MousePosition.js
OpenLayers/Control/DrawFeature.js
OpenLayers/Handler/Point.js
OpenLayers/Handler/Path.js
OpenLayers/Handler/Polygon.js
OpenLayers/Handler/RegularPolygon.js
OpenLayers/BaseTypes/LonLat.js
OpenLayers/Animation.js
OpenLayers/BaseTypes/Pixel.js

[exclude]

```

This is the build profile used by OpenLayers to create a custom distribution for your app.

If you load new OpenLayers classes during page use, exercise those functions then call `OLI.createProfile()` in the console to dump the updated profile.

## Using the OpenLayers build profile

Save the build profile into `OpenLayers-2.12/build/custom.cfg`. OpenLayers ships with a script to load the profile and create the distribution:

```sh
$ cd OpenLayers-2.12/build/
$ ./build.py custom
```

The compiled file is put in the same directory as `OpenLayers.js`.

The full build includes **261 files** weighing in at whopping **942 KB** (minified!). For most builds it will probably be reduced to about **60 files** totaling **271 KB**.

## Room for improvement

A "reduced" build of nearly 300 KB minified is still quite large. I've used it in a Rails app targeted for the iPad and it worked great. Using a custom build made a noticable difference both in page load speed and responsivess when using the UI. However, I'd be surprised if we didn't see a mapping microlibrary or two give OpenLayers a run for it's money.
