//
//  NextViewController.m
//  BRStretchScrollHeader
//
//  Created by gitBurning on 16/12/9.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+BRStretchHeaderView.h"
@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tablew;

@end

@implementation NextViewController

- (void)dealloc
{
    NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self BR_setNavBarBackgroundColor:[UIColor redColor]];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_set_background"]];
    self.navigationItem.title = @"你好";
    [self BR_addVCStrechHeaderView:headerView InTablewView:_tablew];
    
    UIBarButtonItem *letf = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(dismiss)];
    
    self.br_navigationItem.leftBarButtonItem = letf;
    
//    [self.br_navBar lt_setTranslationY:20];
    self.tablew.delegate = self;
    self.tablew.dataSource = self;
    
    [self BR_addVCNavBarStatusChangedBlcok:^(kBRViewControllerStretchHeaderViewNavBarStatus staus, CGFloat alpha) {
       
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    _tablew.br_strechType = BRStretchHeaderStrechType_NotStretchBegainScollNavAlpha;

    self.br_strechType = _tablew.br_strechType;

   // UIView *overlay = [self.br_navBar valueForKey:@"overlay"];
   
    // Do any additional setup after loading the view from its nib.
    
}

- (void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.navBarStatus != kBRViewControllerStretchHeaderViewNavBarStatus_NotShow) {
        
        return UIStatusBarStyleDefault;
    }
    else{
        return UIStatusBarStyleLightContent;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"asdjkalsdjlaksdjasdasd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *next = [[UIViewController alloc] init];
    next.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:next animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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
