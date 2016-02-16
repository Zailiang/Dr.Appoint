//
//  CustomTableViewCell.h
//  Dr. Appoint
//
//  Created by Zick Chao on 2/16/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_view;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_address;

@end
