//
//  RootViewController.h
//  TableView
//
//  Created by Justin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
@class DetailViewController;

@interface RootViewController : UITableViewController {
    
    NSMutableArray* patternArray;
    DetailViewController *detailController;
    InfoViewController *infoView;
    NSNumber* idCounter;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailController;
@property (nonatomic, retain) NSMutableArray *patternArray;
@property(nonatomic, retain) InfoViewController *infoView;
@property(nonatomic, retain) NSNumber *idCounter;

-(IBAction)infoButtonAction:(id)sender;
-(void)readData;
-(void)saveData;

@end
