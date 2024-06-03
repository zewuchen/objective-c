#import "PokemonPresenter.h"
#import "PokemonProtocols.h"
#import "Network/Network.h"
#import "PokemonAdapter.h"

@interface PokemonPresenter ()
@property(nonatomic) Network *network;
@property(nonatomic) id<PokemonAdapterType> adapter;
@end

@interface PokemonPresenter (PokemonPresenterTypeCategory)<PokemonPresenterType>
@end

@implementation PokemonPresenter

- (instancetype) initWithNetwork: (Network *) network
                         adapter: (id<PokemonAdapterType>) adapter {
    self = [super init];
    self.adapter = adapter;
    if (!adapter) {
        adapter = [PokemonAdapter new];
    }
    self.network = network;
    return self;
}

@end

@implementation PokemonPresenter (PokemonPresenterTypeCategory)

- (void) loadData { }

@end
