//
//  Round.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "Round.h"

@implementation Round

- (instancetype)initFromDictionary:(NSDictionary *)dict {
    
    self = [self init];
    
    if (self) {
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        self.number = dict[@"round_number"];
        self.name = dict[@"round_name"];
        self.startDate = [dateFormatter dateFromString:dict[@"start_date"]];
        self.endDate = [dateFormatter dateFromString:dict[@"end_date"]];
    }
    
    return self;
}

@end
