#import <UIKit/UIKit.h>
#import "PokemonViewController.h"
#import "PokemonProtocols.h"
#import "View/PokemonView.h"

@interface PokemonViewController ()
@property(nonatomic) id<PokemonPresenterType> presenter;
@property(nonatomic) PokemonView *contentView;
@end

@interface PokemonViewController (PokemonViewControllerTypeCategory)<PokemonViewControllerType>
@end

@implementation PokemonViewController

- (instancetype) initWithPresenter: (id<PokemonPresenterType>) presenter
                          delegate: (id<PokemonViewControllerDelegate>) delegate
                       contentView: (PokemonView *) contentView {
    self = [super init];
    self.contentView = contentView;
    if (!self.contentView) {
        self.contentView = [[PokemonView alloc] initWithFrame: self.view.bounds];
    }
    self.presenter = presenter;
    self.delegate = delegate;
    return self;
}

- (void) loadView {
    [super loadView];
    self.view = _contentView;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [_contentView setBackgroundColor: [UIColor blueColor]];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
    [_presenter loadData];
}

@end

@implementation PokemonViewController (PokemonViewControllerTypeCategory)

- (void)showError { }

- (void)showLoading { 
    [_contentView showLoading];
}

- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel {
    [_contentView showReady: viewModel];
}

@end
