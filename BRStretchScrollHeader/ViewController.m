//
//  ViewController.m
//  BRStretchScrollHeader
//
//  Created by gitBurning on 16/12/9.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+BRStretchHeaderView.h"
#import "UIViewController+BRStretchHeaderView.h"

#import "NextViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tablewView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tablewView.delegate =self;
    self.tablewView.dataSource = self;
    self.tablewView.tableFooterView = [UIView new];
    self.tablewView.tableHeaderView = [UIView new];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    headerView.image = [UIImage imageNamed:@"main_set_background"];
    //headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_set_background"]];
    [self.tablewView BR_addStrechHeaderView:headerView];
   // [self BR_addVCStrechHeaderView:headerView InTablewView:self.tablewView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NextViewController *next = [[NextViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:next];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
