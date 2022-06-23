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

#import "SHTipBaseElement.h"
#import "SHTipLauncherElement.h"
#import "SHTipTargetElement.h"
#import "SHFeedConditions.h"

@class SHTipElement;

@interface SHTipSeriesElement : SHTipBaseElement

/**
 Display type of current tip series.
 */
@property (nonatomic) SHTipDisplayType tipDisplayType;

/**
 Type of current tip series.
 */
@property (nonatomic) SHTipType tipType;

/**
 Mode of current tip series.
 */
@property (nonatomic, strong) NSString *seriesAuthorMode;

/**
 Trigger of current tip series.
 */
@property (nonatomic) SHTipTrigger triggerType;

/**
 Weak reference of the trigger control which trigger this series. It's for event handler. It's assigned when hooking event in a view controller. It can be same or not same as targetView. It can be normal UIView, or UIBarButtonItem or etc.
 */
@property (nonatomic, weak) id triggerControl;

/**
 Launcher of current tip series.
 */
@property (nonatomic, strong) SHTipLauncherElement *launcher;

/**
 Target of current tip series.
 */
@property (nonatomic, strong) SHTipTargetElement *target;

/**
 A unique identifier for the containing feed. This is got from parent feed object.
 */
@property (nonatomic) NSString * feed_id;

/**
 A unique identifier for the campaign the current series belong to. This is got from parent feed object.
 */
@property (nonatomic) NSString * campaignid;

/**
 feed got updated on server side datetime, indicating if tip series element is changing to update local sdk cache.
 */
@property (nonatomic, strong) NSDate *modified;

/**
 Indicates when the feed will expiry
 */
@property (nonatomic, strong) NSDate *expiry;

/**
 Array of the series.
 */
@property (nonatomic, strong) NSArray<SHTipElement *> *arrayTips;


/**
 Identify multipage tour
 */
@property (nonatomic) BOOL isMultipageTour;

/**
 Priority of the Guide
 */
@property(nonatomic,assign) NSInteger priority;

@property (nonatomic, strong) NSDictionary *faq;

@property (nonatomic, strong) NSDictionary *fab;

@property (nonatomic, strong) NSArray <SHFeedConditions*> *repeat_conditions;

@property (nonatomic, strong) NSArray <SHFeedConditions*> *deletion_conditions;

@end
