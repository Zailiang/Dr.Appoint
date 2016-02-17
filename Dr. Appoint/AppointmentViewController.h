//
//  AppointmentViewController.h
//  Dr. Appoint
//
//  Created by Zailiang Yu on 2/17/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UIViewController<UITextFieldDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *arrDoctor;

@end
