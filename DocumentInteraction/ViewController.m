//
//  ViewController.m
//  DocumentInteraction
//
//  Created by os on 2019/10/17.
//  Copyright © 2019 os. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong) UIDocumentInteractionController *docInteractionController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton*button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame =CGRectMake(20, 100, 100, 50);
    [button setTitle:@"打开" forState:(UIControlStateNormal)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

-(void)buttonClick{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    NSURL *filePathUrl = [NSURL fileURLWithPath:path];
    NSLog(@"filePathUrl=%@",filePathUrl);
    if (filePathUrl != nil) {
        [self setupDocumentControllerWithURL:filePathUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.docInteractionController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        });
    }
    
}
- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    if (self.docInteractionController == nil){
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }else{
        self.docInteractionController.URL = url;
    }
}

#pragma mark 代理方法
//为快速预览指定控制器
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self;
}

//为快速预览指定View
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self.view;
}

//为快速预览指定显示范围
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //    return self.view.frame;
    return CGRectMake(0, 0, self.view.frame.size.width, 300);
}
@end
