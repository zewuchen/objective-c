#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokemonTableViewCell.h"

@interface PokemonTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *pokemonImageView;
@end

@implementation PokemonTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle) style
               reuseIdentifier:(NSString *) reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    self.titleLabel = [[UILabel alloc] init];
    self.pokemonImageView = [[UIImageView alloc] init];
    self.pokemonImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self buildViewHierarchy];
    [self setupConstraints];
    return self;
}

- (void) buildViewHierarchy {
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.pokemonImageView];
}

- (void) setupConstraints {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.pokemonImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.pokemonImageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 0],
        [self.pokemonImageView.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 12],
        [self.pokemonImageView.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: 0],
        [self.pokemonImageView.widthAnchor constraintEqualToConstant: 40],
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.pokemonImageView.trailingAnchor constant: 20],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor],
    ]];
}

- (void) loadImage {
    /*
     Synchronous URL loading of https://... should not occur on this application's main thread as it may lead to UI unresponsiveness. Please switch to an asynchronous networking API such as URLSession.

    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
    self.pokemonImageView.image = image;
     */

    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error) {
        __weak typeof(self) weakSelf = self;

        if (!error && weakSelf) {
            UIImage *image = [UIImage imageWithData: data];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.pokemonImageView.image = image;
            });
        }
    }];
    [task resume];
}

- (void) showData: (PokemonViewModel *) data {
    _titleLabel.text = data.name;
    self.contentView.backgroundColor = data.color;
    [self loadImage];
}

@end
