//
//  TwitterStatusCell.m
//  TwitterStreamer
//
//  Created by arty on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterStatusCell.h"
#import "Twitter.h"
#import "TwitterUser.h"

@implementation TwitterStatusCell

@synthesize avatarImageView;
@synthesize nameLabel;
@synthesize screenLabel;
@synthesize dateLabel;
@synthesize textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style
				reuseIdentifier:reuseIdentifier];	
	return self;
}

- (void)setupWithTwitterStatus:(Twitter *)twitterStatus twitterUser:(TwitterUser *)twitterUser {
	// update date
	[twitterStatus updateDatePresentation];
	
	avatarImageView.image = twitterUser.image;
	nameLabel.text = twitterUser.name;
	screenLabel.text = twitterUser.screenName;
	dateLabel.text = (twitterStatus.isCreatedToday ? twitterStatus.createdAtAsTimeAgo : twitterStatus.createdAt);
	textLabel.text = twitterStatus.text;	
	
	[self setupUI];
}

- (void)setupUI {
	// update screen name label's height
    CGSize expectedLabelSize = [screenLabel.text sizeWithFont: screenLabel.font];
	CGRect newFrame = screenLabel.frame;
	newFrame.size.width = expectedLabelSize.width;
	newFrame.size.height = expectedLabelSize.height;
    screenLabel.frame = newFrame;
	
	//date string
    dateLabel.textAlignment = UITextAlignmentRight;
    expectedLabelSize = [dateLabel.text sizeWithFont: dateLabel.font];
	newFrame = dateLabel.frame;
	newFrame.size.width = expectedLabelSize.width;
	newFrame.size.height = expectedLabelSize.height;
	newFrame.origin.x = 320 - expectedLabelSize.width - 5;
    dateLabel.frame = newFrame;
	
	newFrame = nameLabel.frame;
	newFrame.size.width = 320 - dateLabel.frame.size.width - screenLabel.frame.size.width - 50 - 10;
	newFrame.origin.x = screenLabel.frame.origin.x + screenLabel.frame.size.width + 2;
    nameLabel.frame = newFrame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {    
    [super setSelected:selected animated:animated];
}


- (void)dealloc {
	// ui elements
	[avatarImageView release];
	[nameLabel release];
	[screenLabel release];
	[dateLabel release];
	[textLabel release];
	
    [super dealloc];
}

@end
