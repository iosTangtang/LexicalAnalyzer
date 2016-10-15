//
//  ViewController.m
//  LexicalAnalyzer
//
//  Created by Tangtang on 2016/10/11.
//  Copyright © 2016年 Tangtang. All rights reserved.
//

#import "ViewController.h"
#import "AnalyzerTool.h"
#import "ResultViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:245 / 255.0 blue:244 / 255.0 alpha:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)analyzerAction:(id)sender {
    NSString *str = [self.textView.text stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    
    AnalyzerTool *tool = [[AnalyzerTool alloc] init];
    
    NSArray *array = [tool las_analyzerWithString:str];
    
    ResultViewController *result = [[ResultViewController alloc] init];
    result.dataArray = array;
    result.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:result animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self.textView resignFirstResponder];
}

@end
