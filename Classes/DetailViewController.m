//
//  DetailViewController.m
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Twitter.h"
#import "TwitterUser.h"

#define LABEL_WIDTH 303

@implementation DetailViewController

@synthesize textLabel;
@synthesize dateLabel;
@synthesize userLabel;
@synthesize avatarImageView;
@synthesize twitterStatus;
@synthesize twitterUser;
@synthesize twitterImageView;
@synthesize bottomLineLabel;

- (void) setTwitterStatus: (Twitter *) status andUser: (TwitterUser *) user {
	self.twitterStatus = status;
	self.twitterUser = user;
}

- (void)viewWillAppear:(BOOL)animated {
	dateLabel.text = twitterStatus.createdAt;
	avatarImageView.image = twitterUser.image;
	userLabel.text = twitterUser.name;
	textLabel.text = twitterStatus.text;
	
	[self updateUI];
	
    [super viewWillAppear:animated];
}

- (void) updateUI {
	// update text label's height
    textLabel.textAlignment = UITextAlignmentLeft;
    textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    CGSize expectedLabelSize = [textLabel.text sizeWithFont:textLabel.font 
												   forWidth:LABEL_WIDTH
											  lineBreakMode:UILineBreakModeCharacterWrap];	
    CGRect newFrame = textLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
	newFrame.size.width = LABEL_WIDTH;
    textLabel.frame = newFrame;
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
	
	// bottom line, date and others...	
	newFrame = bottomLineLabel.frame;
	newFrame.origin.y = textLabel.frame.origin.y + textLabel.frame.size.height;
	bottomLineLabel.frame = newFrame;
	
	newFrame = dateLabel.frame;
	newFrame.origin.y = bottomLineLabel.frame.origin.y + bottomLineLabel.frame.size.height;
	dateLabel.frame = newFrame;
	
	newFrame = twitterImageView.frame;
	newFrame.origin.y = dateLabel.frame.origin.y + 10;
	twitterImageView.frame = newFrame;	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[avatarImageView release];
	[bottomLineLabel release];
	[twitterImageView release];
	[twitterStatus release];
	[twitterUser release];
	[textLabel release];
	[dateLabel release];
    [super dealloc];
}


@end
