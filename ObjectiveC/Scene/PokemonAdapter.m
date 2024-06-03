#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import "PokemonAdapter.h"
#import "PokemonProtocols.h"

@interface PokemonAdapter (PokemonAdapterTypeCategory)<PokemonAdapterType>
@end

@implementation PokemonAdapter
@end

@implementation PokemonAdapter (PokemonAdapterTypeCategory)

- (PokemonViewModel) adapt: (PokemonModel) model {
    PokemonViewModel viewModel;
    viewModel.name = @"Pikachu";
    viewModel.color = [UIColor yellowColor];
    return viewModel;
}

@end
