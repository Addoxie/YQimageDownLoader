//
//  ImageDownloader.h
//  imgdownloader
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^imageDownLoadCompelete)(UIImage *);

@interface ImageDownloader : NSObject{
    NSOperationQueue *dowlaodQueue;
}

@property(nonatomic,retain)NSMutableData *data;

@property(nonatomic,copy)imageDownLoadCompelete block;
+ (id)shareInstance;
- (void)setURL:(NSURL *)url compelteblock:(imageDownLoadCompelete)block;
@end
