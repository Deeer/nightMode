#简书的夜间模式

##具体效果

![nightModes](http://7xjg07.com1.z0.glb.clouddn.com/font%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202016-03-01%20%E4%B8%8A%E5%8D%8810.41.49.png)

 **特点:**

    1.夜间模式只改变颜色,图标未发生改变

    2.在打开夜间模式后，退出应用（杀死进程）。再次点击打开应用仍保持夜间模式。

通常情况下，应用的主题改变都会涉及颜色和图片的改变，所以毫无疑问的是我们需要为两种状态都准备好相应的素材文件


##1.利用单例进行管理

 	1>首先使用单例或者全局对象（appDelegate）记录当前的模式状态。
 	2>用户在切换模式后改变单例对象所记录的状态值
 	3>调用通知在全局通知其他界面设置对应状态的颜色
 	4>在相应界面设置对应的素材或者颜色
 	5>考虑到上面提及的第二个特点，我们还需要使用plist文件，NsuserDefault等方式记录当前选择的模式

**具体的处理方式案例**
 
以下是OSC开源中国客户端的一段源代码。

![oscCode](http://7xjg07.com1.z0.glb.clouddn.com/nightMode30B21D9F-1EC3-4C17-B74C-536902E6D3C0.png)

他们使用AppDelegate（与单例异曲同工）来记录当前模式的改变，与此同时他们还为每种状态设置的对应的颜色。

使用plist文件进行对应版本的素材管理，在设定对应的模式状态后，让app去读取对应的plist文件，进而改变用户需求的模式。

-------------------------------
***注意***

Raywenderlich的教程中提及了一些方法新的思路

>Since iOS 7, UIView has exposed the tintColor property, which is often used to define the primary color indicating selection and
 interactivity states for interface elements throughout an app.
When you specify a tint for a view, the tint is automatically propagated to all subviews in that view’s view hierarchy.
Because UIWindow inherits from UIView, you can specify a tint color for the entire app by setting the window’s tintColor。

从iOS7 开始， UIView就已经暴露了tintColor属性，它经常被定义为整个APP的选择指示的默认颜色和界面元素的交互状态
当你为一个view指定了一个tint，这个tint会自动传播到继承他的所有字类。你可以通过设定window的tintColor给整个app指定颜色

>UIKit has an informal protocol called UIAppearance that most of its controls conform to.
 When you call appearance() on UIKit classes— not instances —it returns a UIAppearance proxy.
 When you change the properties of this proxy, all the instances of that class automatically get the same value.
  This is very convenient as you don’t have to manually style each control after it’s been instantiated.
UIKit 有个非正式的协议叫做UIAppearance

当你的用UIKit类而不是他的实例话对象调用appearance方法的时候，他会返回一个UIAppearance的代理
当你改变这个代理的某个属性时，这个类的所有实例话对象都会自定设定成同样的值
这将非常方便，因为你不用在控制器实例化之后再次手设置每个控制器的样式

>Open Images.xcassets and find the backArrow image in the Navigation group. The image is all black,
but in your app it takes on the tint color of your window and it just works.
just_works
But how can iOS just change the bar button item’s image color, and why doesn’t it do that everywhere?
As it turns out, images in iOS have three rendering modes:
Original: Always use the image “as is” with its original colors.
Template: Ignore the colors, and just use the image as a stencil. In this mode,
iOS uses only the shape of the image, and colors the image itself before rendering it on screen.
 So when a control has a tint color, iOS takes the shape from the image you provide and uses the tint color to color it.
Automatic: Depending on the context in which you use the image, the system decides whether it should draw the image as “original”
or “template”. For items such as back indicators, navigation control bar button items and tab bar images,
iOS ignores the image colors by default unless you change the rendering mode.

素材的颜色都是黑色的，但是显示的却是window对应的tintColor。那么为什么他只改变图片的颜色而不把所有的颜色都改变
那是因为，在iOS中图片有三种渲染模式
Original:图片总使用它自身的颜色。
Template:忽略本身图片的颜色仅仅是将图片设置为一个模版。在这个模式下。iOS只使用图片的形状，然后使用tintColor进行上色
Automatic:取决于你使用图片的上下文，系统会自动选择Original和Template模式。 back indicators, navigation control bar button items and tab bar 都会忽略图片的颜色
除非你更改了他们的渲染模式

Ray家的教程毫无疑问是一种新的方向，但是这种一改都改的方式似乎并不能完美的解决项目的需求问题。
因为，如果我们修改了Label的想背景颜色，那么在整个APP中设置所有用到Label（无论是自带的还是自定义的）
都会统一被修改，即使我们能容忍这一点，我们还是要根据当前用户选择的模式来进行二次处理，做一个补救
措施。

##2.利用method Swizzle方式切换主题颜色

>1.为UIView添加一个reloadAppearace方法

    - (void)reloadAppearance
    {
      // 遍历所有view reloadAppearance
      for (UIView* subView in self.subviews) {
          [subView reloadAppearance];
          }
          [self setNeedsDisplay];
      }
    //遍历所有内部的控件，进行刷新操作

    
>2.利用runtime为系统类添加成员变量

  你可以在成员变量的set方法中进行修改操作
  
    - (void)setSkinTextColorNormal:(int)skinTextColorNormal
    {
    objc_setAssociatedObject(self, skinNormalTextColorKey, [NSNumber numberWithInt:skinTextColorNormal], OBJC_ASSOCIATION_RETAIN);
    
    if (skinTextColorNormal != kColorInvalid) {
        [self setTextColor:__QQGLOBAL_COLOR_USEDEFAULT(skinTextColorNormal, self.skinIsSetDefault)];
        }
      }
      
>3.最后调用reload执行刷新操作

    [self.navigationcontroller.view reloadAppearance];

##3.使用第三方库实现 －－ DKNightVersion

	简单的使用了下这个库，总的来说比方便，封装的也比较合理。
	但是涉及底层runtime，需要慎重使用

##总结：

方法有多，实现效果也不尽相同。在一开始，我们一般都会想到直接修改控件样的方式，做一个全局的通知，然后每一页都调用set方法进行设置。显然这个办法是最笨，最简单，工作量也最大的。OK，其次像OSC客户端一样设置颜色时候做一个动态绑定。可行，如果在项目初期就设定好有夜间模式，那么做起来工作量也不会很大。所以总的来讲，个人认为：在处理单例＋plist文件＋通知的处理方式会相对比较合理。

**相关文章:**

 > http://www.jianshu.com/p/a38850421c56 用单例的方法实现夜间模式

 > http://www.zhihu.com/question/35380146 知乎 iOS 客户端夜间模式是怎么实现的？
 
 > http://www.jianshu.com/p/440eece9ac16 iOS主题切换框架设计

补充： （主题切换）http://www.raywenderlich.com/108766/uiappearance-tutorial UIAppearance Tutorial: Getting Started
相关demo: https://github.com/Deeer/nightMode
