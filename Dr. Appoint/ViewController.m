//
//  ViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/15/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "ViewController.h"
#import "DoctRgstViewController.h"
#import "PatientRgsViewController.h"
#import "CollectionViewController.h"
@interface ViewController ()

- (IBAction)btn_DocRgt:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

- (IBAction)btn_Login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtField_user;
@property (weak, nonatomic) IBOutlet UITextField *txtField_password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_DocRgt:(id)sender {
    if ([self.mySwitch isOn]) {
        DoctRgstViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DoctRgstViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        PatientRgsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientRgsViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
- (IBAction)btn_Login:(id)sender {
    
    if ([self.mySwitch isOn]) {
        PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Doctors"];
        [pwdQuery whereKey:@"Mobile" equalTo:self.txtField_user.text];
        [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if ([self.txtField_password.text isEqualToString:[[objects lastObject] valueForKey:@"Password"]]) {
                    NSLog(@"successful");
                }else{
                    NSLog(@"failure");
                }
                //NSLog(@"%@",[[objects lastObject] valueForKey:@"Password"]);
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }else {
        PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Patients"];
        [pwdQuery whereKey:@"Mobile" equalTo:self.txtField_user.text];
        [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if ([self.txtField_password.text isEqualToString:[[objects lastObject] valueForKey:@"Password"]]) {
                    NSLog(@"successful");
                    CollectionViewController *cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"collectionView"];
                    [self.navigationController pushViewController:cvc animated:YES];
                }else{
                    NSLog(@"failure");
                }
                //NSLog(@"%@",[[objects lastObject] valueForKey:@"Password"]);
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }

    
}
@end
