//
//  CacheHelper.h
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "TwitterNetworkHelper.h"

@protocol CacheHelperDelegate
@required
-(void) processImageUpdateFinished: (NSString *)filePath;
@end

@interface CacheHelper : NSObject<TwitterNetworkHelperDelegate> {
	TwitterNetworkHelper *networkHelper;
	id<CacheHelperDelegate> delegate;
	NSError *error;
	NSString *dataPath;
	NSString *filePath;
}

@property (nonatomic, retain) NSString* dataPath;
@property (nonatomic, retain) NSString* filePath;
@property (nonatomic, retain) id delegate;

- (CacheHelper *) initWithDelegate:(id<CacheHelperDelegate>) aDelegate;
- (void) updateCacheForUrl:(NSString*) urlAsString;
- (void) initCache;
- (void) clearCache;

@end
