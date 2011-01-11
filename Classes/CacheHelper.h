//
//  CacheHelper.h
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "TwitterNetworkHelper.h"

/**
 * Delegate is used to notification about progress of current update.
 **/
@protocol CacheHelperDelegate
@required
-(void) processImageUpdateFinished: (NSString *)filePath;
@end

/**
 * Class is used for managing file cache. Cache is used to store user's avatars.
 **/
@interface CacheHelper : NSObject<TwitterNetworkHelperDelegate> {
	
	/** Instance of NetworkHelper **/
	TwitterNetworkHelper *networkHelper;
	
	/** Instance of CacheHelperDelegate **/
	id<CacheHelperDelegate> delegate;
	
	/** Error, which may occur **/
	NSError *error;
	
	/** Path to cache folder **/
	NSString *dataPath;
	
	/** Path to target image **/
	NSString *filePath;
}

/** Properties **/

@property (nonatomic, retain) NSString* dataPath;
@property (nonatomic, retain) NSString* filePath;
@property (nonatomic, retain) id delegate;

/**
 * Initialize instance with specified delegate
 * @param aDelegate Delegate which recieving update notifications.
 * @return Initialized instance
 **/
- (CacheHelper *) initWithDelegate:(id<CacheHelperDelegate>) aDelegate;

/**
 * Updates cache for target url. Downloads image provided by url  and saves it at disk, if needed.
 **/
- (void) updateCacheForUrl:(NSString*) urlAsString;

/**
 * Simple cache initialization.
 **/
- (void) initCache;

/**
 * Clear file system's cache.
 */
- (void) clearCache;

@end
