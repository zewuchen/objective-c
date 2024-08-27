#import <UIKit/UIKit.h>
#import "../Model/PokemonViewModel.h"

@interface PokemonView: UIView
- (void) showLoading;
- (void) showError;
- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel;
@end
