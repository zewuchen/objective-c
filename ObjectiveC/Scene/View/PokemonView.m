#import <UIKit/UIKit.h>
#import "PokemonView.h"
#include "PokemonProtocols.h"

@interface PokemonView ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, strong) NSMutableArray<PokemonViewModel *> *viewModel;
@end

@implementation PokemonView

- (instancetype) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    self.tableView = [[UITableView alloc] initWithFrame: CGRectZero
                                                  style: UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview: self.tableView];
    [self addSubview: self.activityIndicator];
    [self setupConstraints];
    return self;
}

- (void) setupConstraints { 
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor: self.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor]
    ]];
}

- (void) resetStates {
    _tableView.hidden = YES;
    _activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}

- (void) showLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetStates];
        self.activityIndicator.center = CGPointMake(self.bounds.size.width / 2,
                                                self.bounds.size.height / 2);
        [self.activityIndicator startAnimating];
    });
}

- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel {
    self.viewModel = viewModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetStates];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    });
}

//- (void) showError {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self resetStates];
//        Depreciado
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ocorreu um erro"
//                                                            message:@"Não foi possível carregar os pokemóns"
//                                                           delegate:self
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:@"Tentar Novamente", nil];
//        [alertView show];
//    });
//}

@end

// Depreciado
//#pragma mark - UIAlertViewDelegate
//@interface PokemonView (UIAlertViewDelegateCategory)<UIAlertViewDelegate>
//@end
//
//@implementation PokemonView (UIAlertViewDelegateCategory)
//- (void) alertView: (UIAlertView *) alertView clickedButtonAtIndex: (NSInteger) buttonIndex {
//    if (buttonIndex == 0) {
//        NSLog(@"Click");
//    }
//}
//@end

#pragma mark - UITableViewDataSource
@interface PokemonView (PokemonViewDataSourceCategory)<UITableViewDataSource>
@end

@implementation PokemonView (PokemonViewDataSourceCategory)

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    return _viewModel.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                      reuseIdentifier: cellIdentifier];
    }

    cell.textLabel.text = _viewModel[indexPath.row].name;
    cell.contentView.backgroundColor = _viewModel[indexPath.row].color;

    return cell;
}

@end

#pragma mark - UITableViewDelegate
@interface PokemonView (PokemonViewTableDelegateCategory)<UITableViewDelegate>
@end

@implementation PokemonView (PokemonViewTableDelegateCategory)

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    [self didTapReady](indexPath.row);
}

@end
