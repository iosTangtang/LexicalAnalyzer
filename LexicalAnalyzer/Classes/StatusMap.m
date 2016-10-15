//
//  StatusMap.m
//  LexicalAnalyzer
//
//  Created by Tangtang on 2016/10/11.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "StatusMap.h"

@interface StatusMap ()

@end

@implementation StatusMap

- (NSSet *)keyWordSet {
    if (_keyWordSet) {
        return _keyWordSet;
    }
    
    _keyWordSet = [NSSet setWithObjects:@"auto",@"break",@"case",@"char",@"const",@"continue",@"default",@"do",@"double",@"else",@"enum",@"extern",@"float",@"for",@"goto",@"if",@"int",@"long",@"register",@"return",@"short",@"signed",@"sizoef",@"static",@"struct",@"switch",@"typedef",@"union",@"unsigned",@"void",@"volatile", @"while", nil];
    
    return _keyWordSet;
}

- (NSSet *)operatorSet {
    if (_operatorSet) {
        return _operatorSet;
    }
    
    _operatorSet = [NSSet setWithObjects:@"->",@".",@"!",@"~",@"++",@"--",@"-",@"*",@"&",@"sizeof",@"+",@"-",@"/",@"%",@"<<",@">>",@"<",@"<=",@">",@">=",@"==",@"!=",@"&",@"^",@"|",@"&&",@"||", @"=", nil];
    
    return _operatorSet;
}

- (NSSet *)delimiterSet {
    if (_delimiterSet) {
        return _delimiterSet;
    }
    
    _delimiterSet = [NSSet setWithObjects:@"/*", @"*/", @"{", @"}", @"[", @"]", @"(", @")", @",", @";", @"'", @"\"", @"//", @"\\", nil];
    
    return _delimiterSet;
    
}

- (NSSet *)boolSet {
    if (_boolSet) {
        return _boolSet;
    }
    
    _boolSet = [NSSet setWithObjects:@"YES", @"NO", @"TRUE", @"FALSE", @"true", @"false", nil];
    
    return _boolSet;
}

- (NSString *)las_getStatusFromString:(NSString *)str {
    NSString *status;
    
    if ([self.keyWordSet containsObject:str]) {
        status = @"关键字";
    } else if ([self.operatorSet containsObject:str]) {
        status = @"运算符";
    } else if ([self.delimiterSet containsObject:str]) {
        status = @"界符";
    } else if ([self p_isInt:str] || [self p_isFloat:str] || [self p_isBool:str]) {
        status = @"常量";
    } else {
        status = @"标识符";
    }
    
    return status;
}

- (BOOL)p_isInt:(NSString *)str {
    int val;
    NSScanner *scan = [NSScanner scannerWithString:str];
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)p_isFloat:(NSString *)str {
    double fla;
    NSScanner *scan = [NSScanner scannerWithString:str];
    return [scan scanDouble:&fla] && [scan isAtEnd];
}

- (BOOL)p_isBool:(NSString *)str {
    return [self.boolSet containsObject:str];
}

@end
