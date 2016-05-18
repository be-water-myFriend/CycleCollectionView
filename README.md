# PicturePlaysCycle<br />
一:功能<br />
1:图片定时循环播放<br />
2:支持占位图片<br />
3:支持网络下载,下载图片器中已实现(图片沙盒缓存+内存缓存),原理类似SDWebImage.<br />
4:支持图片点击事件处理block,可在创建OPView时传入block代码块.<br />
5:由于图片播放器使用的是UICollectionView的cell重用机制完成,所以在播放大量图片时性能表现良好.<br />
<br />
<br />
二:使用方法<br />
&nbsp; 1&gt;直接将示例demo项目中的&quot;图片循环播放器&quot;文件夹拖入到你的项目<br />
&nbsp; 2&gt;导入必须的头文件 &nbsp;#import &quot;OPView.h&quot;<br />
<br />
<br />
使用方法如下,具体可参照demo项目:<br />
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////<br />
#import &quot;ViewController.h&quot;<br />
#import &quot;OPView.h&quot;<br />
<br />
<br />
@interface ViewController ()<br />
<br />
<br />
@end<br />
<br />
<br />
@implementation ViewController<br />
<br />
<br />
- (void)viewDidLoad {<br />
&nbsp; &nbsp; [super viewDidLoad];<br />
<br />
<br />
&nbsp; &nbsp; //占位图片组<br />
&nbsp; &nbsp; NSArray *images = @[@&quot;Snip20160511_7&quot;,@&quot;Snip20160511_8&quot;,@&quot;Snip20160511_9&quot;,@&quot;Snip20160511_10&quot;,@&quot;Snip20160511_11&quot;];<br />
&nbsp; &nbsp;&nbsp;<br />
&nbsp; &nbsp; //要显示的图片下载链接<br />
&nbsp; &nbsp; NSArray *urls = @[<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @&quot;http://eimg.smzdm.com/201605/17/573b15eb463445149.png&quot;,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @&quot;http://eimg.smzdm.com/201605/17/573aec361b4df1149.jpg&quot;,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @&quot;http://eimg.smzdm.com/201605/17/573aebe95cb3b5329.png&quot;,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @&quot;http://eimg.smzdm.com/201605/17/573b165983aa63667.png&quot;,<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @&quot;http://eimg.smzdm.com/201605/16/5739ae8a13bdf8919.png&quot;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ];<br />
&nbsp; &nbsp; //图片播放器的frame大小<br />
&nbsp; &nbsp; CGRect frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);<br />
&nbsp; &nbsp;&nbsp;<br />
&nbsp; &nbsp; //调用构造方法生成图片播放器<br />
&nbsp; &nbsp; OPView *view = [[OPView alloc]initWithFrame:frame placeholder:images picUrls:urls selectImageHandle:^(NSInteger index) {<br />
&nbsp; &nbsp; &nbsp; &nbsp; NSLog(@&quot;拖拽的是第%zd图片&quot;,index);<br />
&nbsp; &nbsp; }];<br />
<br />
<br />
&nbsp; &nbsp; [self.view addSubview:view];<br />
}
