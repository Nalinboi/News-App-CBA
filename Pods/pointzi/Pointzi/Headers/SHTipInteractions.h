//
//  SHTipInteractions.h
//  StreetHawkCore_Pointzi
//
//  Created by Ganesh Faterpekar on 2/10/20.
//  Copyright © 2020 StreetHawk. All rights reserved.
//

#ifndef SHTipInteractions_h
#define SHTipInteractions_h


#endif /* SHTipInteractions_h */
#import "SHTipBaseElement.h"
#import "SHTipDef.h"


@interface SHActions : SHTipBaseElement
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *value;
@end


@interface SHTargetParams : SHTipBaseElement
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) NSString* child;
@property (nonatomic) NSString* ancestor;
@property (nonatomic) NSString* index;
@property (nonatomic) NSString* type;
@property (nonatomic) NSString* version;
@property (nonatomic) NSString* selector;
@end

@interface SHConditions : SHTipBaseElement
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *view;
@property (nonatomic, strong) SHTargetParams *targetParams;
@end


@interface SHOverlay : SHTipBaseElement
@property(nonatomic) NSString *type;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) FourSide padding;
@property (nonatomic) CGRect highlightFrame;
@end


@interface NSDictionary(KeyValidator)
- (NSString *)getValueIfkeyExists:(NSString *)key ;

@end

@interface SHTipInteractions : SHTipBaseElement

/**
 Match type.
 */
@property (nonatomic, strong) NSString *matchType;

/**
 The Actions for tip.
 */
@property (nonatomic, strong) NSArray<SHActions*> *actions;

/**
 The Actions for tip.
 */
@property (nonatomic, strong) NSArray<SHConditions*> *conditions;


@end


