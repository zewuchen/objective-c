#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import "PokemonAdapter.h"
#import "PokemonProtocols.h"

@interface PokemonAdapter (PokemonAdapterTypeCategory)<PokemonAdapterType>
@end

@implementation PokemonAdapter
@end

@implementation PokemonAdapter (PokemonAdapterTypeCategory)

- (PokemonViewModel *) adapt: (PokemonModel) model {
    const UIColor* randomColor = [UIColor colorWithRed: arc4random_uniform(256) / 255.0
                                                 green: arc4random_uniform(256) / 255.0
                                                  blue: arc4random_uniform(256) / 255.0
                                                 alpha:1.0];
    PokemonViewModel *viewModel = [[PokemonViewModel alloc] initWithName: model.name
                                                                   color: randomColor];
    return viewModel;
}

@end
