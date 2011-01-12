//
//  RootViewController.m
//  TwitterStreamer
//
//  Created by arty on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

#import "Twitter.h"
#import "TwitterUser.h"

#import "TwitterStatusCell.h"
#import "TwitterNetworkHelper.h"

@implementation ListViewController

@synthesize twitterUserName;
@synthesize twitterUser;

@synthesize twitterView;
@synthesize loadingView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	// load settings
	[self loadSettings];
	//setup UI
	self.title = twitterUserName;
	if (backButton == nil) {
		backButton = [[UIBarButtonItem alloc] initWithTitle: @"Back"
													  style: UIBarButtonItemStylePlain
													 target: nil
													 action: nil];
		self.navigationItem.backBarButtonItem = backButton;
	}	
	// initialize detail view controller
	detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	detailViewController.title = twitterUserName;
	// twitters
	twitterCollection = [[TwitterCollection alloc] initWithUserName:twitterUserName
														   delegate:self];
	[twitterCollection loadAvailableTwitters];
    [super viewDidLoad];
}

- (void) loadSettings {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (![defaults objectForKey:@"accountName"]) {
		[defaults setObject:@"flatsoft" forKey:@"accountName"];
		[defaults synchronize];
	}
	self.twitterUserName = [defaults objectForKey:@"accountName"];
}

- (void) updateStarted {
    [UIView animateWithDuration:0.5
					 animations:^{ 
						 CGRect frame = loadingView.frame;
						 frame.origin.y = 0;
						 loadingView.frame = frame;
						 frame = twitterView.frame;
						 frame.origin.y = 50;
						 twitterView.frame = frame;
					 } 
					 completion:^(BOOL finished){
					 }];	
	UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;	
}

- (void) updateStopped {
    [UIView animateWithDuration:0.5
					 animations:^{ 
						 CGRect frame = loadingView.frame;
						 frame.origin.y = -50;
						 loadingView.frame = frame;
						 frame = twitterView.frame;
						 frame.origin.y = 0;
						 twitterView.frame = frame;
					 } 
					 completion:^(BOOL finished){
					 }];	
	UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;	
	
	[self.twitterView reloadData];
}

- (Twitter *) twitterByIndexPath: (NSIndexPath *) indexPath {
	switch ([indexPath section]) {
		case 0:
			return [twitterCollection todayTwitterByIndex:indexPath.row];
			break;
		case 1:
			return [twitterCollection yesterdayTwitterByIndex:indexPath.row];
			break;
		case 2:
			return [twitterCollection earlierTwitterByIndex:indexPath.row];
			break;
	}
	return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [twitterCollection countTodayCreatedTwitters];			
		case 1:
			return [twitterCollection countYesterdayCreatedTwitters];
		case 2:
			return [twitterCollection countEarlierCreatedTwitters];		
		default:
			return 0;
	}	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TwitterStatusCell";    
    TwitterStatusCell *cell = (TwitterStatusCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier
																 owner:self
															   options:nil];
		cell = (TwitterStatusCell *) [topLevelObjects objectAtIndex:0];
    }
	[cell setupWithTwitterStatus:[self twitterByIndexPath:indexPath]
					 twitterUser:twitterCollection.twitterUser];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return ([twitterCollection countTodayCreatedTwitters] > 0 ? @"Today" : nil);
		case 1:
			return ([twitterCollection countYesterdayCreatedTwitters] > 0 ? @"Yesterday" : nil);
		case 2:
			return ([twitterCollection countEarlierCreatedTwitters] > 0 ? @"Earlier" : nil);
		default:
			return nil;
	}	
}


- (void)scrollViewDidScroll:(UITableView *)scrollView
{
	if (scrollView == self.twitterView) {
		if (scrollView.contentOffset.y < 0) {
			[twitterCollection updateNewTwitters];
		} else if ((scrollView.contentOffset.y + 480) == (scrollView.contentSize.height + 64)) {
			[twitterCollection updateOldTwitters];			
		}
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Twitter *status = [self twitterByIndexPath:indexPath];
	[detailViewController setTwitterStatus:status
								   andUser:twitterCollection.twitterUser];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
	[detailViewController release];
	[backButton release];
	[twitterUserName release];
	[twitterUser release];
	[twitterCollection release];
	[twitterView release];
	[loadingView release];
    [super dealloc];
}


@end

