//
//  NoteEditViewController.h
//  Notepad
//
//  Created by Edisonthk on 4/13/14.
//  Copyright (c) 2014 Edisonthk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notes.h"
#import "AppDelegate.h"

@interface NoteEditViewController : UIViewController

@property(nonatomic, retain) AppDelegate* app;

@property(nonatomic, retain) Notes* note;

-(void)setCurrentItem: (Notes*)currentItem;

@end
