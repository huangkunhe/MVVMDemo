//
//  RMLoginViewModel.m
//  MVVMDemo
//
//  Created by river on 2017/3/17.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "RMLoginViewModel.h"

@implementation RMLoginViewModel

#pragma mark - life

-(instancetype)init{
    if (self ==[super init]) {
        
        RACSignal *userNameLengthSig = [RACObserve(self, userName)
                                        map:^id(NSString *value) {
                                            if (value.length > 6) return @(YES);
                                            return @(NO);
                                        }];
        RACSignal *passwordLengthSig = [RACObserve(self, password)
                                        map:^id(NSString *value) {
                                            if (value.length > 6) return @(YES);
                                            return @(NO);
                                        }];
        _loginBtnEnable = [RACSignal combineLatest:@[userNameLengthSig, passwordLengthSig] reduce:^id(NSNumber *userName, NSNumber *password){
            return @([userName boolValue] && [password boolValue]);
        }];
        
    }
    return self;
}

#pragma mark - lazy

-(RACCommand *)loginCommand{
    
    if (!_loginCommand) {
        @weakify(self);
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [self signInWithUsername:self.userName password:self.password complete:^(BOOL success) {
                    [subscriber sendNext:@(success)];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

#pragma mark - pravte

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"username"] && [password isEqualToString:@"password"];
        completeBlock(success);
    });
}

@end
