//
//  TwitterApiHelper.m
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterNetworkHelper.h"

@implementation TwitterNetworkHelper

@synthesize delegate;

- (TwitterNetworkHelper *) initWithDelegate: (id) aDelegate {
	self = [self init];
	if (self) {
		self.delegate = aDelegate;
	}
	return self;
}

- (void) getTwitterUserByNameAsXml:(NSString*) userName {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://api.twitter.com/1/users/show/%@.xml", userName]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
	connection = [[NSURLConnection alloc] initWithRequest:request
												 delegate:self];
	if (connection) {
		webData = [[NSMutableData data] retain];
	}
}

- (void) getTwittersByUserIdAsXml:(NSInteger) userId sinceId:(NSNumber *) sinceId {
	NSURL *url;
	unsigned long long idValue = [sinceId unsignedLongLongValue];
	if (idValue == 0) {
		url = [NSURL URLWithString: [NSString stringWithFormat:
									 @"http://api.twitter.com/1/statuses/user_timeline.xml?user_id=%d&trim_user=true&count=30", userId]];
	} else {
		url = [NSURL URLWithString: [NSString stringWithFormat:
									 @"http://api.twitter.com/1/statuses/user_timeline.xml?user_id=%d&since_id=%llu&trim_user=true&count=30",
									 userId, idValue]];
	}
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
	connection = [[NSURLConnection alloc] initWithRequest:request
												 delegate:self];
	if (connection) {
		webData = [[NSMutableData data] retain];
	}
}

- (void) getContentByUrl: (NSURL*) url {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
	connection = [[NSURLConnection alloc] initWithRequest:request
												 delegate:self];
	if (connection) {
		webData = [[NSMutableData data] retain];
	}
}

- (void) connection:(NSURLConnection *) aConnection didReceiveResponse:(NSURLResponse *) response {	
	[webData setLength: 0];	
}

- (void) connection:(NSURLConnection *) aConnection didReceiveData:(NSData *) data {
	[webData appendData:data];
}

- (void) connection:(NSURLConnection *) aConnection didFailWithError:(NSError *) error {
	[webData release];
	[connection release];
	if (self.delegate) {
		[self.delegate processApiNetworkError: error];
	}	
}

- (void) connectionDidFinishLoading:(NSURLConnection *) aConnection {	
	// release because delegate may initialize additional requests in 'processApiResponse'
	[connection autorelease];
	[webData autorelease];	
	if (self.delegate) {
		[self.delegate processApiResponse: webData];
	}	
}

- (void)dealloc {
	[delegate release];
    [super dealloc];
}

@end
