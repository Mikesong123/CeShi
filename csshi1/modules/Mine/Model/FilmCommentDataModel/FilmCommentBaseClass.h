//
//  FilmCommentBaseClass.h
//
//  Created by 高  on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FilmCommentBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double totalPages;
@property (nonatomic, assign) double pi;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) double ps;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
