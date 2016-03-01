//
//  UIWebView+Extension.m
//  FilmSite
//
//  Created by 陈欢 on 14-8-20.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UIWebView+Extension.h"

@implementation UIWebView (Extension)

- (void)setBounces:(BOOL)bounces;
{
    for (id subview in self.subviews)
    {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
        {
            UIScrollView *scrollView = subview;
            scrollView.bounces = NO;
        }
    }
}

@end
