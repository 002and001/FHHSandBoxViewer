//
//  ViewController.m
//  Demo-OC
//
//  Created by hefanghui on 2018/4/28.
//  Copyright © 2018年 hefanghui. All rights reserved.
//

#import "ViewController.h"
#import "Demo_OC-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.enterButton addTarget:self action:@selector(p_viewSandBox) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_viewSandBox {
    NSString *defaultTitle = [FHHSandboxViewController defaultNavTitle];
    NSString *defaultPath = [FHHSandboxViewController defaultPath];
    FHHSandboxViewController *sandBoxViewerVC = [[FHHSandboxViewController alloc]
                                                    initWithNavTitle:defaultTitle
                                                                path:defaultPath];
    UINavigationController *nav = [[UINavigationController alloc]
                                      initWithRootViewController:sandBoxViewerVC];
    [nav.navigationBar setHidden:YES];
    [nav.navigationBar setTranslucent:YES];
    [self presentViewController:nav animated:YES completion:^{
        sandBoxViewerVC.fhh_enterType = FHHEnterTypePresent;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
