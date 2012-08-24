#TurboX
******************
TurboX是一款下载加速软件，它采用了我的Tondar API，通过迅雷离线作为中转实现高速下载。  
**TurboX只适用于Mac OS X**  
**TurboX需要您有迅雷离线账号**
**TurboX需要配合Alfred达到最优效果**

**TurboX[下载链接](https://github.com/lqik2004/TurboX/raw/master/TurboX.alfredextension)**
###特性
* 一键下载
* 解决死链
* 支持多种协议下载（http/ftp/ed2k/megnet/thunder/qq/flashget）
* 多通道，原始连接和TurboX加速连接同时下载
* 多线（国内国外资源，均能实现高速下载）  
* 自动更新  
**注：一些冷门资源可能无法启动TurboX，正在着手改进**

###安装说明
TurboX可以让您**一键下载**所需要的软件，它的使用也非常简单  
只需要下载TurboX的Alfred扩展包，双击打开  
![](https://img.skitch.com/20120824-cxbd8sf662nm426ui6ujs8dbkg.jpg)  
然后点击“import”即可安装

![打开](https://img.skitch.com/20120824-me2q6urj7yyphp9we6fwndsdi6.jpg)   
**查找自己插件目录的方法参见后文**  

####特别说明
可能是Alfred插件的bug，或者是我的问题，如果不设定绝对路径的话是无法启动脚本的，引发了一系列问题。  
你也可以看到，TurboX再alfred上的插件采用了AppleScript，然后打开终端，再执行里面的脚本，我承认这是一个比较蛋疼的做法，但尝试了半天直接创建shell script插件，发现只有在勾选silent的时候才能正确执行我的脚本，而TurboX又需要打开一个终端来显示下载进度，所以没办法只能用AppleScript，昨晚临时抱佛脚看了看，弄了几行，差不多能够解决问题。  

为了解决问题就只能麻烦一下去手动设置了。  
上图中的红框标示出来的地方是需要去修改的目录，有个需要注意的   
** 不要使用含有空格的路径，TurboX无法识别（这点可能会在日后的版本去修改）  **  
如果你发现你现在的插件目录中是含有空格的，我建议你去修改一下插件目录，方法如下  
![](https://img.skitch.com/20120824-jcssuw66sgwckk115xgxxdjjr.jpg)    
推荐使用Dropbox作为同步插件（甚至同步别的配置）的工具

**如果，你的路径中有空格，而且又不想改变插件存放位置，那么也可以这样**  （这种方法会使自动更新失效）  
找到插件左侧的列表，右键TurboX，选择其中的“Show in Finder”  
![](https://img.skitch.com/20120824-t4c9pk9qbmmqrwhrc4jeqq29ui.jpg)  
然后  
![](https://img.skitch.com/20120824-g6jjwc86rg983tfaaj41cpy39g.jpg)  
**最后把新位置的路径记录下来，复制到插件中**  
![](https://img.skitch.com/20120824-fccuqr1kpppp84sy62d8bp28if.jpg)  
![](https://img.skitch.com/20120824-pjfccpjur8fsf7q1djxppqt4dh.jpg)  
安装完成
**********************
###使用
TurboX 使用起来非常简单
用你所设定的快捷键呼出Alfred，输入xz 后面加上要下载的地址就可以
![](https://img.skitch.com/20120824-qdnrd6a467psbwg6q7b9ghmbsy.jpg)  

如果是第一次使用，需要添加一个迅雷离线账号，之后就不需要了  
![](https://img.skitch.com/20120824-kuqm9rss9us87673f5snighe3p.jpg)  

准备好之后，会自动弹出终端，其中显示了一些提示信息  
比如：  
![](https://img.skitch.com/20120824-xn9h4xepcswpg85je77yeg6e44.jpg)  


***********************
###性能
TurboX对于一般文件的加速效果还是不错的，也能够解决大部分死链问题  
上图为下载Ubuntu 12.04 dvd.iso的测试成绩，直接从国外下载速度为337KB/S，稍等一会，启动了TurboX加速，速度就会上升到1MB/S左右，效果非常惊人，几乎能够榨干全部带宽。  

对于解决死链的问题也是非常有效果的，比如下图    
![](https://img.skitch.com/20120824-1m5thgia8f3g664xim2r81kh4k.jpg)  

**********************
###原理
aria2+[TondarAPI](https://github.com/lqik2004/xunlei-lixian-api-PureObjc)  
###问题与后续改进
半天时间做的东西，总会有很多不足和问题，需要大家的反馈和包容  
日后会对一些比较严重的问题去改进
###反馈问题
有任何问题可以和lqik2004#gmail.com进行联系  
或者到我的博客[http://res0w.com](http://res0w.com)进行留言  
也可以Follow我的Twitter:[@lqik2004](https://twitter.com/lqik2004)
********************
###许可证
本项目采用[LGPL](http://www.gnu.org/copyleft/lesser.html)许可  
![LGPL](http://www.gnu.org/graphics/lgplv3-147x51.png)