# CCPAESEncode

AES加密（后台服务器为PHP）

## DEMO GIF

![Image text](https://github.com/IMCCP/CCPAESEncode/blob/master/CCPAESEncode/AES.gif)

## DEMO 简介
```
最近用到AES加密，在这里整理成篇，供大家参考阅读，在使用该demo过程中，首先你需要看一下demo简

介，查看是否适合你的项目。

本DEMO AES加密流程为:

加密的过程: 参数字典 --> json字符串 --> base64加密后的字符串 --> AES加密后base64再加密 --> 输出最终加密后的字符串;
     
解密的过程： 

获取加密的字符串 -->base64解密 --> AES解密后base64解密 --> json字符串 --> 数据字典;(与加密的过程相反)
 
网上对AES的详细介绍已经有很多，在这里不做赘述，如果你需要了解这些知识，度娘，google 去吧.
 ```

 在这里感谢这些 blog 的作者,让我在开发过程中少走了很多弯路:
 
 [http://www.open-open.com/lib/view/open1453530956573.html](http://www.open-open.com/lib/view/open1453530956573.html)
 
 [http://blog.csdn.net/huangwenkui1990/article/details/48292865](http://blog.csdn.net/huangwenkui1990/article/details/48292865)
 
 [http://blog.csdn.net/j_akill/article/details/44079597](http://blog.csdn.net/j_akill/article/details/44079597)
 
 [https://wordpress-xiaominfc.rhcloud.com/?p=22#comment-12](https://wordpress-xiaominfc.rhcloud.com/?p=22#comment-12)
 
 [http://www.360doc.com/content/15/1012/10/20918780_505049436.shtml](http://www.360doc.com/content/15/1012/10/20918780_505049436.shtml)

 ```     
AES的加密规则 ： 原输入数据不够16字节的整数位时，就要补齐。因此就会有padding(填充模式)，若使用不同的padding，那么加密

出来的结果也会不一样。

demo 中采用末尾补0 的填充方式(一定注意要保证安卓，服务端（PHP），还有iOS端一致，尤其需要开发者注意)。
     
demo中用到了 google 的 base64 加解密库 GTMBase64，但是这个库已经有很多年没有更新 还是 MRC 开发模式，需要手动配置一下：

1.选择项目中的Targets，选中你所要操作的Target，

2.选Build Phases，在其中Complie Sources中选择需要ARC的文件双击，并在输入框中输入 -fno-objc-arc
```

## DEMO 使用示例
```
//加密

- (IBAction)clickEncodeBtn:(UIButton *)sender {
 
NSMutableDictionary *dict = [NSMutableDictionary dictionary];

dict[@"HELLO"] = @"WORLD";
    
dict[@"GIT"] = @"HUB";
    
dict[@"https"] = @"github.com/IMCCP";

 NSString *AESString  = [CCPAESTool inputDictionary:self.dict andSecretKey:secrectKey];
    
 self.showLabel.text = AESString;
    
}
```
```
//解密

- (IBAction)clickDecodeBtn:(UIButton *)sender {
    
    //上面加密的结果
    NSString *AESString = @"yNgE5k1LAo7jfWk4oLqQv5YHxhBSOG0g6SjdFJoatZ2oTDL+jv1TpL7KWVcbMTH85kQCEFX9KWbsgegrwZ3JgrQ99I70Fd

    LKjSieKe7rfTz1qmbL9gBoe8GJz3TeqmIs7252agKLSDofW8J3mK8y1F4Y3tdnMGsWO9DZLhS/1v0=";
    
    //解密
    
    NSDictionary *dict = [CCPAESTool inputBase64String:AESString andSecretKey:secrectKey];
    
    NSString *jsonString = [CCPAESTool dictionaryToJson:dict];
    
    self.showLabel.text = jsonString;
    
}
```
     
如果在使用中您有任何问题，可以在 github issues,我会尽自己能力给您答复 。

 
 
