#import <UIKit/UIKit.h>
#include "../Model/PokemonViewModel.h"

@interface PokemonTableViewCell: UITableViewCell

-(void) showData: (PokemonViewModel *) data;

@end
