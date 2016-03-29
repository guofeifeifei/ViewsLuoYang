


//
//  ShowCollectViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/28.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ShowCollectViewController.h"
#import "DataBaseManger.h"
#import "CollectResultViewController.h"
@interface ShowCollectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation ShowCollectViewController
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DataBaseManger *manager=[DataBaseManger shareInstance];
    [manager openDataBase];
    
    self.urlArray=[manager selectAllUrl];
    self.tableView.separatorColor = [UIColor whiteColor];

    self.tableView.rowHeight = 140;
    
    
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.urlArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    Collect *collect = self.urlArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:collect.image] placeholderImage:nil];
    cell.detailTextLabel.text = collect.url;
    
    cell.detailTextLabel.textColor = barColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
    return cell;
    
    
    
}


- (NSMutableArray *)urlArray{
    if (_urlArray == nil) {
        self.urlArray = [NSMutableArray new];
    }
    return _urlArray;
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
