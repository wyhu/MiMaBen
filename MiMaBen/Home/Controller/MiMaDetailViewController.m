//
//  MiMaDetailViewController.m
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MiMaDetailViewController.h"

@interface MiMaDetailViewController ()

@property (nonatomic, strong) NSMutableDictionary *dataDic;


@property (nonatomic, strong) UIButton *saveBtn;


@end

@implementation MiMaDetailViewController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"密码详情";
    self.count.text = _model.count;
    self.countType.text = _model.countType;
    self.countPass.text = _model.countPass;
    self.lastTime.text = _model.countTime;
    self.contentTextV.text = _model.shuoMing;
    self.count.enabled = NO;
    [self initNav];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFC) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFC) name:UITextViewTextDidChangeNotification object:nil];

}


- (void)textFC{
    
    if (![self.model.countType isEqualToString:self.countType.text] || ![self.model.countPass isEqualToString:self.countPass.text] || ![self.model.shuoMing isEqualToString:self.contentTextV.text]) {
        
        //有改动
        
        self.saveBtn.hidden = NO;
    }else{
        //没哟改动
        
        self.saveBtn.hidden = YES;
    }
    
    
}

/**
 构造导航栏按钮
 */
- (void)initNav{
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        addBtn.frame = CGRectMake(0, 0, 60, 44);
    
    [addBtn setTitle:@" 更新" forState:0];
    
    [addBtn setTitleColor:[UIColor orangeColor] forState:0];
    
    addBtn.hidden = YES;
    
    self.saveBtn = addBtn;
    
    [addBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
        exitBtn.frame = CGRectMake(0, 0, 60, 44);
    
    
//    [exitBtn setTitle:@"" forState:0];
    
    
    [exitBtn addTarget:self action:@selector(exitApp) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *exitItem = [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
    
    
//    self.navigationItem.leftBarButtonItem = exitItem;
}



- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:[AppDelegate getDataDic]];
        
        
    }
    
    return _dataDic;
}

- (NSString*)striFromDate:(NSDate*)date withFormatter:(NSString *)formatter;

{
    
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss zzz";
    }
    
    //用于格式化NSDate对象
    
    NSDateFormatter *dateFormatte=[[NSDateFormatter alloc]init];
    
    [dateFormatte setDateFormat:formatter];
    
    //NSDate转NSString
    
    NSString *currentDateString=[dateFormatte stringFromDate:date];
    
    //输出currentDateString
    
    return currentDateString;
    
}

- (void)save{
    
    if (!self.countType.text.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账户类型不能为空！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cance = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:cance];

        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    if (!self.countPass.text.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码不能为空！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cance = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:cance];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }

    
    
    
    NSMutableDictionary *litterDic = [NSMutableDictionary dictionary];
    
    [litterDic setObject:self.model.count forKey:@"count"];
    
    [litterDic setObject:self.countPass.text forKey:@"countPass"];
    
    [litterDic setObject:self.countType.text forKey:@"countType"];

    [litterDic setObject:self.contentTextV.text forKey:@"shuoMing"];

    
    [litterDic setObject:[self striFromDate:[NSDate date] withFormatter:@"yyyy-MM-dd HH:mm:ss"] forKey:@"countTime"];
    

    
    [self.dataDic setObject:litterDic forKey:self.model.count];
    
    [self.dataDic writeToFile:[AppDelegate getDataPath] atomically:YES];
    

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新成功！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction *cance = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        self.lastTime.text = [litterDic objectForKey:@"countTime"];

        
        self.saveBtn.hidden = YES;
    }];
    
    [alert addAction:cance];
    [self presentViewController:alert animated:YES completion:nil];
    

    
    
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
