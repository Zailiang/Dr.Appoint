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

@interface ViewController ()

- (IBAction)btn_DocRgt:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

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
@end
