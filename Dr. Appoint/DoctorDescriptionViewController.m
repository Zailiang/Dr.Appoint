//
//  DoctorDescriptionViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/17/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "DoctorDescriptionViewController.h"
#import "AppointmentViewController.h"

@interface DoctorDescriptionViewController ()


@property (strong, nonatomic) IBOutlet UIImageView *imgIcon;
@property (strong, nonatomic) IBOutlet UILabel *nametf;
@property (strong, nonatomic) IBOutlet UILabel *spectf;
@property (strong, nonatomic) IBOutlet UILabel *worktimetf;
@property (strong, nonatomic) IBOutlet UITextView *detailtv;


- (IBAction)appointmentbtn_tapped:(id)sender;






@end

@implementation DoctorDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nametf.text = [_doctorArrTemp[0] valueForKey:@"Name"];
    _spectf.text = [_doctorArrTemp[0] valueForKey:@"Specialization"];
    
    NSString *tempStr = [[[[_doctorArrTemp[0] valueForKey:@"AvailableDate"] componentsJoinedByString:@","] stringByAppendingString:@"\n"] stringByAppendingString:[_doctorArrTemp[0] valueForKey:@"AvailableTime"]];
    
    _worktimetf.text = tempStr;
    _detailtv.text = [_doctorArrTemp[0] valueForKey:@"Detail"];
    [_detailtv.layer setBorderWidth:0.5f];
    [_detailtv.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    _imgIcon.layer.cornerRadius = _imgIcon.frame.size.width / 2.2;
    _imgIcon.clipsToBounds = YES;
    
    if (_imgAvatar) {
        _imgIcon.image = _imgAvatar;
    }else{
        _imgIcon.image = [UIImage imageNamed:@"unknownavatar"];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)appointmentbtn_tapped:(id)sender {
    
    AppointmentViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentViewController"];
    [controller setArrDoctor:self.doctorArrTemp];
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
