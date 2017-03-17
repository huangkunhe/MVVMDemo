//
//  RMLoginViewModel.h
//  MVVMDemo
//
//  Created by river on 2017/3/17.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMLoginViewModel : NSObject

@property(nonatomic, copy) NSString* userName;
@property(nonatomic, copy) NSString* password;

@property(nonatomic, strong) RACCommand *loginCommand;
@property(nonatomic,strong)RACSignal *loginBtnEnable;

@end
