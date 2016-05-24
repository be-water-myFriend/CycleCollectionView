# CycleCollectionView<br />
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
&nbsp; 3&gt;属性interval用于设置图片的播放间隔时间<br />
&nbsp; 4&gt;属性pageCtrl可以设置页码器的当前页和其它页的颜色<br />

<br />
<br />
具体可参照demo项目:<br />

