//
//  FilmCommentBaseClass.m
//
//  Created by 高  on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FilmCommentBaseClass.h"
#import "FilmCommentComments.h"


NSString *const kFilmCommentBaseClassTotalPages = @"totalPages";
NSString *const kFilmCommentBaseClassPi = @"pi";
NSString *const kFilmCommentBaseClassCount = @"count";
NSString *const kFilmCommentBaseClassComments = @"comments";
NSString *const kFilmCommentBaseClassPs = @"ps";


@interface FilmCommentBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FilmCommentBaseClass

@synthesize totalPages = _totalPages;
@synthesize pi = _pi;
@synthesize count = _count;
@synthesize comments = _comments;
@synthesize ps = _ps;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.totalPages = [[self objectOrNilForKey:kFilmCommentBaseClassTotalPages fromDictionary:dict] doubleValue];
            self.pi = [[self objectOrNilForKey:kFilmCommentBaseClassPi fromDictionary:dict] doubleValue];
            self.count = [self objectOrNilForKey:kFilmCommentBaseClassCount fromDictionary:dict];
    NSObject *receivedFilmCommentComments = [dict objectForKey:kFilmCommentBaseClassComments];
    NSMutableArray *parsedFilmCommentComments = [NSMutableArray array];
    if ([receivedFilmCommentComments isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFilmCommentComments) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFilmCommentComments addObject:[FilmCommentComments modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFilmCommentComments isKindOfClass:[NSDictionary class]]) {
       [parsedFilmCommentComments addObject:[FilmCommentComments modelObjectWithDictionary:(NSDictionary *)receivedFilmCommentComments]];
    }

    self.comments = [NSArray arrayWithArray:parsedFilmCommentComments];
            self.ps = [[self objectOrNilForKey:kFilmCommentBaseClassPs fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPages] forKey:kFilmCommentBaseClassTotalPages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pi] forKey:kFilmCommentBaseClassPi];
    [mutableDict setValue:self.count forKey:kFilmCommentBaseClassCount];
    NSMutableArray *tempArrayForComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComments] forKey:kFilmCommentBaseClassComments];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ps] forKey:kFilmCommentBaseClassPs];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.totalPages = [aDecoder decodeDoubleForKey:kFilmCommentBaseClassTotalPages];
    self.pi = [aDecoder decodeDoubleForKey:kFilmCommentBaseClassPi];
    self.count = [aDecoder decodeObjectForKey:kFilmCommentBaseClassCount];
    self.comments = [aDecoder decodeObjectForKey:kFilmCommentBaseClassComments];
    self.ps = [aDecoder decodeDoubleForKey:kFilmCommentBaseClassPs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_totalPages forKey:kFilmCommentBaseClassTotalPages];
    [aCoder encodeDouble:_pi forKey:kFilmCommentBaseClassPi];
    [aCoder encodeObject:_count forKey:kFilmCommentBaseClassCount];
    [aCoder encodeObject:_comments forKey:kFilmCommentBaseClassComments];
    [aCoder encodeDouble:_ps forKey:kFilmCommentBaseClassPs];
}

- (id)copyWithZone:(NSZone *)zone
{
    FilmCommentBaseClass *copy = [[FilmCommentBaseClass alloc] init];
    
    if (copy) {

        copy.totalPages = self.totalPages;
        copy.pi = self.pi;
        copy.count = [self.count copyWithZone:zone];
        copy.comments = [self.comments copyWithZone:zone];
        copy.ps = self.ps;
    }
    
    return copy;
}


@end
