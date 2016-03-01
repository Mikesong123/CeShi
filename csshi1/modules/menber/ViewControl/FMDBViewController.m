//
//  FMDBViewController.m
//  csshi1
//
//  Created by 高 on 16/2/3.
//  Copyright © 2016年 高. All rights reserved.
//

#import "FMDBViewController.h"

@interface FMDBViewController ()
{
    NSMutableArray *ceshi1;
    NSMutableArray *ceshi2;
}
@property(assign ,getter=ison)BOOL on;
@property(nonatomic ,strong)NSString *wstring;

@end

@implementation FMDBViewController
//@synthesize wstring = _wstring;
@dynamic wstring ;

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filename = [path stringByAppendingPathComponent:@"t_student.sqlite"];
    
    ceshi1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    ceshi2 = [ceshi1 copy];
//    [ceshi2 removeObject:@"1"];
    NSLog(@"%@%@",ceshi1,ceshi2);
    if (self.on) {
        
    }
    NSLog(@"%@",self.on);
    NSLog(@"%@",self.wstring);
}

- (NSString *)wstring{
 return  @"1111";
}
- (void)setWstring:(NSString *)wstring
{
    self.wstring = wstring;
}
@end
