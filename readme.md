# react-native-control-flashlight-ios

This is a wrapper for react-native that controls a device's flashlight. The options are flashlight on or flashlight off. This is for an ios device.

# Add it to your project

npm install react-native-control-flashlight-ios --save

In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name]

Go to node_modules ➜ react-native-control-flashlight-ios and add RNControlFlashlight.xcodeproj

In XCode, in the project navigator, select your project. Add libRNControlFlashlight.a to your project's Build Phases ➜ Link Binary With Libraries

Click RNControlFlashlight.xcodeproj in the project navigator and go the Build Settings tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for Header Search Paths and make sure it contains both $(SRCROOT)/../react-native/React and $(SRCROOT)/../../React - mark both as recursive.

Run your project (Cmd+R)

Setup trouble?

If you get stuck, take a look at Brent Vatne's blog. His blog is my go to reference for this stuff.

# Api Setup

var React = require('react-native');

var { NativeModules } = React;

var { RNControlFlashlight } = NativeModules;

RNControlFlashlight.turnFlashlight(

    "flashlightOn", // flashlightOn, flashlightOff

    function errorCallback(results) {

        console.log('JS Error: ' + results['errMsg']);

    },

    function successCallback(results) {

        console.log('JS Success: ' + results['successMsg']);

    }
);

# Error Callback

The following will cause an error callback (use the console.log to see the specific message):

1) Parameter not "flashlightOn" or "flashlightOff"

2) The device does not have a flashlight that is capable of being programmatically accessed.

# Acknowledgements

Special thanks to Eddy Verbruggren for his flashlight code at github.com/EddyVerbruggen/. Special thanks to Brent Vatne for his posts on creating a react native packager. Some portions of this code have been based on answers from stackoverflow. This package also owes a special thanks to the tutorial by Jay Garcia at Modus Create on how to create a custom react native module.
