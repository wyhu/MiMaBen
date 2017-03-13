//
//  ViewController.m
//  MiMaBen
//
//  Created by huweiya on 16/8/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
//指纹解锁相关
#import <LocalAuthentication/LocalAuthentication.h>


#define AppkeyWindow [UIApplication sharedApplication].keyWindow

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *reSetBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _reSetBtn.hidden = NO;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    NSLog(@"%@",path);
    
    
    
}


- (IBAction)clickPasswordAction:(UIButton *)sender message:(NSString *)mess{
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    
    NSString *message;

    
    if ([mess isKindOfClass:[NSString class]] && mess.length > 0) {
        
        message = mess;

    }else{
        
        message = @"请输入密码！";
        
        if (!password) {
            message = @"首次使用请设置密码！";
        }

    }
    
    
    
    //存在
    
    
    UIAlertController *passAlert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (!password) {
            
            UITextField *field1 = passAlert.textFields[0];
            
            UITextField *field2 = passAlert.textFields[1];

            
            if ([field1.text isEqualToString:field2.text] && field1.text.length > 0) {
                
                [[NSUserDefaults standardUserDefaults] setObject:field2.text forKey:@"password"];
                
                [self clickPasswordAction:nil message:nil];
                
                
                
            }else{
                
                [self clickPasswordAction:nil message:@"请保证两次输入的密码一致或密码格式正确！"];
            }
            
        }else{
            //有密码
            UITextField *field1 = passAlert.textFields[0];

            if ([field1.text isEqual:password]) {
                
                //密码正确

                                
//                [self presentViewController:[[MainViewController alloc] init] animated:YES completion:nil];
                
                
                
                AppkeyWindow.rootViewController=[[MainTabBarController alloc] init];
                
                
                
            }else{
                
                [self clickPasswordAction:nil message:@"请输入正确的密码！"];
                
            }
            
        }
        
        
    }];

    
    
    
    [passAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入密码！";
        
    }];
    
    
    
    if (!password) {
        [passAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"请确认密码！";
            
        }];

    }
    
    
    [passAlert addAction:action2];
    
    [passAlert addAction:action3];

    
    [self presentViewController:passAlert animated:YES completion:^{
        
    }];
    
    
    
    
}


- (IBAction)touchIDAction:(UIButton *)sender {
    
    //iOS8.0后才支持指纹识别接口
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        return;
    }

    [self evaluateAuthenticate];
    
    
}

//指纹解锁相关
- (void)evaluateAuthenticate
{
    
    __weak typeof(self) weakSelf = self;
    
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    //切换主控制器
                  AppkeyWindow.rootViewController = [[MainTabBarController alloc] init];
                }];

                
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //系统取消授权，如其他APP切入
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        //授权失败
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        
                        
                        //系统未设置密码
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            
                            [self clickPasswordAction:nil message:nil];
                            
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                            
                            
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        UIAlertController *passAlert = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];

        
        [passAlert addAction:action2];
        
        
        [self presentViewController:passAlert animated:YES completion:nil];
        
        NSLog(@"%@",error.localizedDescription);
    }
}



- (IBAction)reSetPassword:(UIButton *)sender {
    
    
    
    
    
    UIAlertController *aletr = [UIAlertController alertControllerWithTitle:@"你身份证后四位是什么❓" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
        
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        NSString *miBao = [[NSUserDefaults standardUserDefaults] objectForKey:@"mibao"];

        
        UITextField *textF =aletr.textFields[0];

        
        if ([textF.text isEqualToString:miBao]) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            
            [self clickPasswordAction:nil message:nil];
            

        }else{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:AppKeyWindow animated:YES];
            
            hud.mode = MBProgressHUDModeText;
            
            hud.detailsLabelText = @"答案错误！";
            
            hud.detailsLabelFont = [UIFont systemFontOfSize:15];
            
            hud.margin = 10.f;
            
            hud.center = AppKeyWindow.center;
            
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:2.0];
            
        }
        
        
        
        
    }];
    
    
    
    [aletr addAction:action1];

    [aletr addAction:action2];
    
    
    [aletr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        
        
    }];
    
    
    [self presentViewController:aletr animated:YES completion:^{
        
        
        
    }];
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
