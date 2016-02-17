//
//  DoctorDetailViewController.m
//  Dr. Appoint
//
//  Created by Zick Chao on 2/16/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "DoctorDetailViewController.h"
#import "CustomTableViewCell.h"
#import "DoctorDescriptionViewController.h"

@interface DoctorDetailViewController (){
    NSMutableArray *docArray;
    NSArray *tempArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tbl_view;

@end

@implementation DoctorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    docArray=[[NSMutableArray alloc]init];
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Doctors"];
    [pwdQuery whereKey:@"Specialization" equalTo:_specialization];
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            docArray=[NSMutableArray arrayWithArray:objects];
            
            NSLog(@"got the objects %@",docArray);
            [_tbl_view reloadData];
        }else{
            NSLog(@"failure");
        }
       
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"%d",docArray.count);
    return [docArray count];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.lbl_name.text=[docArray[indexPath.row] objectForKey:@"Name"];
    cell.lbl_address.text=[docArray[indexPath.row] objectForKey:@"Address"];
    PFFile *file = [docArray[indexPath.row] objectForKey:@"Image"];
    cell.img_view.image=[UIImage imageWithData:[file getData]];
    NSLog(@"%d",indexPath.row);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorDescriptionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DoctorDescriptionViewController"];
    tempArr = [NSArray arrayWithObject:docArray[indexPath.row]];
    [controller setDoctorArrTemp:tempArr];
    [controller setImgAvatar:[UIImage imageWithData:[[docArray[indexPath.row] valueForKey:@"Image"] getData]]];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
