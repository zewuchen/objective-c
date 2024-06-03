#import <Foundation/Foundation.h>
#import "Network/Network.h"
#import "PokemonProtocols.h"

@interface PokemonPresenter: NSObject
@property(nonatomic, weak) id<PokemonViewControllerType> viewController;

- (instancetype) initWithNetwork: (Network *) network
                         adapter: (id<PokemonAdapterType>) adapter;

@end
