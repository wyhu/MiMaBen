//
//  MainViewController.m
//  MiMaBen
//
//  Created by huweiya on 16/8/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MainViewController.h"
#import "MiMaDetailViewController.h"



@interface MainViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;


@property (nonatomic, strong) NSMutableDictionary *dataDic;


//@property (nonatomic, strong) NSArray *valuesArr;


@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"首页";
    
    [self.view addSubview:self.mainTableView];
    
    [self initNav];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataDic = [NSMutableDictionary dictionaryWithDictionary:[AppDelegate getDataDic]];
    
    [self.mainTableView reloadData];

}
/**
 构造导航栏按钮
 */
- (void)initNav{
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
//    addBtn.frame = CGRectMake(0, 0, 60, 44);
    
    
//    [addBtn setTitle:@" 新增" forState:0];
    
    
    [addBtn addTarget:self action:@selector(addMiMa:mima:) forControlEvents:UIControlEventTouchUpInside];
    

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];

    
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
//    exitBtn.frame = CGRectMake(0, 0, 60, 44);
    
    [exitBtn setTitle:@"" forState:0];
    
    [exitBtn addTarget:self action:@selector(exitApp) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *exitItem = [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
    
    self.navigationItem.leftBarButtonItem = exitItem;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    
    headerV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 30)];
    
    label1.text = @"账号";
    
    [headerV addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 100, 0, 80, 30)];
    
    label2.text = @"密码";
    
    label2.textAlignment = NSTextAlignmentRight;
    
    [headerV addSubview:label2];

    
    return headerV;
}


- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        
        _mainTableView.tableFooterView = [[UIView alloc] init];
        
        _mainTableView.backgroundColor = [UIColor whiteColor];
        
        _mainTableView.dataSource = self;
        
        _mainTableView.delegate = self;
    }
    
    return _mainTableView;
    
}


//- (NSArray *)valuesArr
//{
//    if (!_valuesArr) {
//        
//        
//        _valuesArr = [CountModel mj_objectArrayWithKeyValuesArray:[self.dataDic allValues]];
//        
//        
//    }
//    
//    return _valuesArr;
//}




//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dataDic allValues].count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    NSString *dic = [self.dataDic allValues][indexPath.row];

    CountModel *model = [CountModel mj_objectWithKeyValues:dic];
    
    cell.textLabel.text = model.count;
    
    cell.detailTextLabel.text = model.countPass;
    

    return cell;
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cance = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [tableView reloadData];
            
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
        
        UIAlertAction *dele = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            [self.dataDic removeObjectForKey:cell.textLabel.text];
            
            [self.dataDic removeObjectForKey:cell.textLabel.text];
            
            
            [self.dataDic writeToFile:[AppDelegate getDataPath] atomically:YES];
            
            [tableView reloadData];

            
        }];
        

        [alert addAction:dele];
        
        [alert addAction:cance];
        [self presentViewController:alert animated:YES completion:nil];
        

        
        
    }];
    //此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也
    
    
    
    //    可自行定义
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSString *zhanghao = cell.textLabel.text;
        
        NSString *mima = cell.detailTextLabel.text;
        
        [self addMiMa:zhanghao mima:mima];
        
    }];
    
    
    
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *dic = [self.dataDic allValues][indexPath.row];
    
    CountModel *model = [CountModel mj_objectWithKeyValues:dic];

    MiMaDetailViewController *miMaVC = [[MiMaDetailViewController alloc] init];
    
    miMaVC.model = model;
    
    [self.navigationController pushViewController:miMaVC animated:YES];
    
    
}


#pragma mark 新增密码
- (void)addMiMa:(NSString *)zhanghao mima:(NSString *)mima{
    
    
    UIAlertController *passAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入信息！" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.mainTableView reloadData];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *field1 = passAlert.textFields[0];
        
        UITextField *field2 = passAlert.textFields[1];
        
        
        if (field1.text.length >0 && field2.text.length > 0) {
            
            
            [self add:field2.text pass:field1.text];
        }else{
            
            //什么也不做
            
            
        }
        
        
        
    }];
    
    
    
    
    [passAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入账号！";
        if ([zhanghao isKindOfClass:[NSString class]]) {
            textField.text = zhanghao;
            textField.enabled = NO;
        }
        
        
    }];
    
    
    
    
        [passAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = @"请输入密码！";

            if ([mima isKindOfClass:[NSString class]]) {
                textField.text = mima;
                
                [textField becomeFirstResponder];
            }
            
        }];
        
    
    
    
    [passAlert addAction:action2];
    
    [passAlert addAction:action3];
    
    
    [self presentViewController:passAlert animated:YES completion:^{
        
    }];
    

    
}



- (NSString*)stringFromDate:(NSDate*)date withFormatter:(NSString *)formatter;

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




- (void)add:(NSString *)pass pass:(NSString *)obj{
    
    
    NSMutableDictionary *litterDic = [NSMutableDictionary dictionary];
    
    [litterDic setObject:obj forKey:@"count"];
    
    [litterDic setObject:pass forKey:@"countPass"];
    
    [litterDic setObject:[self stringFromDate:[NSDate date] withFormatter:@"yyyy-MM-dd HH:mm:ss"] forKey:@"countTime"];

    [self.dataDic setObject:litterDic forKey:obj];
    
    [self.dataDic writeToFile:[AppDelegate getDataPath] atomically:YES];
    
    [_mainTableView reloadData];
    
}







#pragma mark 退出程序
- (void)exitApp{
    
    
    UIAlertController *exitAlertCtrl = [UIAlertController alertControllerWithTitle:@"请确认是否退出程序！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cance = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self exit];
    }];
    
    [exitAlertCtrl addAction:cance];
    
    [exitAlertCtrl addAction:exit];
    
    [self presentViewController:exitAlertCtrl animated:YES completion:nil];

}

- (void)exit{
    exit(0);

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
