//
//  AppointmentViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/17/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppDelegate.h"

@interface AppointmentViewController ()
{
    NSString *selectDate;
    NSString *workingDay;
    UIAlertController *confirmAlert;
    NSString *confirmInfo;
    NSString *name;
    NSString *doctormobile;
    NSString *timeslot;
    NSString *weekday;
    NSString *timeslottype;
    NSString *availableTimeString;
    NSInteger AvailableTimeFlag; //1 for morning, 2 for afternoon, 3 for morning and afternoon
    NSString *availableDayString;
}

- (IBAction)btn_chooseDate:(id)sender;
- (IBAction)btn_CancelDate:(id)sender;
- (IBAction)btn_DoneDate:(id)sender;
- (IBAction)datePicker:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIButton *btnChoosebtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *container;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [_subView setHidden:YES];
    [_tableView setHidden:YES];
    //[_container setHidden:YES];
    confirmInfo = [[NSString alloc] init];
    name = [[NSString alloc] init];
    name = [self.arrDoctor[0] valueForKey:@"Name"];
    
    NSLog(@"---------------%@",name);
    
    doctormobile = [[NSString alloc] init];
    doctormobile = [self.arrDoctor[0] valueForKey:@"Mobile"];
    timeslot = [[NSString alloc] init];
    timeslottype = [[NSString alloc] init];
    availableTimeString = [[NSString alloc] init];
    availableTimeString = [self.arrDoctor[0] valueForKey:@"AvailableTime"];
    
    availableDayString = [[NSString alloc] init];
    availableDayString = [NSString stringWithFormat:@"%@",[self.arrDoctor[0] valueForKey:@"AvailableDate"]];
    NSLog(@"%@",availableDayString);
    
    if ([availableDayString containsString:@"Wed"] ) {
        NSLog(@"YES");
    }else{
        NSLog(@"NO");
    }
    
    
    if ([availableTimeString containsString:@"Morning"]&&![availableTimeString containsString:@"Afternoon"]) {
        AvailableTimeFlag=1;
    }else if(![availableTimeString containsString:@"Morning"]&&[availableTimeString containsString:@"Afternoon"]) {
        AvailableTimeFlag=2;
    }else if([availableTimeString containsString:@"Morning"]&&[availableTimeString containsString:@"Afternoon"]) {
        AvailableTimeFlag=3;
    }
    NSLog(@"%ld",(long)AvailableTimeFlag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_chooseDate:(id)sender {
    [_subView setHidden:NO];

}

- (IBAction)btn_CancelDate:(id)sender {
    selectDate = @"";
    [_subView setHidden:YES];
    //[_chooseDatebtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnChoosebtn setTitle:@"please choose a date" forState:UIControlStateNormal];
    
}

- (IBAction)btn_DoneDate:(id)sender {
    if ([selectDate length]) {
        [self.btnChoosebtn setTitle:selectDate forState:UIControlStateNormal];
        [_subView setHidden:YES];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd EE"];
        NSDate *date = [NSDate date];
        NSString *strDate = [dateFormatter stringFromDate:date];
        selectDate =strDate;
        NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
        [weekdayFormatter setDateFormat:@"EE"];
        NSString *weekDay = [weekdayFormatter stringFromDate:date];
        workingDay = weekDay;
    NSLog(@"%@",workingDay);
        [self.btnChoosebtn setTitle:selectDate forState:UIControlStateNormal];
        [_subView setHidden:YES];
    }
    if ([availableDayString containsString:workingDay] ) {
        [_tableView setHidden:NO];
        //[_container setHidden:NO];
        [self.btnChoosebtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        [_tableView setHidden:YES];
        //[_container setHidden:YES];
        [self.btnChoosebtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.btnChoosebtn setTitle:@"Date unavailable" forState:UIControlStateNormal];
    }

}

- (IBAction)datePicker:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd EE"];
    NSString *formatedDate = [dateFormatter stringFromDate:_datePicker.date];
    selectDate = formatedDate;
    [weekdayFormatter setDateFormat:@"EE"];
    NSString *weekDay = [weekdayFormatter stringFromDate:_datePicker.date];
    workingDay = weekDay;
}


#pragma -mark TableView DataSource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (AvailableTimeFlag == 1 ||AvailableTimeFlag == 2) {
        return 1;
    }else{
        return 2;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (AvailableTimeFlag == 1) {
        return @"Morning";
    }else if (AvailableTimeFlag == 2){
        return @"Afternoon";
    }else{
        if (section == 0) {
            return @"Morning";
        }
        else{
            return @"Afternoon";
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (AvailableTimeFlag == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"9:00 - 10:00";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"10:00 - 11:00";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"11:00 - 12:00";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"12:00 - 13:00";
        }
    }else if (AvailableTimeFlag == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"14:00 - 15:00";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"15:00 - 16:00";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"16:00 - 17:00";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"17:00 - 18:00";
        }
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"9:00 - 10:00";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"10:00 - 11:00";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"11:00 - 12:00";
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"12:00 - 13:00";
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"14:00 - 15:00";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"15:00 - 16:00";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"16:00 - 17:00";
            }else if (indexPath.row == 3){
                cell.textLabel.text = @"17:00 - 18:00";
            }
        }
    }
    
    
    return cell;
}

#pragma -mark TableView Delegate Method

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    timeslot = cell.textLabel.text;
    confirmInfo = [confirmInfo stringByAppendingString:@"You want to meet Doctor\n"];
    NSLog(@"---------------%@",name);
    confirmInfo = [confirmInfo stringByAppendingString:name];
    confirmInfo = [confirmInfo stringByAppendingString:@"\n on \n"];
    confirmInfo = [confirmInfo stringByAppendingString:selectDate];
    confirmInfo = [confirmInfo stringByAppendingString:@"\n at \n"];
    confirmInfo = [confirmInfo stringByAppendingString:timeslot];
    confirmInfo = [confirmInfo stringByAppendingString:@"\n Is everything OK?"];
    
    if (AvailableTimeFlag==1) {
        timeslottype = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    }else if (AvailableTimeFlag==2){
        timeslottype = [NSString stringWithFormat:@"%d",(int)indexPath.row+4];
    }else if (AvailableTimeFlag==3){
        if (indexPath.section==0) {
            timeslottype = [NSString stringWithFormat:@"%d",(int)indexPath.row];
        }else
            timeslottype = [NSString stringWithFormat:@"%d",(int)indexPath.row+4];
    }
    AppDelegate *mydelegate = [[UIApplication sharedApplication] delegate];
    NSLog(@"%@",mydelegate.customerMobile);
    
    confirmAlert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:confirmInfo preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confrim" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PFObject *appointment = [PFObject objectWithClassName:@"Billboard"];
        [appointment setObject:mydelegate.customerMobile forKey:@"PatMob"];
        [appointment setObject:doctormobile forKey:@"DocMob"];
        [appointment setObject:selectDate forKey:@"Date"];
        [appointment setObject:timeslottype forKey:@"Time"];
        [appointment saveInBackground];
        sleep(1);
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        confirmInfo = @"";
    }];
    [confirmAlert addAction:confirm];
    [confirmAlert addAction:cancel];
    
    [self presentViewController:confirmAlert animated:YES completion:nil];
}



@end
