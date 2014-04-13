//
//  NoteListTableViewController.m
//  Notepad
//
//  Created by Edisonthk on 4/13/14.
//  Copyright (c) 2014 Edisonthk. All rights reserved.
//

#import "NoteListTableViewController.h"

@interface NoteListTableViewController ()

@property NSMutableArray* notes;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation NoteListTableViewController

@synthesize app;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app = [[UIApplication sharedApplication]delegate];
    
    [self loadInitialData];
}

-(void)loadInitialData
{
    
    
    // handle context
    NSManagedObjectContext *context = app.managedObjectContext;
    
    
    
    // reading
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    
    NSArray *arr = [context executeFetchRequest:request error:&error];
    
    self.notes = [[NSMutableArray alloc]init];
    for(Notes *note in arr){
        [self.notes addObject:note];

    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Notes* note = [self.notes objectAtIndex:indexPath.row];
    cell.textLabel.text = note.title;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleMyGesture:)];
    [tableView addGestureRecognizer:recognizer];
    
    return cell;
}

-(IBAction)unwindToList:(UIStoryboardSegue*)segue
{
    [self loadInitialData];
    [self.tableView reloadData];
}



- (void)tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // instance storyboard and get NoteEditViewController
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteEditViewController* controller=[storyboard instantiateViewControllerWithIdentifier:@"NoteEditViewController"];

    
    controller.note = [self.notes objectAtIndex:indexPath.row];
    
    [[self navigationController]pushViewController:controller animated:YES];
    
}

NSIndexPath* longPressedIndexPath;

// listener for long press
-(void)handleMyGesture: (UIGestureRecognizer*) gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        
        // get the row which long selected
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        longPressedIndexPath = indexPath;
        
        Notes *note = [self.notes objectAtIndex:indexPath.row];
        
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:@"削除"
                              message:[NSString stringWithFormat:@"”%@”を削除しますか？",note.title]
                              delegate:self
                              cancelButtonTitle:@"no"
                              otherButtonTitles:@"yes", nil];
        [alert show];
        
        
        
        
    }
    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"yes"]){
        
        Notes *note = [self.notes objectAtIndex:longPressedIndexPath.row];
        
        // delete note
        [app.managedObjectContext deleteObject:note];
        [self loadInitialData];
        [self.tableView reloadData];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue from list screen");

    if(sender == self.addButton){
        NoteEditViewController *destController = [segue destinationViewController];
        destController.note = nil;
    }
    
}

@end
