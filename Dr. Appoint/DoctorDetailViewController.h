//
//  DoctorDetailViewController.h
//  Dr. Appoint
//
//  Created by Zick Chao on 2/16/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSString *specialization;

@end
