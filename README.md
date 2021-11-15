# ICBCPaySDK
工行e支付

## iOS工行支付SDK使用文档
**最后修改日期：2021/10/09**
**商户务必更新到AFN4.0版本！！！**
### 1、场景介绍

商家APP调用工行软开中心提供的SDK调用客户端内的支付模块，如果用户安装了工行App，商家APP会跳转到App中完成支付，支付完后跳回到商家APP内，最后展示支付结果。如果用户没有安装工行App，会在SDK内启动支付页面进行支付，支付完成后，跳转回到商户界面。


### 2、快速接入

2.1 接入ICBCPaySDK的静态库ICBCPaySDK.framework及资源包ICBCPaySDK.bundle，如下图所示。


如工程有多个target，请检查build Phases相关文件是否成功引入。



2.2、接入工程所需第三方组件。AFN网络请求框架、toast组件。具体如下图所示。



具体地址如下可参照下表。
网络请求框架     AFNetWorkworking    4.0版本
    地址：`https://github.com/AFNetworking/AFNetworking/`
toast组件
    uiview+toast.view：地址：`https://github.com/scalessec/Toast`
其中：AFNetworkorking时用的4.0版本，可以在README.md中查看


查看版本号方法：



### 3、代码示例

 ####   3.1 引入 ICBCPaySDK.h文件,创建应用单例。
 ```
    #import  < ICBCPaySDK/ ICBCPaySDK.h>
        ICBCPaySDK *shareSDK = [ICBCPaySDK sharedSdk];
        shareSDK.sdkDelegate = self;
       shareSDK.urlListMain =   @https://b2c.icbc.com.cn 请务必配置此生产地址（支付平台地址）
```

注意：以上两个地址，在测试阶段应该配置模测环境地址，以便报错后查找日志。

####   3.2传入支持参数，弹出支付页面

（1）interfaceName
接口名 
（2）interfaceVersion
接口版本号
（3）tranData
交易信息
（4）merSignMsg
 交易信息签名
 （5）merCert
商户公钥文件信息
 （6）urlScheme
应用包名，必须传入，否则跳转至工行App无法返回。
```
    NSMutableDictionary *testDic = [[NSMutableDictionary alloc] init];
    testDic[@"urlScheme"] = urlScheme;
    testDic[@"interfaceName"] =interfaceName;
    testDic[@"interfaceVersion"] = interfaceVersion;
    testDic[@"tranData"] = tranData;
    testDic[@"merSignMsg"] = merSignMsg;
    testDic[@"merCert"] = merCert;
    [shareSDK presentICBCPaySDKInViewController:self  andTraderInfo:testDic];

    //传入的self，为弹出支付页面的viewcontroller。SDK会对traderInfo的字段进行检查，发现字段为空，导致交易无法进行会进行toast提示。
```
####   3.3代理结果回调

支付完成或者失败时，会回调此方法，商户端可根据返回的信息自行处理。
```
     - (void)paymentEndwithResultDic:(NSDictionary*)dic｛

            NSLog(@"pass the pkpaymentAuthorizationstatus to the page");
                 [self.view makeToast:@“支付成功，商户端自行处理"];
      ｝
```
     字典如下格式如下：
       tranCode:交易结果代码
       tranMsg:交易结果信息
       orderNo：订单号

####   3.4 如果跳转至工行app支付，需要在 AppDelegate.m中添加如下实现。


 iOS9.0以下版本，请实现如下方法     
 ```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:               
    (nullable NSString *)sourceApplication annotation:(id)annotation {

     if ([[url absoluteString] hasSuffix:@"ICBCB2CPAY"]) {
         [[ICBCPaySDK sharedSdk] ICBCResultBackWithUrl:url];
          }
            
      return YES;
}
```

iOS9.0以上版本请实现如下方法。
```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:    (NSDictionary<NSString*, id> *)options{
           
        if ([[url absoluteString] hasSuffix:@"ICBCB2CPAY"]) {
            [[ICBCPaySDK sharedSdk] ICBCResultBackWithUrl:url];
        }
    
        return YES;
}
```


####   3.5项目设置urlscheme
在Xcode中打开项目，设置项目属性中的URL Schemes 为子商户的应用包名。如图所示。（此处配置需要与上面传入的保持一致）


    
    ####   3.6 tranCode 对应关系

tranCode与tranMsg的对应关系：
1--交易成功，已清算
2--交易失败
3--交易可疑
4--用户中止交易


    
### 4、注意事项


####   4.1 SDK付款有两种模式：如果外部存在手机银行客户端，则直接跳转到工行手机银行付款；不存在的场景下，在SDK内部进行H5支付。由于需要启动工行客户端，SDK在构件内调用了 canOpne方法，请在plist文件中，增加工行相应app的白名单。
com.icbc.iphoneclient     融e行
com.icbc.iphoneEChannel  融e联
com.icbc.iphone.emall     融e购
cn.com.icbc.eMallMobileClient 融e购
com.icbc.elife    工银e生活


####   4.2 该版本SDK支持iOS 7.0以上版本。其他未尽事宜，可参照demo工程。

### 5、特别注意
这部分是给工行软开同时看的，提供SDK的时候注意Toast和AFNetWork文件


左边是打Framework用的工程，右边是模拟商户的工程，此时左右两边工程的的AFnetwork文件夹一样的引用15个文件。这时候编译右侧，报错如下

报错的意思大概就是：重复定义。
解决方案：
第一种：把右侧的商户工程里的AFNET文件夹全部删掉，保留左侧全部15个文件引用不动，这种不太好，因为商户APP一般是会引入AFN文件的。所以如果这样SDK提供出去，到了商户那边还是会报重复的错误。
第二种：本质是.m文件重复，所以，在左侧把.m文件都删除，.m文件不引入左侧工程,.h保留不变，右侧工程保持不变。


这样就可以了。
可以看到提供出去的framework里第三方组件Toast也是只保留.h文件，这样在商户端可以全部引用.m .h

2、这里的回调ICBCWebViewJavascriptBridge.js，取的是商户测集成的ICBCPaySDK.Bundle，所以打framwork时不需要把ICBCPaySDK.Bundle关联进去。如下图


