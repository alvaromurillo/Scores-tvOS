//
//  RemoteImageHelper.h
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 29/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface RemoteImageHelper : NSObject

// Get the shared instance and create it if necessary.
+ (id)sharedInstance;

- (void)remoteImageFromURL:(NSURL *)imageURL onCompleted:(void(^)(UIImage *image))onCompleted;

@end
