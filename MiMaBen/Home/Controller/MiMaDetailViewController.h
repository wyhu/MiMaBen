//
//  MiMaDetailViewController.h
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseViewController.h"

@interface MiMaDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *countType;

@property (weak, nonatomic) IBOutlet UITextField *count;


@property (weak, nonatomic) IBOutlet UITextField *countPass;

@property (weak, nonatomic) IBOutlet UILabel *lastTime;



@property (weak, nonatomic) IBOutlet UITextView *contentTextV;

@property (nonatomic, strong) CountModel *model;
@end
