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

/**
 * Delegate is used to notification about ending of current operation.
 **/
@protocol TwitterServiceDelegate<NSObject>
@required

/**
 * When get twittter user API request is completed, method is invoked.
 **/
- (void) processTwitterUser:(TwitterUser *) user;

/**
 * When get twittters by user API request is completed, method is invoked.
 **/
- (void) processTwitterCollection:(NSArray *) twitters;
@end

/**
 * TwitterService is used to encapsulate all logic for fetching twitter's user and statuses through API.
 **/
@interface TwitterService : NSObject<TwitterNetworkHelperDelegate> {
	
	/** Instance of TwitterServiceDelegate **/
	id <TwitterServiceDelegate> delegate;	
	
	/** Builder for TwitterUser objects **/
	TwitterUserBuilder *userBuilder;
	
	/** Builder for twitters statuses **/
	TwittersBuilder *twittersBuilder;
	
	/** Network helper **/
	TwitterNetworkHelper *networkHelper;
	
	/**  Indicates that service already has network request **/
	BOOL isHelperBusy;
	
	/** Define request type. If YES - getUserApiRequest, getTwwiters otherside **/
	BOOL isGettingUser;
}

/** Properties **/
 
@property (nonatomic, retain) id delegate;

/**
 * Initialize instance with specified delegate
 * @param aDelegate Target delegate
 * @return initialized instance
 **/
- (TwitterService *) initWithDelegate:(id) aDelegate;

/**
 * Starts getUserByName API request
 * @param name User's name
 **/
- (void) startUserByNameApiRequest:(NSString*) name;

/**
 * Starts TwittersByUserId API request. Only statuses which was added after target will fetched.
 * @param userId User's id
 * @param sinceId UID Target status's id
 **/
- (void) startTwittersByUserIdApiRequest:(NSInteger) userId sinceId: (NSNumber *) sinceId;

/**
 * Starts TwittersByUserId API request. Only statuses which was added before target will fetched.
 * @param userId User's id
 * @param beforeId UID Target status's id
 **/
- (void) startTwittersByUserIdApiRequest:(NSInteger) userId beforeId: (NSNumber *) beforeId;

@end
