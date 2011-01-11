//
//  TwitterApiHelper.h
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwitterNetworkHelperDelegate<NSObject>
@required
- (void) processApiResponse:(NSData*) response;
- (void) processApiNetworkError:(NSError*) error;
@end

@interface TwitterNetworkHelper : NSObject {
	NSMutableData *webData;
	NSURLConnection *connection;
	id <TwitterNetworkHelperDelegate> delegate;
}

@property (nonatomic, retain) id delegate;

- (TwitterNetworkHelper *) initWithDelegate:(id) delegate;
- (void) getTwitterUserByNameAsXml:(NSString*) userName;
- (void) getTwittersByUserIdAsXml:(NSInteger) userId sinceId:(NSNumber *) sinceId;
- (void) getContentByUrl: (NSURL*) url;

@end
