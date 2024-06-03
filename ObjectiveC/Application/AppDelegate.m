#import "AppDelegate.h"
#import "PokemonCoordinator.h"

@interface AppDelegate ()
@property(nonatomic) PokemonCoordinator *coordinator;
@end

@implementation AppDelegate

- (BOOL)application: (UIApplication *) application
        didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navigationController = [[UINavigationController alloc] init];
    PokemonCoordinator *coordinator = [[PokemonCoordinator alloc] initWithNavigationController: navigationController];
    self.coordinator = coordinator;
    [coordinator start];
    [self.window setRootViewController: navigationController];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
