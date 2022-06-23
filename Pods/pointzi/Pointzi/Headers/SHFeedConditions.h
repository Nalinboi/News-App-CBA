//
//  SHFeedConditions.h
//  pointzi
//
//  Created by Ganesh Faterpekar on 27/5/21.
//

#import <Foundation/Foundation.h>

@interface SHFeedConditions : NSObject
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSString* op;
@property (nonatomic,strong) id value;
@property (nonatomic,strong) id currentValue;
@property (nonatomic,strong) NSString* tag;
@property (nonatomic,strong) NSArray* value_array;

/**
 Create from dictionary with filled properties.
 */
+ (SHFeedConditions *)createFromDictionary:(NSDictionary *)dict;

+ (NSMutableArray *)createConditionsObject:(NSString *) conditionsString andName:(NSString *) conditionsName;
+ (NSMutableArray *)createFeedConditionsArray:(NSArray *) feedConditions;
+ (NSString *)getUpdatedFeedConditions:(NSArray <SHFeedConditions *> *)feedConditions andName:(NSString *)conditionsName andIncrement:(BOOL)isIncrement;
+ (NSString *)jsonToString:(NSMutableArray *)feedConditions andName: conditionName;
+ (NSDictionary *) dictKeys:(SHFeedConditions *) feedConditions andIncrement:(BOOL)isIncrement;
+ (NSString *) updatedCurrentValue:(SHFeedConditions *)feedCondition;
+ (NSString *) initialCurrentValue:(SHFeedConditions *)feedCondition;
+ (NSArray *) getSavedFeedConditions:(NSString *)feedId andFeedConditions:(NSArray <SHFeedConditions*> *)conditions andName:(NSString *) conditionsName;
@end

//(NSArray<UINavigationController *> *)navigationControllers
