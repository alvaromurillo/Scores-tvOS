//
//  Competition.h
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Round.h"
#import "Match.h"

@interface Competition : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *competitionId;

@property (nonatomic, strong) NSArray<Round *> *rounds;

@property (nonatomic, strong) NSNumber *activeRoundNumber;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

- (Round *)activeRound;

+ (void)loadCompetitionsOnCompleted:(void (^)(NSArray<Competition *> *competitions, NSError *error))onCompleted;

+ (void)loadMatchesForCompetition:(Competition *)competition round:(Round *)round OnCompleted:(void (^)(NSArray<Match *> *matches, NSError *error))onCompleted;

@end
