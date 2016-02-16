//
//  PatientRgsViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/15/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "PatientRgsViewController.h"

@interface PatientRgsViewController ()
- (IBAction)btn_regiSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txf_Name;
@property (weak, nonatomic) IBOutlet UITextField *txf_PassWord;
@property (weak, nonatomic) IBOutlet UITextField *txf_Mobile;
@property (weak, nonatomic) IBOutlet UITextField *txf_Email;

@end

@implementation PatientRgsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.txf_PassWord setSecureTextEntry:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btn_regiSubmit:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"Patients"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.txf_Name.text,     @"Name",
                         self.txf_Mobile.text,   @"Mobile",
                         self.txf_PassWord.text, @"Password",
                         self.txf_Email.text,    @"Email",nil];
    
    [testObject setValuesForKeysWithDictionary:dic];
    
    [testObject saveInBackground];
    

}
@end
