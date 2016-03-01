//
//  NSString+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#endif

@implementation NSString (Extension)

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString {
	NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
	NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);

	NSUInteger offset = 0;
	NSMutableString *raw = [self mutableCopy];

	NSInteger prevLength = 0;
	for (NSInteger i = 0; i < [indexes count]; i++) {
		@autoreleasepool {
			NSRange range = [[indexes objectAtIndex:i] rangeValue];
			prevLength = range.length;

			range.location -= offset;
			[raw replaceCharactersInRange:range withString:aString];
			offset = offset + prevLength - [aString length];
		}
	}

	return raw;
}

- (NSString *)urlencode {
	NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
	                                                            NULL,
	                                                            (CFStringRef)self,
	                                                            NULL,
	                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
	                                                            kCFStringEncodingUTF8));
	if (encodedString) {
		return encodedString;
	}
	return @"";
}

- (NSString *)md5String {
	if (!self) {
		return nil;
	}
	const char *original_str = [self UTF8String];
	unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
	CC_MD5(original_str, (unsigned int)strlen(original_str), digist);
	NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
	}
	return [outPutStr lowercaseString];
}

+ (BOOL)isEmptyString:(NSString *)string {
	if (string != nil && (id)string != [NSNull null]) {
		return [string isEmpty];
	}
	return YES;
}

+ (BOOL)isNotEmptyString:(NSString *)string {
	return ![NSString isEmptyString:string];
}

+ (NSString *)fromInt:(int)value {
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)fromLonglongInt:(long long int)value {
	return [NSString stringWithFormat:@"%lld", (long long int)value];
}

+ (NSString *)fromInteger:(NSInteger)value {
	return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)fromUInteger:(NSUInteger)value {
	return [NSString stringWithFormat:@"%lu", (unsigned long)value];
}

+ (NSString *)fromFloat:(float)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromDouble:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
	return [NSString stringWithFormat:@"%d", value];
}

- (CGFloat)getDrawWidthWithFont:(UIFont *)font {
	CGFloat width = 0.f;

	CGSize textSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	CGRect sizeWithFont = [self boundingRectWithSize:textSize
	                                         options:NSStringDrawingUsesLineFragmentOrigin
	                                      attributes:tdic
	                                         context:nil];

#if defined(__LP64__) && __LP64__
	width = ceil(CGRectGetWidth(sizeWithFont));
#else
	width = ceilf(CGRectGetWidth(sizeWithFont));
#endif

	return width;
}

- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width {
	CGFloat height = 0.f;

	CGSize textSize = CGSizeMake(width, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

	CGRect sizeWithFont = [self boundingRectWithSize:textSize
	                                         options:NSStringDrawingUsesLineFragmentOrigin
	                                      attributes:tdic
	                                         context:nil];

#if defined(__LP64__) && __LP64__
	height = ceil(CGRectGetHeight(sizeWithFont));
#else
	height = ceilf(CGRectGetHeight(sizeWithFont));
#endif

	return height;
}

+ (CGFloat)fontHeight:(UIFont *)font {
	CGFloat height = 0.f;

	NSString *fontString = @"臒";
	CGSize textSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	CGRect sizeWithFont = [fontString boundingRectWithSize:textSize
	                                               options:NSStringDrawingUsesLineFragmentOrigin
	                                            attributes:tdic
	                                               context:nil];

#if defined(__LP64__) && __LP64__
	height = ceil(CGRectGetHeight(sizeWithFont));
#else
	height = ceilf(CGRectGetHeight(sizeWithFont));
#endif

	return height;
}

- (BOOL)isEmpty {
	return ![self isNotEmpty];
}

- (BOOL)isNotEmpty {
	if (self != nil
	    && ![self isKindOfClass:[NSNull class]]
	    && (id)self != [NSNull null]
	    && [[self trimWhitespace] length] > 0) {
		return YES;
	}
	return NO;
}

- (NSInteger)actualLength {
	NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSData *data = [self dataUsingEncoding:encoding];
	return [data length];
}

- (NSString *)trimWhitespace {
	NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
	return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimLeftAndRightWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimHTMLTag {
	NSString *html = self;

	NSScanner *scanner = [NSScanner scannerWithString:html];
	NSString *text = nil;

	while (![scanner isAtEnd]) {
		[scanner scanUpToString:@"<" intoString:NULL];
		[scanner scanUpToString:@">" intoString:&text];

		html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
		                                       withString:@""];
	}
	return [html trimWhitespace];
}

- (BOOL)isWhitespace {
	return [self isEmpty];
}

- (BOOL)isChinese {
	NSString *chineseRegEx = @"[^x00-xff]";
	if (![self isMatchesRegularExp:chineseRegEx]) {
		return NO;
	}
	return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
	NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [emailTest evaluateWithObject:self];
}

- (NSString *)URLRegularExp {
	static NSString *urlRegEx = @"((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\.&]*)";
	return urlRegEx;
}

- (BOOL)isURL {
	NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLRegularExp]];
	return [urlTest evaluateWithObject:self];
}

- (NSArray *)URLList {
	NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:[self URLRegularExp]
	                                                                     options:NSRegularExpressionAnchorsMatchLines | NSRegularExpressionDotMatchesLineSeparators
	                                                                       error:nil];
	NSArray *matches = [reg matchesInString:self
	                                options:NSMatchingReportCompletion
	                                  range:NSMakeRange(0, self.length)];

	NSMutableArray *URLs = [[NSMutableArray alloc] init];
	for (NSTextCheckingResult *result in matches) {
		[URLs addObject:[self substringWithRange:result.range]];
	}
	return URLs;
}

- (BOOL)isCellPhoneNumber {
	NSString *cellPhoneRegEx = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}$";
	NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
	return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
	NSString *phoneRegEx = @"((^0(10|2[0-9]|\\d{2,3})){0,1}-{0,1}(\\d{6,8}|\\d{6,8})$)";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
	return [phoneTest evaluateWithObject:self];
}

- (BOOL)isZipCode {
	NSString *zipCodeRegEx = @"[1-9]\\d{5}$";
	NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegEx];
	return [zipCodeTest evaluateWithObject:self];
}

- (id)jsonObject:(NSError **)error {
	return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
	                                       options:NSJSONReadingMutableContainers
	                                         error:error];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxsize {
	NSDictionary *attrs = @{ NSFontAttributeName : font };
	return [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *)stringCoverToTime {
	if (![self isNotEmpty]) {
		return @"";
	}

	NSInteger mins = [self integerValue];
    
    NSInteger hours = mins / 3600;
    NSInteger minss = (mins - hours * 3600) / 60;
    NSInteger ss = (mins - hours * 3600 - minss * 60) % 60;
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setDateFormat:@"mm:ss"];
	NSDate *date = [NSDate dateWithTimeIntervalSinceNow:mins];
    NSMutableString *timeString = [NSMutableString string];
    if (hours <=0) {
        
    }else{
        [timeString appendFormat:@"0%ld:",hours];
    }
    
    if (minss < 10 && minss > 0) {
        [timeString appendFormat:@"0%ld:",minss];
    }else if (minss >= 10){
        [timeString appendFormat:@"%ld:",minss];
    }else{
        [timeString appendString:@"00:"];
    }
    
    if (ss < 10 && ss > 0) {
        [timeString appendFormat:@"0%ld",ss];
    }else if (ss >= 10){
        [timeString appendFormat:@"%ld",ss];
    }
    
	return timeString;
}

@end
