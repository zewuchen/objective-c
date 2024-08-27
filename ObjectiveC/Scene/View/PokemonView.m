#import <UIKit/UIKit.h>
#import "PokemonView.h"
#include "PokemonProtocols.h"

@interface PokemonView ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<PokemonViewModel *> *viewModel;

@property(nonatomic) void(^didTapLoading)(void);
@property(nonatomic) void(^didTapError)(void);
@property(nonatomic) void(^didTapReady)(void);
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
    [self addSubview: self.tableView];
    [self setupConstraints];
    return self;
}

- (void) setupConstraints { 
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
}

- (void) showLoading { }

- (void) showError { }

- (void) showReady: (NSArray<PokemonViewModel *> *) viewModel {
    self.viewModel = viewModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end

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
    NSLog(@"Tapped on row %ld", (long)indexPath.row);
}

@end
