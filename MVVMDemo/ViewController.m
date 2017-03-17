//
//  ViewController.m
//  MVVMDemo
//
//  Created by river on 2017/3/17.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "ViewController.h"
#import "RMLoginViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) RMLoginViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    @weakify(self);
   _viewModel = [[RMLoginViewModel alloc]init];
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passWordTextField.rac_textSignal;
    [self.viewModel.loginBtnEnable subscribeNext:^(NSNumber *signupActive) {
        @strongify(self);
        self.loginButton.enabled = [signupActive boolValue];
    }];
    
    self.loginButton.rac_command = self.viewModel.loginCommand;
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSNumber *x) {
        
        bool success = [x boolValue];
        NSLog(@"%@",success?@"成功":@"失败");
        
    }];
    
}


@end
