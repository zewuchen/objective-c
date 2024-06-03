#import <UIKit/UIKit.h>
#import "PokemonProtocols.h"
#import "View/PokemonView.h"

@interface PokemonViewController: UIViewController
@property(nonatomic, weak) id<PokemonViewControllerDelegate> delegate;

- (instancetype) initWithPresenter: (id<PokemonPresenterType>) presenter
                          delegate: (id<PokemonViewControllerDelegate>) delegate
                       contentView: (PokemonView *) contentView;

@end
