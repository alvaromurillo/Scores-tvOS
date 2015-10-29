//
//  RemoteImageHelper.m
//  Scores
//
//  Created by Álvaro Murillo del Puerto on 29/10/15.
//  Copyright © 2015 Alvaro Murillo. All rights reserved.
//

#import "RemoteImageHelper.h"

@interface RemoteImageHelper ()

@property (nonatomic, strong) NSMutableDictionary *memoryCache;

@end

@implementation RemoteImageHelper

// Get the shared instance and create it if necessary.
+ (id)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static RemoteImageHelper *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (NSMutableDictionary *)memoryCache {
    
    if (!_memoryCache) {
        _memoryCache = [NSMutableDictionary dictionary];
    }
    
    return _memoryCache;
}

- (void)remoteImageFromURL:(NSURL *)imageURL onCompleted:(void(^)(UIImage *image))onCompleted {
    
    UIImage *image = self.memoryCache[[imageURL absoluteString]];
    
    if (!image) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                
                self.memoryCache[[imageURL absoluteString]] = image;
                
                if (onCompleted) {
                    onCompleted(image);
                }
                
            });
            
        });
        
    } else {
        
        if (onCompleted) {
            onCompleted(image);
        }
    }
    
}

@end
