//
//  TwitterService.h
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterNetworkHelper.h"

@class TwitterUser;
@class Twitter;
@class TwitterUserBuilder;
@class TwittersBuilder;

@protocol TwitterServiceDelegate<NSObject>
@required
- (void) processTwitterUser:(TwitterUser *) user;
- (void) processTwitterCollection:(NSArray *) twitters;
@end

@interface TwitterService : NSObject<TwitterNetworkHelperDelegate> {
	id <TwitterServiceDelegate> delegate;	
	TwitterUserBuilder *userBuilder;
	TwittersBuilder *twittersBuilder;
	TwitterNetworkHelper *networkHelper;
	BOOL isHelperBusy;
	BOOL isGettingUser;
}

@property (nonatomic, retain) id delegate;

- (TwitterService *) initWithDelegate:(id) aDelegate;
- (void) startUserByNameApiRequest:(NSString*) name;
- (void) startTwittersByUserIdApiRequest:(NSInteger) userId sinceId: (NSNumber *) sinceId;

@end
