//
//  TwitterService.m
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterService.h"

#import "TwittersBuilder.h"
#import "TwitterUserBuilder.h"

@implementation TwitterService

@synthesize delegate;

- (TwitterService *) initWithDelegate:(id) aDelegate {
	self = [self init];
	if (self) {
		self.delegate = aDelegate;
		userBuilder = [[TwitterUserBuilder alloc] init];
		twittersBuilder = [[TwittersBuilder alloc] init];
		networkHelper = [[TwitterNetworkHelper alloc] initWithDelegate: self];
		isGettingUser = NO;
		isHelperBusy = NO;
	}
	return self;
}

- (BOOL) startUserByNameApiRequest:(NSString*) name {
	if (!isHelperBusy) {
		isHelperBusy = YES;
		isGettingUser = YES;
		[networkHelper getTwitterUserByNameAsXml: name];
		return YES;
	} else 	{
		return NO;
	}
}

- (BOOL) startTwittersByUserIdApiRequest:(NSInteger) userId sinceId: (NSNumber *) sinceId;{
	if (!isHelperBusy) {
		isHelperBusy = YES;
		isGettingUser = NO;
		[networkHelper getTwittersByUserIdAsXml: userId sinceId: sinceId];
		return YES;
	} else 	{
		return NO;
	}
}

- (BOOL) startTwittersByUserIdApiRequest:(NSInteger) userId beforeId: (NSNumber *) beforeId {
	if (!isHelperBusy) {
		isHelperBusy = YES;
		isGettingUser = NO;
		[networkHelper getTwittersByUserIdAsXml: userId beforeId: beforeId];
		return YES;
	} else 	{
		return NO;
	}
}

- (void) processApiResponse:(NSData*) response {
	isHelperBusy = NO;	
	if (isGettingUser) { // grab user
		TwitterUser *user = [userBuilder newTwitterUserFromXml:response];
		if (delegate) {
			[delegate processTwitterUser: user];
		}
		[user release];		
	} else { // grab twitters
		NSArray *twitters = [twittersBuilder newTwittersFromXml:response];
		if (delegate) {
			[delegate processTwitterCollection: twitters];
		}
		[twitters release];
	}
}

- (void) processApiNetworkError:(NSError*) error {
	isHelperBusy = NO;	
}

- (void) dealloc {
	[networkHelper release];
	[userBuilder release];
	[twittersBuilder release];
	[delegate release];
	[super dealloc];
}

@end
