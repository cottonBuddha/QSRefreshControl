# QSRefreshControl
A customized refreshControl for react-native

##演示/Demo
![demo2.gif](http://upload-images.jianshu.io/upload_images/6277219-219b4ee881f94777.gif?imageMogr2/auto-orient/strip)

## 安装/Installation
将QSRefreshControl文件夹拖至项目中。   
Just drag the folder named QSRefreshControl to your project.
## 使用/Usage
#####1. Add the QSRefreshControl folder to the project, and the following files are included in the folder:    
#####在工程中添加QSRefreshControl文件夹，文件夹内包括了以下文件：
![B9F995FA-3AB8-4EB6-A7CE-C6532C1B3019.png](http://upload-images.jianshu.io/upload_images/6277219-891af3ee524526e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#####2. Create your custom refresh component, here to TangramRefreshControl as an example:
#####自定义刷新组件，这里以TangramRefreshControl为例：
![D7AEF65E-A5B8-4911-B806-90751080CAD6.png](http://upload-images.jianshu.io/upload_images/6277219-5433f39ca5df45bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Prepare the animation view -- Tangram,conformed to QSRefreshMotionProtocol.The processing of each stage of the animation were placed in the corresponding method to achieve.     

先准备遵守QSRefreshMotionProtocol的动画视图Tangram。下拉刷新各阶段动画的处理分别放在对应的方法中实现。



```
  //MARK:实现QSRefreshMotionProtocol
  func draggingBeforeRelease(withOffset offset: CGFloat) {
    updateTangramBy(max(offset - 30, 0) / 90) //根据下拉距离设置动画进度
  }
  
  func releaseAndBeginRefreshing() {
    assembleSevensTo(.fox)
    startShining() //正在刷新时的处理
  }
  
  func stopRefreshingAndBackToOrigin() {
    stopShining() //刷新结束时的处理
  }
  
  func endAll() {
    assembleSevensToOrigin() //完成刷新各阶段，返回到原点
  }
  
  func triggerDistance() -> CGFloat {
    return 120 //触发距离
  }

```
Then create TangramRefreshControl and TangramRefreshControlManager, respectively, inherited QSRefreshControl and QSRefreshControlManager.
TangramRefreshControl, we simply assign the animation view Tangram to the refreshView property in its initialization method (refreshView is inherited from the QSRefreshControl, which is the animation view). Rewrite the "layoutSubviews" method to change the location or size of the refreshView when the scrollview size changes. The code is as follows:     

接着创建TangramRefreshControl和TangramRefreshControlManager，分别继承QSRefreshControl和QSRefreshControlManager。
TangramRefreshControl里，我们只需在其初始化方法中将动画视图Tangram赋给refreshView属性 (refreshView是从QSRefreshControl中继承来的，表示刷新用的动画视图)。再重写下layoutSubviews方法，以便在scrollview大小改变时更改refreshView的位置或大小。(如果确定位置始终不变可以不重写，这里Tangram需要始终在scrollview上方居中，所以重写了下)。代码如下：



```
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.refreshView = [[Tangram alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 25, 0, 50, 70)];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.refreshView.frame = CGRectMake(self.frame.size.width * 0.5 - 25, 0, 50, 70);
}

```
Look at the TangramRefreshControlManager, if you do not need to expose other properties (QSRefreshControlManager has been exposed refreshing and onRefresh), directly below:    

再来看TangramRefreshControlManager，如果不需要暴露其他属性(QSRefreshControlManager中已经暴露了refreshing和onRefresh)，就直接如下了：

```
RCT_EXPORT_MODULE();

- (TangramRefreshControl*)view
{
  return [TangramRefreshControl new];
}
```

#####3. In this way, operation on native side is over, and then look at the useage on js side. Get the refresh component first：
#####这样，原生端的处理就结束了，再来看js端的使用。先获取刷新组件：
```
import {
  requireNativeComponent
} from 'react-native'; 
var Tangram = requireNativeComponent('TangramRefreshControl');
```
next    
接着在scrollview上

```
<ScrollView
  refreshControl={
    <Tangram 
    refreshing={this.state.refreshing}
    onRefresh={this._handleRefresh}
    />}
>
</ScrollView>
```

At this point, it was over. We can see that we still use the refreshControl property of ScrollView to keep in line with the official. Like Flatlist and other components based on ScrollView,we can do the same.    

这样下拉刷新就添加完成了，可以看到我们依然使用了ScrollView的refreshControl属性，做到了与官方的一致（为什么可以这样使用，可以看一下ScrollView的源码哦），其他诸如Flatlist等基于ScrollView封装的组件，一样可以通过这样的方式添加（注意Flatlist不要直接设置onRefresh属性，设置了就默认使用那个菊花刷新了）。

## License
MIT

## Other
[http://www.jianshu.com/p/c58de360a3d4](http://www.jianshu.com/p/c58de360a3d4)