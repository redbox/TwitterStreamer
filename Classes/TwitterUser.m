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

- (TwitterUser *) initDefault {
	self = [super init];
	if (self) {
		self.uid = 59402420;
		self.name = @"FlatSoft, LLC";
		self.screenName = @"flatsoft";
		self.imageUrl = @"asdasd";
		self.image = nil;
	}
	return self;
}

- (void)dealloc {
	[name release];
	[screenName release];
	[imageUrl release];	
	[image release];
	[super dealloc];
}

@end
