//
//  dateViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/16/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "dateViewController.h"

@interface dateViewController (){
    NSArray *arr;
    NSString *date;
}
@property (weak, nonatomic) IBOutlet UITableView *tblview;

@end

@implementation dateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    date=@"";
    arr=[NSArray arrayWithObjects:@"monday",@"tuesday",@"wednesday",@"thursday",@"firday", nil];
    _tblview.allowsMultipleSelection=YES;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    //[self.navigationItem.backBarButtonItem setAction:@selector(perform:)];
    // Do any additional setup after loading the view.
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // Navigation button was pressed. Do some stuff
        if([date hasSuffix:@","]){
            date = [date substringToIndex:[date length] - 1];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLabel" object:date];
    }
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text=arr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    date=[date stringByAppendingString:[NSString stringWithFormat:@"%@,",arr[indexPath.row]]];
    
    NSLog(@"%@",date);
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    date=[date stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",arr[indexPath.row]] withString:@""];
    NSLog(@"%@",date);
}



@end
