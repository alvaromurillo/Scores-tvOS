//
//  Match.h
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Match : NSObject

@property (nonatomic, strong) NSNumber *matchId;

@property (nonatomic, strong) Team *localTeam;

@property (nonatomic, strong) Team *awayTeam;

@property (nonatomic, strong) NSNumber *localScore;

@property (nonatomic, strong) NSNumber *awayScore;

@end
