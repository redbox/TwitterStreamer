//
//  TwitterStatusCollection.h
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterService.h"
#import "CacheHelper.h"

@class TwitterUser;
@class Twitter;

@protocol TwitterCollectionDelegate<NSObject> 
@required
- (void) updateStarted;
- (void) updateStopped;
@end


@interface TwitterCollection : NSObject<TwitterServiceDelegate, CacheHelperDelegate> {
	TwitterService *service;
	CacheHelper *cacheHelper;
	id <TwitterCollectionDelegate> delegate;
	
	// User related data
	NSString *userName;
	TwitterUser *twitterUser;
	UIImage *userAvatar;

	// Twitters related data
	NSMutableArray *todaysTwitters;
	NSMutableArray *yesterdayTwitters;
	NSMutableArray *earlyTwitters;	
	
	unsigned long long lastTwitterId;
	unsigned long long firstTwitterId;
}

@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) TwitterUser *twitterUser;
@property (nonatomic, retain) id delegate;

- (TwitterCollection *) initWithUserName: (NSString *) userName delegate: (id) delegate;

- (void) loadAvailableTwitters;
- (void) updateLaterTwitters;

- (NSInteger) totalCount;
- (NSInteger) countTodayCreatedTwitters;
- (NSInteger) countYesterdayCreatedTwitters;
- (NSInteger) countEarlierCreatedTwitters;
- (Twitter *) todayTwitterByIndex: (NSInteger) index;
- (Twitter *) yesterdayTwitterByIndex: (NSInteger) index;
- (Twitter *) earlierTwitterByIndex: (NSInteger) index;

@end
