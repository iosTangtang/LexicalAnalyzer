//
//  StatusMap.h
//  LexicalAnalyzer
//
//  Created by Tangtang on 2016/10/11.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusMap : NSObject

@property (nonatomic, copy) NSSet *keyWordSet;
@property (nonatomic, copy) NSSet *operatorSet;
@property (nonatomic, copy) NSSet *delimiterSet;
@property (nonatomic, copy) NSSet *boolSet;


- (NSString *)las_getStatusFromString:(NSString *)str;

@end
