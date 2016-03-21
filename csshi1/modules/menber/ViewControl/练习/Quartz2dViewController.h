//
//  Quartz2dViewController.h
//  csshi1
//
//  Created by 高 on 16/3/17.
//  Copyright © 2016年 高. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^sucess) (BOOL lsucess);

@interface Quartz2dViewController : UIViewController{
   
    
}
@property (nonatomic ,copy) BOOL(^isplay) (NSString *string);


@end
