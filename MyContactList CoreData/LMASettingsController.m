//
//  LMASettingsController.m
//  MyContactList CoreData
//
//  Created by Greenlee, Barb on 5/19/14.
//  Copyright (c) 2014 Learning Mobile Apps. All rights reserved.
//


#import "LMASettingsController.h"
#import "Constants.h"

@interface LMASettingsController ()

@end

@implementation LMASettingsController
NSArray *sortOrderItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    sortOrderItems = @[@"Name", @"City", @"Birthday", @"State", @"Zip"];
    _pckSortField.dataSource = self;
    _pckSortField.delegate = self;
    // Set the UI based on values in NSUserDefaults
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    BOOL sortAscending = [settings boolForKey:kSortDirectionAscending];
    //[_swAscending setOn:sortAscending];
    //Sets segment controller based on stored preferences
    if(sortAscending)
    _swAscending.selectedSegmentIndex = 0;
    else
        _swAscending.selectedSegmentIndex = 1;
    NSString *sortField = [settings objectForKey:kSortField];
    int i = 0;
    for(NSString *field in sortOrderItems){
        if([field isEqualToString:sortField]){
            [_pckSortField selectRow:i inComponent:0 animated:NO];
        }
        i++;
    }
    [_pckSortField reloadComponent:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sortDirectionChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setBool:_swAscending.isOn forKey:kSortDirectionAscending];
    // Save to user preferences if sort direction changed
    if(_swAscending.selectedSegmentIndex==0)
        [defaults setBool: true forKey:kSortDirectionAscending];
    else
        [defaults setBool: false forKey:kSortDirectionAscending];
}

#pragma mark - UIPickerView DataSource
// Returns # of 'columns' to display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Returns # of 'rows' in the picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sortOrderItems count];
}

// Sets the value that is shown for each row in the picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sortOrderItems objectAtIndex:row];
}

// If the user chooses from the pickerview, it calls this function
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *sortField = [sortOrderItems objectAtIndex:row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sortField forKey:kSortField];
    [defaults synchronize];
}


@end
