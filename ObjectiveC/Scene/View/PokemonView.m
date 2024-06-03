#import <UIKit/UIKey.h>
#import "PokemonView.h"
#include "PokemonProtocols.h"

@interface PokemonView ()
@property(nonatomic) void(^didTapLoading)(void);
@property(nonatomic) void(^didTapError)(void);
@property(nonatomic) void(^didTapReady)(void);
@end

@implementation PokemonView

- (void) showLoading { }

- (void) showError { }

- (void) showReady { }

@end
