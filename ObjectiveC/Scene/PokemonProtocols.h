#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Network.h"
#import "Model/PokemonModel.h"
#import "Model/PokemonViewModel.h"

@protocol PokemonPresenterType;

@protocol PokemonViewControllerDelegate
@end

@protocol PokemonViewControllerType
- (void) showLoading;
- (void) showError;
- (void) showReady;
@end

@protocol PokemonAdapterType
- (PokemonViewModel *) adapt: (PokemonModel) model;
@end

@protocol PokemonPresenterType
- (void) loadData;
@end
