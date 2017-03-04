//
//  ViewController.m
//  imgdownloader
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "ViewController.h"
#import "ImageDownloader.h"

@interface ViewController (){
    NSArray *iamgeURLarr;
    CGFloat sh;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];

    NSString *imagesStr=@"http://i.meizitu.net/2013/08/1U9515447-1.jpg,http://i.meizitu.net/2013/08/1U951N04-4.jpg,http://i.meizitu.net/2013/08/1U95131Y-6.jpg,http://i.meizitu.net/2013/08/1U95133X-5.jpg,http://i.meizitu.net/2013/08/1U95153J-0.jpg,http://i.meizitu.net/2013/08/1U9511258-7.jpg,http://i.meizitu.net/2013/08/1U9513315-8.jpg,http://i.meizitu.net/2013/08/140922DI-0.jpg,http://i.meizitu.net/2013/08/1U9515447-1.jpg,http://i.meizitu.net/2013/08/1U951N04-4.jpg,http://i.meizitu.net/2013/08/1U95131Y-6.jpg,http://i.meizitu.net/2013/08/1U95133X-5.jpg,http://i.meizitu.net/2013/08/1U95153J-0.jpg,http://i.meizitu.net/2013/08/1U9511258-7.jpg,http://i.meizitu.net/2013/08/1U9513315-8.jpg,http://i.meizitu.net/2013/08/140922DI-0.jpg";
    iamgeURLarr=[imagesStr componentsSeparatedByString:@","];
   sh= self.view.bounds.size.width*1184/800;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self downLoadImage];

}
-(void)downLoadImage{
   

    
    NSString *imagesStr=@"http://i.meizitu.net/2013/08/1U9515447-1.jpg,http://i.meizitu.net/2013/08/1U951N04-4.jpg,http://i.meizitu.net/2013/08/1U95131Y-6.jpg,http://i.meizitu.net/2013/08/1U95133X-5.jpg,http://i.meizitu.net/2013/08/1U95153J-0.jpg,http://i.meizitu.net/2013/08/1U9511258-7.jpg,http://i.meizitu.net/2013/08/1U9513315-8.jpg,http://i.meizitu.net/2013/08/140922DI-0.jpg,http://i.meizitu.net/2013/08/1U9515447-1.jpg,http://i.meizitu.net/2013/08/1U951N04-4.jpg,http://i.meizitu.net/2013/08/1U95131Y-6.jpg,http://i.meizitu.net/2013/08/1U95133X-5.jpg,http://i.meizitu.net/2013/08/1U95153J-0.jpg,http://i.meizitu.net/2013/08/1U9511258-7.jpg,http://i.meizitu.net/2013/08/1U9513315-8.jpg,http://i.meizitu.net/2013/08/140922DI-0.jpg";
   iamgeURLarr=[imagesStr componentsSeparatedByString:@","];
    
    
    for (NSString *urlstr in iamgeURLarr) {
    
         [[ImageDownloader shareInstance] setURL: [NSURL URLWithString:urlstr] compelteblock:^(UIImage *image) {
             NSLog(@"%@",image);
         }];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return iamgeURLarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return sh;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idf=@"cellidf";
    UITableViewCell *cell;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
   
     __block UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,sh)];
    
    NSString *urlstr=iamgeURLarr[indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[ImageDownloader shareInstance] setURL: [NSURL URLWithString:urlstr] compelteblock:^(UIImage *image) {
            NSLog(@"%@",image);
            dispatch_async(dispatch_get_main_queue(), ^{
                imagev.image=image;
            });
        }];
    });
    
    [cell addSubview:imagev];
    return cell;
}
@end
