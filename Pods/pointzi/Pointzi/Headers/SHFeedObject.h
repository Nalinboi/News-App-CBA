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
#import "SHFeedConditions.h"

@class SHFeedObject;

/**
 Callback once detect new feeds.
 */
typedef void (^SHNewFeedsHandler)(void);

/**
 Callback once fetch feeds.
 @param arrayFeeds NSArray of SHFeedObject.
 @param error If fetch meet error, return here.
 */
typedef void (^SHFeedsFetchHandler)(NSArray<SHFeedObject *> *arrayFeeds, NSError *error);

/**
 Feed object definition.
 */
@interface SHFeedObject : NSObject

/**
 A unique identifier for the feed item.
 */
@property (nonatomic, strong) NSString *feed_id;

/**
 App key for the feed item.
 */
@property (nonatomic, strong) NSString *app_key;

/**
 Title of this feed.
 */
@property (nonatomic, strong) NSString *title;

/**
 Message of this feed.
 */
@property (nonatomic, strong) NSString *message;

/**
 Campaign this feed belongs to.
 */
@property (nonatomic, strong) NSString *campaign;

/**
 Campaign id of this feed.
 */
@property (nonatomic, strong) NSString *campaignid;

/**
 determine whether this tip is from preview or not.
 */
@property (nonatomic) bool isPreview;

/**
 Json content, parse to NSDictionary.
 */
@property (nonatomic, strong) NSDictionary *content;

/**
 A timestamp when the item activates (it will not be visible to clients before). It's possible to be nil.
 */
@property (nonatomic, strong) NSDate *activates;

/**
 A timestamp when the item expires (it will not be visible to clients after). It's possible to be nil.
 */
@property (nonatomic, strong) NSDate *expires;

/**
 Conditions specifiying when to delete the feed. Possible Value Until Done ,Infinite .  It's possible to be nil.
 */
@property (nonatomic, strong) NSString *deletion_conditions;

//@property (nonatomic, strong) NSArray <SHFeedConditions*> *repeat_conditions;

@property (nonatomic, strong) NSString *repeat_conditions;

/**
 When the Feed item has been created.
 */
@property (nonatomic, strong) NSDate *created;

/**
 When the Feed item was modified the last time.
 */
@property (nonatomic, strong) NSDate *modified;

/**
 When the Feed item was deleted.
 */
@property (nonatomic, strong) NSDate *deleted;


/**
 Priority of the feed
 */
@property (nonatomic, assign) NSInteger priority;

/**
 Create from dictionary with filled properties.
 */
+ (SHFeedObject *)createFromDictionary:(NSDictionary *)dict;

/**
 Load from dictionary with filled properties.
 */
+ (SHFeedObject *)loadFromDictionary:(NSDictionary *)dict;

/**
 Serialize self into a dictionary.
 @return A dictionary with the feed information.
 */
- (NSDictionary *)serializeToDictionary;

//+ (NSMutableArray *)createRepeatConditionsObject:(NSArray *) repeatConditions;

@end
