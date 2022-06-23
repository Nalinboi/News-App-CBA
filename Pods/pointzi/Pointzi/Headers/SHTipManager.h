/*
 * Copyright (c) StreetHawk, All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.
 */

#import <Foundation/Foundation.h>
//header from StreetHawk
#import "SHTipElement.h"
#import "SHBaseTipViewController.h"

/**
 Notification for init module's bridge class.
 The bridge class is for adding modules and it will handle the detail corresponding function notifications.
 */
#define SH_InitTipBridge_Notification  @"SH_InitTipBridge_Notification"

/**
 Central manager for tip functions.
 */
@interface SHTipManager : NSObject

/**
 Singleton creator.
 */
+ (SHTipManager *)sharedInstance;

/**
 Check whether it is polling tip modication in 3 seconds.
 */
- (BOOL)isPolling;

/**
 Trace current app's current VC. 
 It only traces StreetHawkBaseViewController inherit vc, but enough for showing tip.
 */
@property (nonatomic, weak) UIViewController *customerCurrentVC;

/**
 react native view that has been loaded currently
 */
@property (nonatomic, strong) NSString *currentRCTViewName;

/**
Feed Id of the currently displaying tip
 */
@property (nonatomic, strong) NSString *currentDisplayedTipFeedID;

/**
CampaignID Id of the currently displaying tip
 */
@property (nonatomic, strong) NSString *currentDisplayedTipCampaignID;


@property (nonatomic, strong) NSMutableArray<SHTipSeriesElement *> *innerTipSeries;

/**
 * currentTipViewController which is displaying
 */
@property (nonatomic, strong) SHBaseTipViewController *currentTipViewController;

/**
 Trace current tip's cover view, used for tour to transfer cover to next one.
 */
@property (nonatomic, strong) UIView *tipCoverView;

/**
 Trace current preview mdoe.
 */
@property (nonatomic, weak) UIView *previewModePanel;

/**
 Semaphore for concurrent tips to be shown on the same view controller.
 */
@property dispatch_semaphore_t concurrentTipsSemaphore;

/**
 Semaphore for concurrent single tip to be shown on the same view controller.
 */
@property NSLock *singleTipLock;
    
    
/**
 Semaphore for concurrent launcher click lock.
 */
@property NSLock *showLauncherBtnClickLock;

/**
 Semaphore for concurrent single tip count showing on the same view controller.
 */
@property long singleTipShowingCount;

/**
 Current Tip Series for showing
 */
@property (nonatomic, weak) SHTipSeriesElement *currentTipSeries;


/**
 Max timeInterval in seconds  before auto dimissing the tip
 */
@property NSTimeInterval autoDismissedTimeInterval;

/**
 Boolean flag to check if the SDK integration is correct.
 */
@property BOOL isSDKIntegrationCorrect;

/**
 Boolean flag to check if the Carousel is integrated before displaying.
 */
@property (nonatomic) BOOL isCarouselIntegrated;

/**
Tracks when multi page tour tip was shown
*/
@property (nonatomic, strong) NSMutableDictionary *tipSeriesSincelastShown;
/**
 Refresh current memory's tip series from feed. It's used when fetch new feed.
 @param feedObjects Fetched feed objects.
 */
- (void)fillTipFromFeed:(NSArray *)feedObjects;


/**
Tracks offscreenTips
*/
@property (nonatomic, strong) NSMutableDictionary *offScreenTipsTracker;

/**
 Show tip on a view controller.
 @param info Format: {"vc", ctrl, "delay": second}.
        ctrl The target view controller, mandantory.
        second The delay seconds, optional, if not exist use 1.0.
 */
- (void)showTipForViewController:(NSDictionary *)info;

/**
 Show tip on a view controller.
 */
- (void)showTip:(SHTipElement *)tip
onViewController:(UIViewController *)ctrl
forTargetControl:(UIView *)targetControl
minDelaySeconds:(double)minDelay
  withCoverView:(BOOL)withCoverView;

/**
 add tips launcher for a tip series element
 */
- (void)hookEventForTipSeries:(SHTipSeriesElement *)series
             onViewController:(UIViewController *)ctrl
              minDelaySeconds:(double)minDelay;

/**
 Custom feed on a view controller.
 @param ctrl The target view controller.
 */
- (void)customFeedForViewController:(UIViewController *)ctrl;

/**
 Target super tag to the events of elements on a view controller.
 @param ctrl The target view controller.
 */
- (void)targetSuperTagForViewController:(UIViewController *)ctrl;

/**
 Target super tag to the events of elements on a view controller.
 @param ctrl The target view controller.
 */
- (void)targetSuperTagForViewControllerV2:(UIViewController *)ctrl;

/**
 When swipe ctrl the corresponding tip should be dismissed. It doesn't trigger and click button event, just silently dismiss.
 @param ctrl The target view controller.
 */
- (void)forceDismissTipForViewController:(UIViewController *)ctrl;

/**
 Show tip authoring tool on a view controller.
 @param ctrl The target view controller.
 */
- (void)showAuthorToolForViewController:(UIViewController *)ctrl;

/**
 Remove a tip series from memory and local cache.
 @param tipSeries The tip series to remove.
 */
- (void)removeTipSeries:(SHTipSeriesElement *)tipSeries;

/**
 Handle super tag event version 2.
 */
- (void)superTagEventHandlerV2:(UIControl *)sender;

/**
 Handle remove launcher click/button.
 */
- (void)removeEventForSeries:(SHTipSeriesElement *)series;

/**
 Show tip on a view controller.
 */
- (void)concurrentTipPresentQueue:(SHBaseTipViewController *) tipVC onViewController:(UIViewController *) controller ;

/**
Show on demand launcher campaign
*/
- (void)showOnDemandCampaign:(NSArray *)campaigns ;
- (void)buttonAuthorClicked:(id)sender;
- (void)buttonAuthorDismissClicked:(id)sender;
- (void)replyCachedPreviewTips;
- (void)removePreviewTips;
- (void)coachmarkClicked;
- (void)displayOffScreenTips:(NSDictionary *)info;
- (void)addOffScreenTip:(SHTipElement *) tip;
- (void)removeOffScreenTip:(SHTipElement *) tip;
- (void)removeOffScreenTipOnGuideCompletion:(SHTipElement *) tip;
- (void)removeAllOffScreenTips;
- (void)updateFeedRepeatConditions:(SHTipElement *) tipElement;
@end


@interface SHTipOffScreenTracker : NSObject
@property (nonatomic, strong) NSString *ctrlName;
@property (nonatomic, weak) SHTipElement *offScreenTip;
@property NSDate *lastAttemptToShowtime;
@property (nonatomic) bool isTipShown;
@property NSDate *tipShownTime;
@property (nonatomic) long tipIndex;
@end
