//
//  RNControlFlashlight.m
//  RNControlFlashlight
//  Created by Ross Haker on 9/4/15.
//

#import "RNControlFlashlight.h"

@implementation RNControlFlashlight

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

// Persist data
RCT_EXPORT_METHOD(turnFlashlight:(NSString *)flashlightDesc
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Check that the device has a flashlight
    if (![self deviceHasFlashlight]) {
        
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Device does not have a flashlight."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    }
    
    // Handle the flashlightOff case
    if ([flashlightDesc isEqual: @"flashlightOff"]) {
        
        // Acquire a reference to the device
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Configure the flashlight to be off
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
        
        // Show success message that screen has been put to sleep
        NSDictionary *resultsDict = @{
                                      @"success" : @YES,
                                      @"successMsg"  : @"Flashlight should now be turned off."
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
        return;
        
    } else if ([flashlightDesc isEqual: @"flashlightOn"]) {
        
        // Acquire a reference to the device
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Configure the flashlight to be on
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
        [device unlockForConfiguration];
        
        // Show success message that screen is now in sleep mode
        NSDictionary *resultsDict = @{
                                      @"success" : @YES,
                                      @"successMsg"  : @"Flashlight should now be turned on."
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
        return;
        
    } else {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Invalid flashlight type. Set to either flashlightOn or flashlightOff."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    }
}

// Logic to check whether device has a flashlight
-(BOOL)deviceHasFlashlight {
    
    if (NSClassFromString(@"AVCaptureDevice")) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        return [device hasTorch] && [device hasFlash];
        
    }
    return false;
}

@end
