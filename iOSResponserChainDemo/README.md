# 项目介绍


### 参考文章
/*
 事件的传递和响应机制 https://www.jianshu.com/p/2e074db792ba
 消息传递机制 https://objccn.io/issue-7-4/
 */
 
 1. 为什么UIcontrol 的事件会拦截掉 UIResponser的事件，因为其内部方法重写了touch事件

### https://www.jianshu.com/p/b0884faae603
- UIResponder不只用来接收事件，还可以处理和传递对应的事件，如果当前响应者不能处理，则转发给其他合适的响应者处理。
- UIViewController没有hitTest:withEvent:方法，所以控制器不参与查找响应视图的过程
- SuperView的Subview超出了其视图范围，如果点击Subview在父视图外面的部分，则不能响应事件。所以通过重写pointInside:withEvent:方法，将响应区域扩大为虚线区域，包含SuperView的所有子视图，即可让子视图响应事件

- 以UIButton为例，UIButton也是通过hitTest的方式查找第一响应者的。区别在于，如果UIButton是第一响应者，则直接由UIApplication派发事件，不通过Responder Chain派发。如果其不能处理事件，则交给手势处理或响应者链传递。

- 不只UIButton是直接由UIApplication派发事件的，所有继承自UIControl的类，都是由UIApplication直接派发事件的。


### 事件冲突 http://kmanong.top/kmn/qxw/form/article?id=15003&cate=63


### iOS 事件回调机制 https://www.jianshu.com/p/32db17c980f7

### 由手势与 UIControl 冲突引发的「事件处理全家桶」探索 https://juejin.cn/post/6908553699732226061  
优秀文章！！！

### iOS 中的事件响应 https://juejin.cn/post/6989049513172303885


### 从 WebKit 源码中学习手势处理的高级用法——WKWebView中的手势识别 
https://mp.weixin.qq.com/s?__biz=MzA3ODYxMzU5OQ==&mid=2452442907&idx=1&sn=c42be5bac0e9db0f7d2d25845add15bf&scene=21#wechat_redirect

 测试类：ZJWebViewController
 
