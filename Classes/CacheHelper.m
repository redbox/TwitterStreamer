//
//  CacheHelper.m
//  TwitterStreamer
//
//  Created by arty on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CacheHelper.h"

#define CACHE_DIR @"AvatarCache"

@implementation CacheHelper

@synthesize dataPath;
@synthesize filePath;
@synthesize delegate;

- (CacheHelper *) initWithDelegate:(id<CacheHelperDelegate>) aDelegate {
	self = [self init];
	if (self) {
		[self initCache];
		self.delegate = aDelegate;
		networkHelper = [[TwitterNetworkHelper alloc] initWithDelegate: self];
	}
	return self;
}

- (void) updateCacheForUrl:(NSString*) urlAsString {
	NSURL *url = [[NSURL alloc] initWithString: urlAsString];
	NSString *fileName = [[url path] lastPathComponent];
	self.filePath = [dataPath stringByAppendingPathComponent:fileName];
	if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
		[networkHelper getContentByUrl:url];
	} else {
		if (delegate) {
			[delegate processImageUpdateFinished:self.filePath];
		}
	}
	[url release];
}

- (void) processApiResponse:(NSData*) response {
	// save file to disk
	[[NSFileManager defaultManager] createFileAtPath:self.filePath
											contents:response
										  attributes:nil];	
	if (delegate) {
		[delegate processImageUpdateFinished:self.filePath];
	}
}

- (void) processApiNetworkError:(NSError*) error {
	// TODO:
}

- (void) initCache
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.dataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:CACHE_DIR];	
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		return;		
	}	
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&error]) {
		//URLCacheAlertWithError(error);
		return;
	}
}


- (void) clearCache
{
	if (![[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error]) {
		//URLCacheAlertWithError(error);
		return;
	}	
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&error]) {
		//URLCacheAlertWithError(error);
		return;
	}
}

- (void) dealloc {
	[filePath release];
	[networkHelper release];
	[dataPath release];
	[super dealloc];
}

@end
