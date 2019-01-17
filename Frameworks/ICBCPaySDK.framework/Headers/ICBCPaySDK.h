//
//  ICBCPaySDK.h
//  ICBCPayDemo
//
//  Created by wq on 16/9/26.
//  Copyright © 2016年 wq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PayWay) {
    ICBCePay   = 22,
    WeChatPay = 23,
    AliPay        = 24
};
@protocol ICBCPaySDKDelegate <NSObject>
@required
/**
 *  调用工银e支付以后的结果回调
 *
 *  @param resultCode 支付结果
 *  @param dic        回调的字典，参数中，ret_msg会有具体错误显示
 */
- (void)paymentEndwithResultDic:(NSDictionary*)dic;

/**
 *  调用微信以后的结果回调
 *
 *  @param dic        回调的字典，参数中，errCode会有具体错误显示
 */
-(void)wxPayEndwithResultDic:(NSDictionary*)dic;
///支付宝支付结果回掉
-(void)aliPayEndwithResultDic:(NSDictionary*)dic;
@end

/** 单例作为微信支付的代理 */
@interface ICBCPaySDK : NSObject

/**
 *  单例sdk
 *
 *  @return
 */
+ (ICBCPaySDK *)sharedSdk;

/** 代理 */
@property (nonatomic, weak) id<ICBCPaySDKDelegate>  sdkDelegate;

/**
 *  工行支付 支付接口
 *
 *  @param viewController 推出工行支付支付界面的ViewController
 *  @param traderInfo     交易信息
 */
- (void)presentICBCPaySDKInViewController: (UIViewController *)viewController
                          andTraderInfo: (NSDictionary *)traderInfo;

/**
 *  微信支付 支付接口
 *
 *  @param viewController 推出微信支付界面的ViewController
 *  @param traderInfo     交易信息
 */
-(void)presentWeChatInViewController:(UIViewController *)viewController
                       andTraderInfo:(NSDictionary *)traderInfo;
/**
 *  支付列表接口 支付接口
 *
 *  @param viewController 推出支付列表的ViewController
 *  @param traderInfo     交易信息
 */
-(void)presentPayListViewController:(UIViewController *)viewController
                            showDic:(NSDictionary *)merID
                      addTraderInfo:(NSDictionary *)traderInfo
                     addTraderInfo2:(NSDictionary *)traderInfo2;
///支付宝支付 接口
-(void)presentAlipaySDKViewController:(UIViewController *)viewController
                        andTraderInfo:(NSDictionary *)traderInfo;
/**
 
 *  支付回跳App
 *
 *  @param url         支付完成回调的URL信息
 */
- (void)ICBCResultBackWithUrl: (NSURL *)url;

/**
 
 *  获取支付SDK的版本号
 *
 */
- (NSString *)getVersion;


/** 测试环境，请配置urlListmain 和urlPortal */

@property (nonatomic, strong) NSString *urlListMain;//支付平台地址
@property (nonatomic, strong) NSString *urlPortal;//手机银行地址

@end
