//
//  RootViewController.m
//  TableView
//
//  Created by Justin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "PatternAddViewController.h"

@implementation RootViewController

@synthesize patternArray;
@synthesize detailController;
@synthesize infoView;
@synthesize idCounter;





- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"VIEW DID LOAD!!");
    
    infoView = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
    infoView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self readData];
    self.title = @"BrainWashMe";
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [infoButton release];
    modalButton.style = UIBarButtonItemStyleBordered;
    [self.navigationItem setLeftBarButtonItem:modalButton animated:YES];
    [modalButton release];
    
    
    /*
     UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
     self.navigationItem.rightBarButtonItem = addButtonItem;
     UIBarButtonItem *trashButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(editButtonSelected:)];
     self.navigationItem.rightBarButtonItem = trashButtonItem;
     */
    
    //[addButtonItem release];
    //[trashButtonItem release];
    
    
    
    // create a toolbar where we can place some buttons
    UIToolbar* toolbar = [[UIToolbar alloc]
                          initWithFrame:CGRectMake(0, 0, 100, 45)];
    //[toolbar setBarStyle: UIBarStyleBlackOpaque];
    
    // create an array for the buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    // add the add button
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    addButtonItem.style = UIBarButtonItemStyleBordered;
    [buttons addObject:addButtonItem];
    [addButtonItem release];
    
    // create a spacer between the buttons
    /*UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
     target:nil
     action:nil];
     [buttons addObject:spacer];
     [spacer release];*/
    
    // create a standard delete button with the trash icon
    
    /*
     UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
     target:self
     action:@selector(deleteAction:)];
     deleteButton.style = UIBarButtonItemStyleBordered;
     [buttons addObject:deleteButton];
     [deleteButton release];
     */
    
    // add an edit button
    [buttons addObject:self.editButtonItem];
    
    
    // put the buttons in the toolbar and release them
    [toolbar setItems:buttons animated:NO];
    [buttons release];
    
    // place the toolbar into the navigation bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:toolbar];
    [toolbar release];
}

-(void)saveData {
    
    // do something sexy
    
    // get paths from root direcory
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    [patternArray writeToFile:plistPath atomically:YES];
    
    
    
    // get the path to our Settings/plist file
	NSString *settingsPath = [documentsPath stringByAppendingPathComponent:@"Settings.plist"];
    // store the current id in an array
    //idCounter = [[NSNumber alloc] initWithInt:1478];  test  ***
    NSArray  *settingsArray = [NSArray arrayWithObject:idCounter];
    [settingsArray writeToFile:settingsPath atomically:YES];
}


-(void)readData {
    // get paths from root direcory
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	// get documents path
	NSString *documentsPath = [paths objectAtIndex:0];
	// get the path to our Data/plist file
	NSString *dataPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    // get the path to our Settings plist file
    NSString *settingsPath = [documentsPath stringByAppendingPathComponent:@"Settings.plist"];
    
    
    
    // check that file exists
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL saveData = false; // do we need to create a new data file in app resources?
    if ([fileManager fileExistsAtPath:dataPath]) {
        NSLog(@"The file exists");
    } else {
        NSLog(@"The file does not exist in docs, looking in main mandle, and saving to docs.");
        // if not in documents, get files from main bundle
        dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        settingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        saveData = true;
    }

    patternArray = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
    NSLog(@"Total Patterns Loaded: %i", [patternArray count]);
    
    int i = 0;
    for (NSMutableDictionary *item in patternArray) {
        NSLog(@"value at index %d: %@", i, item);
        i++;
    }
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:settingsPath];
    idCounter = (NSNumber*)[array objectAtIndex:0];
    //idCounter = [num integerValue];
    NSLog(@"Counter on pattern id %@", idCounter);
    if (saveData) // if we are creating new files for the first time, save the data
        [self saveData];
    
}

-(IBAction)infoButtonAction:(id)sender
{
    [self presentModalViewController:infoView animated:YES];
    NSLog(@"Hello!");
}

- (void)add:(id)sender {
    // To add a new recipe, create a RecipeAddViewController.  Present it as a modal view so that the user's focus is on the task of adding the recipe; wrap the controller in a navigation controller to provide a navigation bar for the Done and Save buttons (added by the RecipeAddViewController in its viewDidLoad method).
    PatternAddViewController *addController = [[PatternAddViewController alloc] initWithNibName:@"PatternAddView" bundle:nil];
    addController.delegate = self;
	
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [addController release];
}


- (void)patternAddViewController:(PatternAddViewController *)patternAddViewController didAddPattern:(NSString *)patternName {
    
    if (patternName) {
        NSMutableDictionary *newPattern = [[NSMutableDictionary alloc] init];
        NSDate *now = [[NSDate alloc] init];
        
        
        // increment the id counter
        int value = [idCounter intValue];
        idCounter = [NSNumber numberWithInt:value + 1];
        NSNumber* newPatternID = idCounter;
        
        [newPattern setObject:patternName forKey:@"Name"];
        [newPattern setObject:now forKey:@"dateModified"];
        [newPattern setObject:newPatternID forKey:@"ID"];
        
        NSInteger index = [self.patternArray count];
        
        [self.patternArray addObject:newPattern];
        [newPattern release];
        
        NSLog(@"Added new pattern.  value: %@", [patternArray objectAtIndex:index]);
        NSLog(@"Looping through new array...");
        for (NSMutableDictionary *dict in patternArray) {
            NSLog(@"value: %@", dict);
        }
        
        NSIndexPath *indexPathOfInsertedCell = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPathOfInsertedCell] withRowAnimation:UITableViewRowAnimationMiddle];
        
        // push detail view controller here !!!!
        
        
        // rewrite to the plist
        [self saveData];
        
    }
    // Dismiss the modal add recipe view controller
    [self dismissModalViewControllerAnimated:YES];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //[self.tableView reloadData];
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = patternArray.count;
    return rows;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIdentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSLog(@"Looking for row: %d", indexPath.row);    
    NSDictionary *itemDic = (NSDictionary *)[self.patternArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [itemDic objectForKey:@"Name"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd"];
    NSDate *now = [itemDic objectForKey:@"dateModified"];
    NSString *dateString = [format stringFromDate:now];
    
    cell.detailTextLabel.font = [UIFont  systemFontOfSize:12];
    cell.detailTextLabel.text = dateString;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        
        NSLog(@"Deleting row: %d", indexPath.row);
        [self.patternArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // save the data
        [self saveData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSLog(@"This shouldn't be reached.  Insert cell in commitEditingStyle reached.");
    }   
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Details for key: %d", indexPath.row);
    NSMutableDictionary *dict = [self.patternArray objectAtIndex:indexPath.row];
    NSString *titleString = [dict objectForKey:@"Name"];
    NSLog(@"Key title: %@", titleString);
    
    NSInteger patID = (NSInteger)[dict objectForKey:@"ID"];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil title:titleString patternID:patID];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release anything that can be recreated in viewDidLoad or on demand.
    // e.g. self.myOutlet = nil;
    self.patternArray = nil;
    idCounter = nil;
    detailController = nil;
    infoView = nil;
}
- (void)dealloc {
    [patternArray release];
    [idCounter release];
    [infoView release];
    [detailController release];
    [super dealloc];
}

@end
