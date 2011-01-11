//
//  TwitterApiHelper.h
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Delegate is used to notification about ending of current connection.
 **/
@protocol TwitterNetworkHelperDelegate<NSObject>
@required
/**
 * Method is invoked when response is competed.
 * @param response Response's data.
 **/
- (void) processApiResponse:(NSData*) response;

/**
 * Method is invoked when network error is occured.
 * @param error Network error.
 **/
- (void) processApiNetworkError:(NSError*) error;
@end

/**
 * Used to create connections to remote server.
 **/
@interface TwitterNetworkHelper : NSObject {
	
	/** Data buffer **/
	NSMutableData *webData;
	
	/** Network connection **/
	NSURLConnection *connection;
	
	/** Instance of TwitterNetworkHelperDelegate **/
	id <TwitterNetworkHelperDelegate> delegate;
}

/** Properties **/

@property (nonatomic, retain) id delegate;

/**
 * Initialize instance with target delegate
 * @param delegate Target delegate
 * @return Initizlized instance
 **/
- (TwitterNetworkHelper *) initWithDelegate:(id) delegate;

/**
 * Creates connection with specified url to Twitte REST API, to fetch user object.
 * @param username Username of user to fetch
 **/
- (void) getTwitterUserByNameAsXml:(NSString*) userName;

/**
 * Creates connection with specified url to Twitte REST API, to fetch statuse.
 * Only statuses which was added after target will fetched.
 * @param userId Twitter user's id
 * @param sinceID Target twitter's id
 **/
- (void) getTwittersByUserIdAsXml:(NSInteger) userId sinceId:(NSNumber *) sinceId;

/**
 * Creates connection with specified url to Twitte REST API, to fetch statuses.
 * Only statuses which was added before target will fetched.
 * @param userId Twitter user's id
 * @param beforeId Target twitter's id
 **/
- (void) getTwittersByUserIdAsXml:(NSInteger) userId beforeId:(NSNumber *) beforeId;

/**
 * Creates connection with specified url, to grab response's content.
 * @param url Url to connect
 **/
- (void) getContentByUrl: (NSURL*) url;

@end
