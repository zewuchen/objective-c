#import <Foundation/Foundation.h>
#import "Network.h"

@interface Network ()

@property(nonatomic, strong) NSString *baseURL;

@end

@implementation Network

- (instancetype) init {
    self = [super init];
    [self setupConfig];
    return self;
}

- (void) setupConfig {
    // Without @synthesize
    _baseURL = @"https://pokeapi.co/api/v2/pokemon";

    // With @synthesize baseURL = _baseURL, it's automatically since Objective-C 2.0
    // self.baseURL = @"https://pokeapi.co/api/v2/pokemon";
}

+ (Network *) shared {
    static Network* shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Network alloc] init];
    });
    return shared;
}

- (void) fetchData:(void (^)(NSDictionary *object, NSError *error)) completion {
    NSURL *url = [NSURL URLWithString: self.baseURL ];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL: url
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }

        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data
                                                             options: 0
                                                               error: &jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }

        completion(json, nil);
    }];

    [dataTask resume];
}

@end
