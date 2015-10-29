//
//  MatchCollectionViewCell.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "MatchCollectionViewCell.h"
#import "RemoteImageHelper.h"

@interface MatchCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *localTeamImageView;

@property (nonatomic, strong) IBOutlet UILabel *localTeamNameLabel;

@property (nonatomic, strong) IBOutlet UIImageView *awayTeamImageView;

@property (nonatomic, strong) IBOutlet UILabel *awayTeamNameLabel;

@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scoreWidthConstraint;

@end

@implementation MatchCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.layer.cornerRadius = 20.0;
    
    [self configureFocus];
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    
    [self configureFocus];
}

- (void)setMatch:(Match *)match {
    
    _match = match;
    
    if (match) {
        
        [self configureFocus];
        
        self.localTeamNameLabel.text = match.localTeam.name;
        self.awayTeamNameLabel.text = match.awayTeam.name;
        
        if (match.localScore && match.awayScore && ![match.localScore isKindOfClass:[NSNull class]] && ![match.awayScore isKindOfClass:[NSNull class]]) {
            
            self.scoreLabel.text = [NSString stringWithFormat:@"%ld - %ld", match.localScore.integerValue, match.awayScore.integerValue];
            
        } else {
            
            self.scoreLabel.text = nil;
        }
        
        
        NSURL *localSlugURL = [NSURL URLWithString:[match.localTeam slugURL]];
        [[RemoteImageHelper sharedInstance] remoteImageFromURL:localSlugURL onCompleted:^(UIImage *image) {
            self.localTeamImageView.image = image;
        }];
        
        NSURL *awaySlugURL = [NSURL URLWithString:[match.awayTeam slugURL]];
        [[RemoteImageHelper sharedInstance] remoteImageFromURL:awaySlugURL onCompleted:^(UIImage *image) {
            self.awayTeamImageView.image = image;
        }];
    }
}

- (void)configureFocus {
    
    if (self.focused) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.scoreWidthConstraint.constant = 140;
        self.localTeamNameLabel.font = [UIFont boldSystemFontOfSize:30];
        self.awayTeamNameLabel.font = [UIFont boldSystemFontOfSize:30];
    } else {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.scoreWidthConstraint.constant = 220;
        self.localTeamNameLabel.font = [UIFont boldSystemFontOfSize:20];
        self.awayTeamNameLabel.font = [UIFont boldSystemFontOfSize:20];
    }
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
    [coordinator addCoordinatedAnimations:^{
        
        [self configureFocus];
        
    } completion:nil];
}

@end
