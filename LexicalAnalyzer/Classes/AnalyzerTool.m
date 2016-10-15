//
//  AnalyzerTool.m
//  LexicalAnalyzer
//
//  Created by Tangtang on 2016/10/11.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "AnalyzerTool.h"
#import "StatusMap.h"

@implementation AnalyzerTool

- (NSArray *)las_analyzerWithString:(NSString *)str {
    //初始化结果数组
    NSMutableArray *resultArray = [NSMutableArray array];
    int startPoint, endPoint, operaCount = 0;
    NSUInteger length = str.length;
    
    NSString *temp = nil;
    NSString *result = @"";
    
    StatusMap *map = [[StatusMap alloc] init];
    
    const char *cStra = [str UTF8String];
    
    for (startPoint = 0, endPoint = 0; endPoint < length;) {
        temp = [NSString stringWithFormat:@"%c", cStra[endPoint]];
        if ([map.delimiterSet containsObject:temp]) {
            if (startPoint == endPoint) {
                [resultArray addObject:[self makeDescriptionWithString:temp status:[map las_getStatusFromString:temp]]];
                endPoint++;
                startPoint = endPoint;
                continue;
            }
        } else if([map.operatorSet containsObject:temp] && [map.operatorSet containsObject:[NSString stringWithFormat:@"%c", cStra[startPoint]]]) {
            operaCount++;
            if (operaCount <= 2) {
                endPoint++;
                if (endPoint < length) {
                    continue;
                }
            }
        } else if([self p_isNumber:[NSString stringWithFormat:@"%c", cStra[startPoint]]] && (
                  [temp isEqualToString:@"."] || [self p_isNumber:temp])) {
            endPoint++;
            if (endPoint < length) {
                continue;
            }
        } else if([self p_isChar:[NSString stringWithFormat:@"%c", cStra[startPoint]]] &&
                  ![temp isEqualToString:@" "] && ![map.operatorSet containsObject:temp] &&
                  ![map.delimiterSet containsObject:temp]) {
            endPoint++;
            if (endPoint < length) {
                continue;
            }
        }
        
        operaCount = 0;
        result = @"";
        
        for (int index = 0; index < (endPoint - startPoint); index++) {
            result = [result stringByAppendingFormat:@"%c", cStra[startPoint + index]];
        }
        
        result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (![result isEqualToString:@""]) {
            [resultArray addObject:[self makeDescriptionWithString:result status:[map las_getStatusFromString:result]]];
        }
        
        if ([temp isEqualToString:@" "]) {
            endPoint++;
        }
        startPoint = endPoint;
        
    }

    
    return resultArray;
}

- (NSString *)makeDescriptionWithString:(NSString *)str status:(NSString *)status {
    return [NSString stringWithFormat:@"< %@ , %@ >", str, status];
}

- (BOOL)p_isChar:(NSString *)str {
    NSString *preStr = @"^[a-zA-Z_$]$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", preStr];
    return [predicate evaluateWithObject:str];
}

- (BOOL)p_isNumber:(NSString *)str {
    NSString *preStr = @"^[0-9]$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", preStr];
    return [predicate evaluateWithObject:str];
}

@end
