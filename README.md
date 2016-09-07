# CCPAESEncode

一行代码完成AES加密，加密模式 AES128 + CBC + NoPadding

## DEMO 简介

最近项目中用到AES加密，在这里整理成篇，供大家参考阅读，在使用该demo过程中，你可能会遇到一些问题，首先你需要看一下下面的demo简

介，看看该demo 是否适合你的项目。

项目中的AES加解密主要用在网络请求过程中对上传的参数进行加密，对从后台服务器获取的数据进行解密。

整体的加密流程为:

加密的过程: 参数字典 --> json字符串 --> base64加密后的字符串 --> AES加密后base64再加密 --> 输出最终加密后的字符串;
     
解密的过程： 

后台服务器获取加密的字符串 -->base64解密 --> AES解密后base64解密 --> json字符串 --> 数据字典;(与加密的过程相反)
 
 网上对AES的详细介绍已经有很多，在这里不做赘述，如果你需要了解这些知识，度娘，google 去吧.
 
 在这里感谢这些 blog 的作者,让我在开发过程中少走了很多弯路:
 
 （http://www.open-open.com/lib/view/open1453530956573.html）
     
 （http://blog.csdn.net/huangwenkui1990/article/details/48292865）
     
 （http://blog.csdn.net/j_akill/article/details/44079597）
     
 （https://wordpress-xiaominfc.rhcloud.com/?p=22#comment-12）
     
 （http://www.360doc.com/content/15/1012/10/20918780_505049436.shtml）
 
 
