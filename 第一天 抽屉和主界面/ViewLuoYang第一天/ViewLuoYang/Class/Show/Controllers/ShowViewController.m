//
//  ShowViewController.m
//  AllViewOfLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ShowViewController.h"
#import "LuoyangNews.h"
#import "LuoyangNewsTableViewCell.h"
#import "NewsDetailViewController.h"

//左边菜单
#import "leftView.h"

#define MAX_CENTER_X 420
#define  screen [[UIScreen mainScreen] bounds]
#define BOUND_X 280


static NSString *str=@"cell";
@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //侧滑的三个属性
    UIPanGestureRecognizer *panGestureRecognizer;
    float centerX;
    float centerY;
 
}
@property(nonatomic, strong) UIImageView *headImage;
@property(nonatomic, strong) NSString *urlString;
@property(nonatomic, strong) NSMutableArray *listArr;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView  *contenceView;
@property(nonatomic, strong) leftView *leftMenuView;
@property(nonatomic, strong) NSMutableArray *photoArr;
@property(nonatomic, strong) NSMutableArray *photo;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"首页展示";
    //先放入第一个左边的视图
    NSBundle *boundle=[NSBundle mainBundle];
    NSArray *obj=[boundle loadNibNamed:@"letfView" owner:self options:nil];
    
    self.leftMenuView=[obj lastObject];
    self.leftMenuView.frame=CGRectMake(0, 100, KScreenWidth,KScreenHeight);
    [self.view addSubview:self.leftMenuView];
    [self.view addSubview:self.contenceView];
    [self customViewBtn];
    
    self.urlString=KLuoyangNews;
    [self getNetData];
    [self getPhotoData];
    
  
    
}

#pragma mark ---自定义tableView的header

- (UIImageView *)headImage{
    if (_headImage==nil) {
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 130)];
        self.photo=[[NSMutableArray alloc]init];
        for (LuoyangNews *model  in self.photoArr) {
           [self.photo addObject:model.image];
           
        }
        [NSTimer scheduledTimerWithTimeInterval:self.photo.count target:self selector:@selector(swichViewPhoto) userInfo:nil repeats:YES];
        
        self.headImage.userInteractionEnabled=YES;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=self.headImage.frame;
        [btn addTarget:self action:@selector(detailBtnView) forControlEvents:UIControlEventTouchUpInside];
        [self.headImage addSubview:btn];
        
        
    }
    
    
    
    return _headImage;
    
}

-(void)swichViewPhoto{
   
    int a=arc4random()%self.photo.count;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.photo[a]] placeholderImage:nil];
    
}


-(void)detailBtnView{
    NewsDetailViewController *new=[[NewsDetailViewController alloc]init];
    
    [self.navigationController pushViewController:new animated:YES];
    
    
}



#pragma mark ---三个按钮

-(void)customViewBtn{
    
    NSArray *arr=@[@"洛阳",@"热点",@"娱乐"];
    for (int i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(screen.size.width/3*i, 64, screen.size.width/3, 44);
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag=i+1;
        [btn addTarget:self action:@selector(swichViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.backgroundColor=barColor;
        
        [self.view addSubview:btn];

    }
    
}


-(void)swichViewBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            //网络请求
            self.urlString=KLuoyangNews;
            [self.listArr removeAllObjects];
            [self getNetData];
           
            break;
        case 2:
           self.urlString=KhotTalk;
             [self.listArr removeAllObjects];
            [self getNetData];
            
            break;
        case 3:
            self.urlString=Kentertainment;
             [self.listArr removeAllObjects];
            [self getNetData];
                break;
            
        default:
            break;
    }

    
    
}


#pragma mark --- lazy Loading
//第二个View
- (UIView *)contenceView{
    if (_contenceView == nil) {
        self.contenceView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, screen.size.width, screen.size.height)];
        centerX = screen.size.width / 2;
        centerY = screen.size.height / 2;
        self.contenceView.backgroundColor = [UIColor greenColor];
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.contenceView addGestureRecognizer:panGestureRecognizer];
     }
    
    return _contenceView;

}

- (UITableView *)tableView{
    
    if (_tableView==nil) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, screen.size.width, screen.size.height) style:UITableViewStylePlain];
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.rowHeight=100;
        
        [self.tableView registerNib:[UINib nibWithNibName:@"LuoyangNewsTableViewCell" bundle:nil] forCellReuseIdentifier:str];
        
 
    }
    
    return _tableView;
    
}

- (NSMutableArray *)listArr{
    
    if (_listArr== nil) {
        _listArr=[[NSMutableArray alloc]init];
        
    }
    return _listArr;
}

- (NSMutableArray *)photoArr{
    
    if (_photoArr == nil) {
        _photoArr =[[NSMutableArray alloc]init];
        
    }
    return _photoArr;
}

#pragma mark ---侧滑的方法
-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:self.contenceView];
    float x = self.contenceView.center.x + translation.x;
    if (x < centerX) {
        x = centerX;
    }
    
    self.contenceView.center = CGPointMake(x, centerY);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
         [UIView animateWithDuration:0.2 animations:^(void){
      if (x > BOUND_X) {
         self.contenceView.center = CGPointMake(MAX_CENTER_X, centerY);
            }else{
        self.contenceView.center = CGPointMake(centerX, centerY);
                
            }
        }];

    }
    [recognizer setTranslation:CGPointZero inView:self.contenceView];
  
}
- (void)buttonPressed:(UIButton *)button
{
    
    [UIView animateWithDuration:0.2 animations:^(void){
          if (self.contenceView.center.x == centerX) {
     self.contenceView.center = CGPointMake(MAX_CENTER_X, centerY);
        }else if (self.contenceView.center.x == MAX_CENTER_X){
        self.contenceView.center = CGPointMake(centerX, centerY);
            
        }
    }];
    
}

#pragma mark ---网络请求
-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:self.urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic=responseObject;
        
        NSDictionary *dataDic=dic[@"data"];
        
        NSArray *newsArr=dataDic[@"news_list"];
        
        for (NSDictionary *listDic in newsArr) {
            
            LuoyangNews *model=[[LuoyangNews alloc]init];
            [model setValuesForKeysWithDictionary:listDic];
            
            [self.listArr addObject:model];
            
        }
        
        
        
        [self.contenceView addSubview:self.tableView];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}



-(void)getPhotoData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:KheadView parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic=responseObject;
        
        NSDictionary *dataDic=dic[@"data"];
        
        NSArray *newsArr=dataDic[@"imglist"];
        
        for (NSDictionary *itemDic in newsArr) {
            
            LuoyangNews *model=[[LuoyangNews alloc]init];
            [model setValuesForKeysWithDictionary:itemDic];
            
            [self.photoArr addObject:model];
            
        }
        
        
        self.tableView.tableHeaderView=self.headImage;
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}



#pragma mark ----UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LuoyangNewsTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    
    
    if (cell == nil) {
        
        //切记这里不能重新创建，而是继续使用创建好的cell
        //重用队列里面没有可用的cell，咱们在重新创建一个，然后把新建的cell的重用标示符设为上面定义的重用标示符
        cell=[[LuoyangNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        
    }
    
    cell.model=self.listArr[indexPath.row];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsDetailViewController *news=[[NewsDetailViewController alloc]init];
    
    LuoyangNews *model=self.listArr[indexPath.row];
    
    news.detailUrl=model.detailUrl;
    [self.navigationController pushViewController:news animated:YES];
    
    
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
