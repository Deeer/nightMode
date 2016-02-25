#简书的夜间模式
 
 **特点:**
 	
    1.夜间模式只改变颜色,图标未发生改变
    
    2.在打开夜间模式后，退出应用（杀死进程）。再次点击打开应用仍保持夜间模式。


首先明确一点：基于lunchr的夜间模式，很有可能需要替换图片素材，那么就需要准备两套素材进行替换。简书的夜间模式没有替换
	      图标，因为他的图标本身明度不是很高，在切换夜间模式的候只需替换整体的颜色就可以达到夜间模式的效果。
			        相比而言，不替换图片的效果会比较好
	
##1.利用单例进行管理
 	
 	1>首先使用单例或者全局对象（appDelegate）纪录当前的模式状态。
 	2>用户在切换模式后改变单例对象所纪录的状态值
 	3>调用通知在全局通知其他界面设置对应状态的颜色
 	4>在相应界面设置对应的素材或者颜色
 	5>考虑到上面提及的第二个特点，我们还需要使用plist文件，NsuserDefault等方式纪录当前选择的模式
 
 以下是OSC开源中国客户端的一段源代码。
 
![oscCode](http://7xjg07.com1.z0.glb.clouddn.com/nightMode30B21D9F-1EC3-4C17-B74C-536902E6D3C0.png)

他们使用AppDelegate（与单例异曲同工）来记录当前模式的改变，与此同时他们还为每种状态设置的对应的颜色。

也有使用plist文件进行对应版本的素材管理，在设定对应的模式状态后，让app去读取对应的plist文件，进而改变用户需求的模式。


##2.使用第三方库实现 －－ DKNightVersion

	简单的使用了下这个库，总的来说比方便，封装的也比较合理。

相关demo: https://github.com/Deeer/nightMode
	

总结：

相关文章：  http://www.jianshu.com/p/a38850421c56 用单例的方法实现夜间模式
        http://www.zhihu.com/question/35380146 知乎 iOS 客户端夜间模式是怎么实现的？
	    
补充： （主题切换）http://www.raywenderlich.com/108766/uiappearance-tutorial UIAppearance Tutorial: Getting Started
