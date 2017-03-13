//
//  SettingViewController.m
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    
    NSString *miBao = [[NSUserDefaults standardUserDefaults] objectForKey:@"mibao"];
    
    self.textF.text = miBao;
    
    
}


- (IBAction)sureBtnA:(UIButton *)sender {
    
    if (!self.textF.text.length) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密保问题不能为空！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        
        UIAlertAction *cance = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:cance];
        [self presentViewController:alert animated:YES completion:nil];
        

    }
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.textF.text forKey:@"mibao"];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:AppKeyWindow animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.detailsLabelText = @"请熟记答案：1216";
    
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    
    hud.margin = 10.f;
    
    hud.center = AppKeyWindow.center;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2.0];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
