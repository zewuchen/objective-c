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

    [_contentView setDidTapReady:^(NSInteger row) {
        NSLog(@"Tapped on row %ld", (long)row);
    }];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
    [_presenter loadData];
}

@end

@implementation PokemonViewController (PokemonViewControllerTypeCategory)

- (void) showError {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ocorreu um erro"
                                                                                 message:@"Não foi possível carregar os pokemóns"
                                                                          preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Tentar Novamente"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
            [_presenter loadData];
        }];
        [alertController addAction:retryAction];
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void) showLoading {
    [_contentView showLoading];
}

- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel {
    [_contentView showReady: viewModel];
}

@end
