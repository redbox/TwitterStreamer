//
//  TwitterUser.m
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterUser.h"

@implementation TwitterUser

@synthesize uid;
@synthesize name;
@synthesize screenName;
@synthesize imageUrl;
@synthesize image;

- (void)dealloc {
	[name release];
	[screenName release];
	[imageUrl release];	
	[image release];
	[super dealloc];
}

@end
