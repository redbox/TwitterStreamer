//
//  TwitterStatus.m
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Twitter.h"


@implementation Twitter

@synthesize uid;
@synthesize userId;
@synthesize text;
@synthesize isCreatedToday;
@synthesize isCreatedYersterday;
@synthesize createdAtSource;
@synthesize createdAtAsTimeAgo;
@synthesize createdAt;

- (NSInteger) compareTwitters:(Twitter *) anotherTwitter
{
	unsigned long long selfUid = [[self uid] longLongValue];
	unsigned long long anotherUid = [[anotherTwitter uid] longLongValue];
	if (selfUid > anotherUid)
		return NSOrderedAscending;
	else if (selfUid < anotherUid)
	{
		return NSOrderedDescending;
	}
	else {
		return NSOrderedSame;
	}
}

- (void) setCreatedAtSource:(NSString *) input{
    [createdAtSource autorelease];
	createdAtSource = [input retain];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss +0000 yyyy"];
	date = [dateFormatter dateFromString: self.createdAtSource];
	
	NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
	
	NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;	
	NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
	date = destinationDate;
	
	[dateFormatter setDateFormat:@"dd MMM HH:mm"];
	self.createdAt = [dateFormatter stringFromDate: date];
	[dateFormatter release];
	
	[self updateDatePresentation];
}

- (void) updateDatePresentation {	
	NSTimeInterval time = fabs([date timeIntervalSinceNow]);
	int seconds = trunc(time);
	int minutes = trunc(time / 60);
	int hours = trunc(minutes / 60);
	NSString *timeAsAgo;
	if (hours != 0) {
		timeAsAgo = [[NSString alloc] initWithFormat: @"%d hours ago", hours];
	} else if (minutes != 0) {
		timeAsAgo = [[NSString alloc] initWithFormat: @"%d minutes ago", minutes];		
	} else {
		timeAsAgo = [[NSString alloc] initWithFormat: @"%d seconds ago", seconds];		
	}
	self.createdAtAsTimeAgo = timeAsAgo;
	[timeAsAgo release];

	// if today
	self.isCreatedToday = (hours < 24);
	self.isCreatedYersterday = ((hours >= 24) && (hours < 48));
}

- (void)dealloc {
	[uid release];
	[date release];
	[text release];
	[createdAtSource release];
	[createdAt release];
	[createdAtAsTimeAgo release];
	[super dealloc];
}

@end
