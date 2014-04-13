//
//  NoteListTableViewController.h
//  Notepad
//
//  Created by Edisonthk on 4/13/14.
//  Copyright (c) 2014 Edisonthk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Notes.h"
#import "NoteEditViewController.h"

@interface NoteListTableViewController : UITableViewController

@property (nonatomic, retain)AppDelegate *app;

-(IBAction)unwindToList:(UIStoryboardSegue*)segue;

@end
