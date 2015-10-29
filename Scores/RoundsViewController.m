//
//  RoundsViewController.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundCollectionViewCell.h"
#import "MatchCollectionViewCell.h"

static NSString * const RoundCollectionViewCellIdentifier = @"RoundCollectionViewCell";
static NSString * const MatchCollectionViewCellIdentifier = @"MatchCollectionViewCell";

@interface RoundsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) IBOutlet UICollectionView *roundsCollectionView;

@property (nonatomic, strong) IBOutlet UICollectionView *matchesCollectionView;

@property (nonatomic, strong) Round *currentRound;

@property (nonatomic, strong) NSArray *currentRoundMatches;

@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.roundsCollectionView.remembersLastFocusedIndexPath = YES;
    self.matchesCollectionView.remembersLastFocusedIndexPath = YES;
    
    self.roundsCollectionView.allowsSelection = YES;
    self.matchesCollectionView.allowsSelection = YES;
    
    [Competition loadCompetitionsOnCompleted:^(NSArray<Competition *> *competitions, NSError *error) {
        
        self.competition = [competitions firstObject];
        self.currentRound = [self.competition.rounds firstObject];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self.roundsCollectionView reloadData];
            
            Round *activeRound = [self.competition activeRound];
            
            if (activeRound) {
                
                [self loadRound:activeRound];
                
                [self selectCurrentRound];
            }
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCompetition {
    
    
}

- (void)loadRound:(Round *)round {
    
    self.currentRound = round;
    
    [Competition loadMatchesForCompetition:self.competition round:self.currentRound OnCompleted:^(NSArray<Match *> *matches, NSError *error) {
        
        self.currentRoundMatches = matches;
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self.matchesCollectionView reloadData];
        });
    }];
}

- (void)selectCurrentRound {
    
    NSInteger roundIndex = [self.competition.rounds indexOfObject:self.currentRound];
    
    if (roundIndex != NSNotFound) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:roundIndex inSection:0];
        [self.roundsCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark – UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.roundsCollectionView) {
        return self.competition.rounds.count;
    } else {
        return self.currentRoundMatches.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.roundsCollectionView) {
        
        RoundCollectionViewCell *roundCell = [collectionView dequeueReusableCellWithReuseIdentifier:RoundCollectionViewCellIdentifier forIndexPath:indexPath];
        
        return roundCell;
        
    } else {
        
        MatchCollectionViewCell *matchCell = [collectionView dequeueReusableCellWithReuseIdentifier:MatchCollectionViewCellIdentifier forIndexPath:indexPath];
        
        return matchCell;
    }
}

#pragma mark – UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.roundsCollectionView) {
        
        ((RoundCollectionViewCell *)cell).round = self.competition.rounds[indexPath.row];
        
    } else if (collectionView == self.matchesCollectionView) {
        
        ((MatchCollectionViewCell *)cell).match = self.currentRoundMatches[indexPath.row];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.roundsCollectionView) {
        
        Round *round = self.competition.rounds[indexPath.row];
        [self loadRound:round];
    }
}

- (NSIndexPath *)indexPathForPreferredFocusedViewInCollectionView:(UICollectionView *)collectionView {
    
    if (collectionView == self.roundsCollectionView) {
        
        if (self.currentRound) {
            NSInteger roundIndex = [self.competition.rounds indexOfObject:self.currentRound];
            
            if (roundIndex != NSNotFound) {
                
                return [NSIndexPath indexPathForRow:roundIndex inSection:0];
            }
        }
    }
    
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark – UICollectionViewDelegateFlowLayout




@end
