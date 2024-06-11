#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>

@interface PokemonViewModel: NSObject
@property(nonatomic) NSString *name;
@property(nonatomic) UIColor *color;

- (instancetype) initWithName:(NSString *) name
                        color:(UIColor *) color;
@end
