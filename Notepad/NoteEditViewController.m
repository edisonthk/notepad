//
//  NoteEditViewController.m
//  Notepad
//
//  Created by Edisonthk on 4/13/14.
//  Copyright (c) 2014 Edisonthk. All rights reserved.
//

#import "NoteEditViewController.h"

@interface NoteEditViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *bodyTextField;

@property Notes* currentNote;

@end

@implementation NoteEditViewController


@synthesize note;
@synthesize app;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app = [[UIApplication sharedApplication]delegate];
    
    if(self.note != nil){
        
        self.titleTextField.text = self.note.title;
        self.bodyTextField.text = self.note.body;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender == self.saveButton){
    
    if(self.titleTextField.text.length > 0 && self.bodyTextField.text.length > 0){
        // instance context
        NSManagedObjectContext *context = app.managedObjectContext;
        
        if(self.note == nil){
            
            // insert
            Notes* n = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
            
            n.title = self.titleTextField.text;
            n.body = self.bodyTextField.text;
            
            // checking error of insert data
            NSError *error;
            
            if(![context save:&error]){
                NSLog(@"Error! %@",error);
            }
            
        }else{
            // update
            [self.note setValue:self.titleTextField.text forKey:@"title"];
            [self.note setValue:self.bodyTextField.text forKey:@"body"];
            
            // checking error of insert data
            NSError *error;
            
            if([context hasChanges] && ![context save:&error]){
                NSLog(@"Error! %@",error);
            }
        }
        
    }
    }
    
}

-(void)setCurrentItem: (Notes*)currentItem{
    self.currentNote = currentItem;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
