//
//  ImageDownloader.m
//  imgdownloader
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "ImageDownloader.h"

static ImageDownloader *instnce;

@implementation ImageDownloader

+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

- (void)setURL:(NSURL *)url compelteblock:(imageDownLoadCompelete)block{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //设置请求方式
    [request setHTTPMethod:@"GET"];
    
    [request setURL:url];
    //设置超时时间
    [request setTimeoutInterval:15];
    
    self.data = [NSMutableData data];
    //发送一个异步请求    
    
    if (dowlaodQueue) {
        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                UIImage *image = [UIImage imageWithData:data];
                block(image);
            }];
        }];
        [dowlaodQueue addOperation:blockOperation];
    }else{
        dowlaodQueue=[[NSOperationQueue alloc]init];
        dowlaodQueue.maxConcurrentOperationCount=6;
        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                UIImage *image = [UIImage imageWithData:data];
                block(image);
            }];
        }];
        [dowlaodQueue addOperation:blockOperation];
       
    }
}

@end
