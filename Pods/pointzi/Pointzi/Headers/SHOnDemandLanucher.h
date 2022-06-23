//
//  SHOnDemandLanucher.h
//  StreetHawkCore
//
//  Created by ganesh faterpekar on 12/4/19.
//  Copyright © 2019 StreetHawk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHOnDemandLanucher: NSObject
@property (nonatomic, strong) NSString *onDemandTip;
+(SHOnDemandLanucher *) sharedInstance;
- (void)show: (NSString *)campaignID;
- (void)showForFAQ;
- (UIViewController *)currentVC;
@end

NS_ASSUME_NONNULL_END
