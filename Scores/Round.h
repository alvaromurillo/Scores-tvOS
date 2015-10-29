//
//  Round.h
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Round : NSObject

@property (nonatomic, strong) NSNumber *number;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSDate *endDate;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end
