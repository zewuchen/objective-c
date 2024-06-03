#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PokemonCoordinator: NSObject
- (instancetype) initWithNavigationController: (UINavigationController *) navigationController;
- (void) start;
@end
