//
//  ViewController.m
//  keychain加密
//
//  Created by AY on 2017/5/24.
//  Copyright © 2017年 AY. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"
#define kBundleID @"alexanderTest"
@interface ViewController ()
    
    @property (weak, nonatomic) IBOutlet UITextField *usernameField;
    @property (weak, nonatomic) IBOutlet UITextField *pwdField;
   
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 登录按钮的点击

/**
 一般用户注册之后，会将用户的账户和密码存在本地，但是都不会以明文的形式存储在本地，最为安全的做法就是使用苹果的钥匙串,来记录密码，其采用的是AES 加密算法，较为安全
 
 使用的话，
 1>  就是导入SSKeychain.h
 2>  iOS10 之后，需要在项目工程中 Cabilities 中的Keychain Sharing 选项中开启on
 
 */
- (IBAction)loginBtnClick:(id)sender {
    
    // 用户一旦输入username 有长度，就去加载本地的密码
    
    if (self.usernameField.text.length > 0) {
        // 去钥匙串取得密码
        NSError *error = nil;
        self.pwdField.text = [SSKeychain passwordForService:kBundleID account:self.usernameField.text error:&error];
   
        if (!error) {
            NSLog(@"取得本地数据成功");
        }else{
            NSLog(@"取得本地密码失败或者密码不存在");
        }
    }
}
 
    
- (IBAction)registBtnClick:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *pwd = self.pwdField.text;
    
    // 将密码保存到本地
    
    /**
     将密码存入本地的方法
     参数1: 用户的密码
     参数2：服务名，一般都是此APP的 bundle ID,保证唯一性
     参数3：用户的账户，要通过账户将密码取出来
     
     */
    NSError *error = nil;
    [SSKeychain setPassword:pwd forService:kBundleID account:username error:&error];
    
    if (!error) {
        NSLog(@"存数据成功");
    }
}
    
@end
