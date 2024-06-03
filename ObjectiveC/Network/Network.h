#import <Foundation/Foundation.h>

@interface Network: NSObject
+ (Network *) shared;
- (void) fetchData:(void (^)(NSDictionary *object, NSError *error)) completion;
@end
