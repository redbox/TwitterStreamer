//
//  TwitterStatusCollection.m
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterCollection.h"
#import "TwitterUser.h"
#import "Twitter.h"

@implementation TwitterCollection

@synthesize userName;
@synthesize twitterUser;
@synthesize delegate;

- (TwitterCollection *) initWithUserName: (NSString *) aUserName delegate: (id) aDelegate {
	self = [super init];
	if (self) {
		service = [(TwitterService *)[TwitterService alloc] initWithDelegate: self];
		self.delegate = aDelegate;
		self.userName = aUserName;
		todaysTwitters = [[NSMutableArray alloc] init];
		yesterdayTwitters = [[NSMutableArray alloc] init];
		earlyTwitters = [[NSMutableArray alloc] init];
		cacheHelper = [(CacheHelper *)[CacheHelper alloc] initWithDelegate: self];
		
		lastTwitterId = 0;
		firstTwitterId = 0;
	}
	return self;
}

- (void) loadAvailableTwitters {
	if ([service startUserByNameApiRequest: self.userName] == YES) {
		if (delegate) {
			[delegate updateStarted];
		}
	}
}

- (void) updateNewTwitters {
	NSNumber *number = [[[NSNumber alloc] initWithLongLong: lastTwitterId] autorelease];	
	if ([service startTwittersByUserIdApiRequest: self.twitterUser.uid sinceId: number] == YES) {
		if (delegate) {
			[delegate updateStarted];
		}
	}
}

- (void) updateOldTwitters {
	NSNumber *number = [[[NSNumber alloc] initWithLongLong: (firstTwitterId - 1)] autorelease];
	if ([service startTwittersByUserIdApiRequest: self.twitterUser.uid beforeId: number] == YES) {
		if (delegate) {
			[delegate updateStarted];
		}
	}
}

-(void) processImageUpdateFinished: (NSString *)filePath {
	self.twitterUser.image = [[UIImage alloc] initWithContentsOfFile: filePath];
	NSNumber *number = [[[NSNumber alloc] initWithLongLong: lastTwitterId] autorelease];
	[service startTwittersByUserIdApiRequest: self.twitterUser.uid sinceId: number];
}

- (void)processTwitterUser:(TwitterUser *) user {
	self.twitterUser = user;
	// checking user's avatar	
	[cacheHelper updateCacheForUrl: self.twitterUser.imageUrl];	
}

- (void) processTwitterCollection:(NSArray *) twitters {
	for (Twitter *twitter in twitters) {
		if (twitter.isCreatedToday) {
			[todaysTwitters addObject: twitter];
		} else if (twitter.isCreatedYersterday) {
			[yesterdayTwitters addObject: twitter];
		} else {
			[earlyTwitters addObject: twitter];
		}
		// update last and first twitter's id
		unsigned long long twitterId = [twitter.uid unsignedLongLongValue];
		if (twitterId > lastTwitterId) {
			lastTwitterId = twitterId;
		} else if (firstTwitterId == 0) {
			firstTwitterId = twitterId;
		} else if (twitterId < firstTwitterId) {
			firstTwitterId = twitterId;
		}
	}
	[todaysTwitters sortUsingSelector:@selector(compareTwitters:)];
	if (delegate) {
		[delegate updateStopped];
	}
}

- (NSInteger) totalCount {
	return ([todaysTwitters count] + [yesterdayTwitters count] + [earlyTwitters count]);
}

- (NSInteger) countTodayCreatedTwitters {
	return [todaysTwitters count];	
}

- (NSInteger) countYesterdayCreatedTwitters {
	return [yesterdayTwitters count];	
}

- (NSInteger) countEarlierCreatedTwitters {
	return [earlyTwitters count];
}

- (Twitter *) todayTwitterByIndex: (NSInteger) index {
	return [todaysTwitters objectAtIndex: index];
}

- (Twitter *) yesterdayTwitterByIndex: (NSInteger) index {
	return [yesterdayTwitters objectAtIndex: index];
}

- (Twitter *) earlierTwitterByIndex: (NSInteger) index {
	return [earlyTwitters objectAtIndex: index];
}

- (void)dealloc {
	[cacheHelper release];
	[userName release];
	[delegate release];
	[twitterUser release];
	[service release];
	[todaysTwitters release];
	[yesterdayTwitters release];
	[earlyTwitters release];	
	[super dealloc];
}

@end
