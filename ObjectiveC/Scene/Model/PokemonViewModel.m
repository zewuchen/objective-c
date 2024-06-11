#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokemonViewModel.h"

@implementation PokemonViewModel

- (instancetype) initWithName:(NSString *) name
                       color:(UIColor *) color {
    self = [super init];
    self.name = name;
    self.color = color;
    return self;
}

@end
