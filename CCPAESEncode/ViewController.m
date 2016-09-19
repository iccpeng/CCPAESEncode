//
//  ViewController.m
//  CCPAESEncode
//
//  Created by DR on 16/9/7.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import "ViewController.h"
#import "CCPAESTool.h"

/**
 *  secrectKey 约定的16位的密钥，需要开发者之间商定。
 */
#define secrectKey @"1234567890123456"

@interface ViewController ()

@property (nonatomic,strong) NSMutableDictionary *dict;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     
     DEMO 下载地址  https://github.com/IMCCP
       
     项目中用到AES加密，在这里整理成篇，供大家参考阅读，在使用该demo过程中，你可能会
     遇到一些问题，首先你需要看一下下面的demo简介，看看该demo 是否适合你的项目。
     
     DEMO简介:
     
     项目中的AES加解密主要用在网络请求过程中对上传的参数进行加密，对从后台服务器获取的数据进行解密。
     
     整体的加密流程为:
     
     加密的过程: 参数字典 --> json字符串 --> base64加密后的字符串 --> AES加密后base64再加密 --> 输出最终加密后的字符串;
     
     解密的过程： 后台服务器获取加密的字符串 -->base64解密 --> AES解密后base64解密 --> json字符串 --> 数据字典;(与加密的过程相反)
     
     网上对AES的详细介绍已经有很多，在这里不做赘述，如果你需要了解这些知识，度娘，GOOGLE
     都是不错的选择.
     
     在这里感谢这些 blog 的作者,让我在开发过程中少走了很多弯路:
     
     http://www.open-open.com/lib/view/open1453530956573.html
     
     http://blog.csdn.net/huangwenkui1990/article/details/48292865
     
     http://blog.csdn.net/j_akill/article/details/44079597
     
     https://wordpress-xiaominfc.rhcloud.com/?p=22#comment-12
     
     http://www.360doc.com/content/15/1012/10/20918780_505049436.shtml
     
     公司后台为PHP,移动端有iOS与Android, 通过讨论我们选择AES的加密模式为
     AES128 + ECB + NoPadding (注意是否满足你的加密需求)。
     
     为什么选择这种加密模式:
     因为AES的加密规则 --> 原输入数据不够16字节的整数位时，就要补齐。因此就会有padding(填充模式)，若使用不同的padding，那么加密出来的结果也会不一样。
     如果采用PKCS7Padding或者PKCS5Padding这种加密方式，末端添加的数据可能不固定，
     在解码后需要把末端多余的字符去掉，比较棘手。
     如果不管补齐多少位，末端都是'\0',去掉的话比较容易操作。
     
     最主要的是能够使得 iOS/Android/PHP 能够通信，也是加密过程中最难搞的地方，尤其需要开发者注意。（注意：别的加密模式也可以完成三者之间的通信，只是查找方法的时候 AES128 + ECB + NoPadding 这种加密方式使用的比较多，希望能有更好用的加密方式）
     
     项目中用到了 google 的 base64 加解密库 GTMBase64，但是这个库已经有很多年没有更新 还是 MRC 开发模式，需要手动配置一下：
     
     1，选择项目中的Targets，选中你所要操作的Target，
     2，选Build Phases，在其中Complie Sources中选择需要ARC的文件双击，
     并在输入框中输入 -fno-objc-arc
     
     项目中遇到的一些坑，在项目中都已经注释出来，写的比较清楚，如果该 demo 帮助了您，
     也希望能给个 star 鼓励一下，如果在使用中您有任何问题，可以在 github issue,我会尽自己能力给您答复 。
     */

    self.dict = [NSMutableDictionary dictionary];
    self.dict[@"HELLO"] = @"WORLD";
    self.dict[@"GIT"] = @"HUB";
    self.dict[@"https"] = @"https://github.com/IMCCP";
}

//加密
- (IBAction)clickEncodeBtn:(UIButton *)sender {
    
   NSString *AESString  = [CCPAESTool inputDictionary:self.dict andSecretKey:secrectKey];
    self.showLabel.text = AESString;
    
}

//解密
- (IBAction)clickDecodeBtn:(UIButton *)sender {
    
    //上面加密的结果
    NSString *AESString = @"yNgE5k1LAo7jfWk4oLqQv2uuzOcnC+qKZC0d/69BcPy0NjpSARLfyziuoOe34ZIaVPo7V6Duz7w/SE2Y9jXVIIWbqJoMCWjnTTdnB9n/omo0ZZd7wlVeg8/Qq6nUdiLg7SAM7a5ulatguSWh/S1E+Ni1mEjHZwyUsptU0jeeLno=";
    //解密
    NSDictionary *dict = [CCPAESTool inputBase64String:AESString andSecretKey:secrectKey];
    
    NSString *jsonString = [CCPAESTool dictionaryToJson:dict];
    
    self.showLabel.text = jsonString;
    
}

@end
