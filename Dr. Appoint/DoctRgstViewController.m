//
//  DoctRgstViewController.m
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/15/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "DoctRgstViewController.h"
#import "dateViewController.h"


@interface DoctRgstViewController (){
    NSMutableArray *arr_picker;
    NSArray* arr_Qual;
    NSArray* arr_Specialzation;
    
     NSData *data;
    NSString *date;
}
@property (weak, nonatomic) IBOutlet UITextView *txtView_detail;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *txtField_Qual;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView_Qual;


- (IBAction)btn_Submit:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *txtField_name;
@property (weak, nonatomic) IBOutlet UITextField *txtField_password;
@property (weak, nonatomic) IBOutlet UITextField *txtField_specialization;

@property (weak, nonatomic) IBOutlet UITextField *txtField_email;
@property (weak, nonatomic) IBOutlet UITextField *txtField_address;
@property (weak, nonatomic) IBOutlet UITextField *txtField_mobile;
@property (weak, nonatomic) IBOutlet UITextField *txtField_hospital;
@property (weak, nonatomic) IBOutlet UITextField *txtField_date;
@property (weak, nonatomic) IBOutlet UITextField *txtField_time;



@end

@implementation DoctRgstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtView_detail.layer.borderColor = UIColor.grayColor.CGColor;
    self.txtView_detail.layer.borderWidth = 5;
    
    ///// ////////
    [self.imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapped)];
    [singleTap setNumberOfTapsRequired:1];
    [self.imageView addGestureRecognizer:singleTap];
    
    //----------//
    arr_Qual = [[NSArray alloc]initWithObjects:@"High School",@"Bachelor",@"Master",@"Doctor",@"Other", nil];
    arr_Specialzation = [[NSArray alloc]initWithObjects:@"Dentist",@"Gynecologist",@"Dermatologist",@"Homeopathy",@"Ayurveda",@"Cardiologist", nil];
    
    [self.pickerView_Qual setHidden:YES];
    [[UIPickerView appearance] setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.txtField_name setPlaceholder:@"Name"];
    
    arr_picker = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel:) name:@"UpdateLabel" object:nil];
   
}

-(void)viewDidAppear:(BOOL)animated{
   // [self.txtField_date endEditing:YES];
    [self.txtField_date resignFirstResponder];
}

-(void)updateLabel:(NSNotification*)notification
{
    _txtField_date.text=notification.object;
    NSLog(@"notification");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_Submit:(id)sender {
    
    if (1) {
        PFObject *obj = [PFObject objectWithClassName:@"Doctors"];
        [obj setObject:_txtField_name.text forKey:@"Name"];
        [obj setObject:_txtField_password.text forKey:@"Password"];
        [obj setObject:_txtField_specialization.text forKey:@"Specialization"];
        [obj setObject:_txtField_Qual.text forKey:@"Qualification"];
        [obj setObject:_txtField_email.text forKey:@"EmailAddress"];
        [obj setObject:_txtField_hospital.text forKey:@"Hospital"];
        [obj setObject:_txtField_address.text forKey:@"Address"];
        [obj setObject:_txtField_mobile.text forKey:@"Mobile"];
        [obj setObject:_txtView_detail.text forKey:@"Detail"];
        [obj setObject:_txtField_time.text forKey:@"AvailableTime"];

        
        NSArray *arr = [_txtField_date.text componentsSeparatedByString:@","];
        [obj setObject:arr forKey:@"AvailableDate"];
        
        if (data) {
            PFFile *imageFile = [PFFile fileWithData:data];
            [obj setObject:imageFile forKey:@"Image"];
        }
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"%@",error);
            }
        }];
        
        
    }
    
}


#pragma mark imagePicker

-(void)imageTapped{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    picker.navigationBar.barStyle = UIBarStyleBlack;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *img = info[UIImagePickerControllerEditedImage];
    
    [self.imageView setImage:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData* imgData=UIImagePNGRepresentation(img);
    data = imgData;
    
}

#pragma mark textField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if(textField == self.txtField_specialization){
        arr_picker = [NSMutableArray arrayWithArray:arr_Specialzation];
       // [arr_picker addObjectsFromArray:arr_Specialzation];
        [self.pickerView_Qual reloadAllComponents];
        [self.pickerView_Qual  setHidden:NO];
    }else if (textField == self.txtField_Qual) {
        arr_picker = [NSMutableArray arrayWithArray:arr_Qual];
        //[arr_picker addObjectsFromArray:arr_Qual];
        [self.pickerView_Qual reloadAllComponents];
        [self.pickerView_Qual setHidden:NO];
    }else if(textField == self.txtField_date){
        if (_txtField_date.text.length < 1) {
            dateViewController *dvc=[self.storyboard instantiateViewControllerWithIdentifier:@"dvc"];
            [self.navigationController pushViewController:dvc animated:YES];

        }
    }else if(textField == self.txtField_time){
        arr_picker = [NSMutableArray arrayWithObjects:@"Morning",@"Afternoon",nil];
        [self.pickerView_Qual reloadAllComponents];
        [self.pickerView_Qual setHidden:NO];
    }
}

#pragma mark PikerView datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
    
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arr_picker.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return arr_picker[row];
    
}
//----   pickerView delegate ----//

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([arr_picker containsObject:@"Morning"]) {
        self.txtField_time.text = arr_picker[row];
    }else if ([arr_picker containsObject:@"Dentist"]){
        self.txtField_specialization.text = arr_picker[row];
    }else if ([arr_picker containsObject:@"Doctor"]){
        self.txtField_Qual.text = arr_picker[row];
    }
    
   [self.pickerView_Qual setHidden:YES];
    
    
}

#pragma mark textview delegate

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size.height = size.height;
    textView.frame = frame;
}
@end
