//
//  Team.h
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 28/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Team : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *slug;

@property (nonatomic, strong) UIImage *slugImage;

- (NSString *)slugURL;

@end
