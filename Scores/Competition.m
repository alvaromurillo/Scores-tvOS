//
//  Competition.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "Competition.h"

@implementation Competition

- (instancetype)initFromDictionary:(NSDictionary *)dict {
    
    self = [self init];
    
    if (self) {
        
        self.name = dict[@"name"];
        self.competitionId = dict[@"id"];
        
        NSMutableArray *rounds = [NSMutableArray array];
        
        for (NSDictionary *roundDict in dict[@"rounds"]) {
            
            Round *round = [[Round alloc] initFromDictionary:roundDict];
            
            [rounds addObject:round];
        }
        
        NSDictionary *activeRoundDict = dict[@"active_round"];
        
        if (activeRoundDict) {
            
            self.activeRoundNumber = activeRoundDict[@"round_number"];
        }
        
        self.rounds = [rounds sortedArrayUsingComparator:^NSComparisonResult(Round *round1, Round *round2) {
            
            return [round1.startDate compare:round2.startDate];
        }];
    }
    
    return self;
}

- (Round *)activeRound {
    
    if (self.activeRoundNumber) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number = %d", self.activeRoundNumber.integerValue];
        return [[self.rounds filteredArrayUsingPredicate:predicate] firstObject];
    }
    
    return nil;
}

+ (void)loadCompetitionsOnCompleted:(void (^)(NSArray<Competition *> *competitions, NSError *error))onCompleted {
    
    NSURL *url = [NSURL URLWithString:@"http://lfpdata.static.interactivecdn.com.s3.amazonaws.com/data/active_round.json"];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error && data) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableArray *competitions = [NSMutableArray array];
            
            for (NSDictionary *competitionDict in dict[@"competitions"]) {
                
                Competition *competition = [[Competition alloc] initFromDictionary:competitionDict];
                
                if (competition.rounds.count > 1) {
                    
                    [competitions addObject:competition];
                }
            }
            
            if (onCompleted) {
                onCompleted([NSArray arrayWithArray:competitions], nil);
            }
            
        } else {
            
            if (onCompleted) {
                onCompleted(nil, error);
            }
        }
        
    }];
    
    [downloadTask resume];
}

+ (void)loadMatchesForCompetition:(Competition *)competition round:(Round *)round OnCompleted:(void (^)(NSArray<Match *> *matches, NSError *error))onCompleted {
    
    NSString *urlString = [NSString stringWithFormat:@"http://lfpdata.static.interactivecdn.com.s3.amazonaws.com/data/matches/competitions/matches_%ld_%ld.json", competition.competitionId.integerValue, round.number.integerValue];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error && data) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableArray *matches = [NSMutableArray array];
            
            for (NSDictionary *matchDict in dict[@"matches"][@"match"]) {
                
                Match *match = [Match new];
                
                match.matchId = matchDict[@"id_partido"];
                
                match.localTeam = [Team new];
                match.localTeam.name = matchDict[@"local_team"];
                match.localTeam.slug = matchDict[@"local_team_slug"];
                
                match.awayTeam = [Team new];
                match.awayTeam.name = matchDict[@"away_team"];
                match.awayTeam.slug = matchDict[@"away_team_slug"];
                
                match.localScore = matchDict[@"local_score"];
                match.awayScore = matchDict[@"away_score"];
                
                [matches addObject:match];
            }
            
            if (onCompleted) {
                onCompleted([NSArray arrayWithArray:matches], nil);
            }
            
        } else {
            
            if (onCompleted) {
                onCompleted(nil, error);
            }
        }
        
    }];
    
    [downloadTask resume];

}

@end
