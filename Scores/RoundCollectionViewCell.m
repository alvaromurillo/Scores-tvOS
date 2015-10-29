//
//  RoundCollectionViewCell.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "RoundCollectionViewCell.h"

@interface RoundCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *roundLabel;

@end

@implementation RoundCollectionViewCell

- (void)awakeFromNib {
 
    [super awakeFromNib];
    
    [self configureFocus];
}

- (void)setRound:(Round *)round {
    
    _round = round;
    
    [self configureFocus];
    
    if (round) {
        
        self.roundLabel.text = round.name;
    }
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    if (selected) {
        
        self.roundLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
    } else {
        
        self.roundLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
}

- (void)configureFocus {
    
    if (self.focused) {
        
        self.roundLabel.font = [UIFont boldSystemFontOfSize:60];
        
    } else {
        
        self.roundLabel.font = [UIFont boldSystemFontOfSize:40];
    }
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
    [coordinator addCoordinatedAnimations:^{
        
        [self configureFocus];
        
    } completion:nil];
}

@end
