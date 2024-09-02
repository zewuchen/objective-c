#import <UIKit/UIKit.h>
#import "../Model/PokemonViewModel.h"

@interface PokemonView: UIView
@property(nonatomic) void(^didTapReady)(NSInteger);

- (void) showLoading;
- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel;
@end
