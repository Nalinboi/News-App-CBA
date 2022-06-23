//
//  PZPreviewModeBridge.h
//  StreetHawkCore_Pointzi
//
//  Created by Ganesh Faterpekar on 17/8/20.
//  Copyright © 2020 StreetHawk. All rights reserved.
//

#ifndef PZPreviewModeBridge_h
#define PZPreviewModeBridge_h
#import <UIKit/UIKit.h>

#endif /* PZPreviewModeBridge_h */

@interface PZPreviewModeBridge: NSObject
+(PZPreviewModeBridge *) sharedInstance;
- (void)captureScreenShot;
- (void)replayTour;
- (void)exitPreviewMode;
- (UIImage *)getlocalImage:(NSString *) imageName;
@end
