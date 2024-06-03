#import <UIKit/UIKit.h>
#import "PokemonCoordinator.h"
#import "PokemonProtocols.h"
#import "PokemonViewController.h"
#import "PokemonAdapter.h"
#import "PokemonPresenter.h"

@interface PokemonCoordinator ()
@property(nonatomic) UINavigationController *navigationController;
@end

@interface PokemonCoordinator (PokemonViewControllerDelegateCategory)<PokemonViewControllerDelegate>
@end

@implementation PokemonCoordinator

- (instancetype) initWithNavigationController: (UINavigationController *) navigationController {
    self = [super init];
    self.navigationController = navigationController;
    return self;
}

- (void) start {
    PokemonPresenter *presenter = [[PokemonPresenter alloc] initWithNetwork: Network.shared
                                                                    adapter: nil];
    PokemonViewController *viewController = [[PokemonViewController alloc] initWithPresenter: presenter
                                                                                    delegate: self
                                                                                 contentView: nil];
    presenter.viewController = viewController;
    [_navigationController pushViewController: viewController animated: YES];
}

@end

@implementation PokemonCoordinator (PokemonViewControllerDelegateCategory)
@end
