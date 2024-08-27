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
        self.adapter = [PokemonAdapter new];
    }
    self.network = network;
    return self;
}

@end

@implementation PokemonPresenter (PokemonPresenterTypeCategory)

- (void) loadData { 
    __weak typeof(self) weakSelf = self;

    [self.network fetchData:^(NSDictionary *object, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;

        if (strongSelf) {
            NSMutableArray<PokemonViewModel *> *array = [NSMutableArray array];

            if (object[@"results"] != nil) {
                for (NSDictionary *item in object[@"results"]) {
                    PokemonModel pokemon;
                    pokemon.name = item[@"name"];
                    PokemonViewModel *viewModel = [self.adapter adapt: pokemon];

                    // addObject of an NSMutable only allows instances from NSObject
                    // because of that, ViewModel can't be struct type
                    [array addObject: viewModel];
    
                    [self.viewController showReady: array];
                }
            }
        }
    }];
}

@end
