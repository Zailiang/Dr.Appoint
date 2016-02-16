//
//  CollectionViewController.m
//  Dr. Appoint
//
//  Created by Zick Chao on 2/16/16.
//  Copyright © 2016 Zailiang Yu. All rights reserved.
//

#import "CollectionViewController.h"
#import "DoctorDetailViewController.h"
#import "customCollectionViewCell.h"
@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*str=@"cellstr";
    customCollectionViewCell *item=[collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:{
            [item.img_view setImage:[UIImage imageNamed:@"Cardiologist.png"]];
        }
            break;
        case 1:{
            [item.img_view setImage:[UIImage imageNamed:@"Dentist.png"]];
        }
            break;
        case 2:{
            [item.img_view setImage:[UIImage imageNamed:@"Dermatologist.png"]];
        }
            break;
        case 3:{
            [item.img_view setImage:[UIImage imageNamed:@"Gynecologist.png"]];
        }
            break;
        case 4:{
            [item.img_view setImage:[UIImage imageNamed:@"Ophthalmologist.png"]];
        }
            break;
        case 5:{
            [item.img_view setImage:[UIImage imageNamed:@"Psychologist.png"]];
        }
            break;
        default:
            break;
    }
    //    item.img_view.userInteractionEnabled=YES;
    //    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)];
    //    tapped.numberOfTapsRequired = 1;
    //    [item.img_view addGestureRecognizer:tapped];
    //[item.img_view setImage:[UIImage imageNamed:@"arrowleft.png"]];
    return item;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"2222");
    DoctorDetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"doctorDetail"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}
@end
