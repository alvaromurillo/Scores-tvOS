//
//  Team.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "Team.h"

@implementation Team

- (NSString *)slugURL {
    
    return [NSString stringWithFormat:@"http://lfpdata.static.interactivecdn.com.s3.amazonaws.com/images/shields/%@.png", self.slug];
}

@end
