//
//  SHFAQBridge.h
//  pointzi
//
//  Created by ganesh faterpekar on 6/24/20.
//

#ifndef SHFAQBridge_h
#define SHFAQBridge_h


#endif /* SHFAQBridge_h */
@interface SHFAQBridge: NSObject
+(SHFAQBridge *) sharedInstance;
- (void)deleteFAQFeed:(NSString *) campaignId;
- (void)sendFeedResults:(NSDictionary *)results withFeedId: (NSString *) feedId;
- (void)removeFAQLauncher;
@end

