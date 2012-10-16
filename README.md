#TurboX
******************
TurboX是一款下载加速软件，它采用了我的[Tondar API](https://github.com/lqik2004/xunlei-lixian-api-PureObjc)，通过迅雷离线作为中转实现高速下载。   
**TurboX需要您有迅雷离线账号**
**TurboX需要配合Alfred达到最优效果**  
**TurboX[下载链接](https://github.com/lqik2004/TurboX/raw/master/TurboX.alfredextension)**  
**TurboX-NAS[下载链接](https://github.com/lqik2004/TurboX/raw/master/TurboX-NAS.alfredextension)**  
**演示视频[地址](http://d.pr/v/YdYj)**
*******************
###目前支持的下载客户端（不断更新）
* SpeedDownload  
* Aria2c 

我正在陆续加入更多的客户端支持，目前如果在您的Mac上没有找到支持的下载客户端就使用默认的Aria2c下载  
**另外，我需要调查一下你在用什么样的下载客户端，我会把用的比较多的尝试着做一下支持**  
**如果你是TurboX的用户，你可以通过下面的联系方式告诉我你需要的客户端支持，这很重要**
###特性
* 一键下载
* 解决死链
* 支持多种协议下载（http/ftp/ed2k/megnet/thunder/qq/flashget）
* 迅雷快传连接支持
* 自动更新  
* 一键下载到NAS  
**注：一些冷门资源可能无法使用TurboX，正在着手改进**

###安装说明
TurboX可以让您**一键下载**所需要的软件，它的使用也非常简单  
只需要下载TurboX的Alfred扩展包，双击打开  
![](https://img.skitch.com/20120824-cxbd8sf662nm426ui6ujs8dbkg.jpg)  
然后点击“import”即可安装  

###使用
TurboX 使用起来非常简单
用你所设定的快捷键呼出Alfred，输入xz 后面加上要下载的地址就可以
![](https://img.skitch.com/20120824-qdnrd6a467psbwg6q7b9ghmbsy.jpg)  
如果使用NAS版本
![](https://img.skitch.com/20120829-bt233bd47b5x9btg45daqh42bb.jpg)

如果是第一次使用，需要添加一个迅雷离线账号，之后就不需要了  
![](https://img.skitch.com/20120824-kuqm9rss9us87673f5snighe3p.jpg)  
*********************
###TurboX-NAS版本安装说明  
如果你有一个NAS或者更广泛的是有一台可接入局域网或者互联网的电脑，那么就可以使用TurboX-NAS版本
有了它可以一键下载到远程电脑上
为了使用TurboX-NAS，您需要在远程电脑上安装Aria2C  

Mac下使用brew安装：

brew install aria2

Ubuntu 下使用apt-get安装：

sudo apt-get install aria2

然后开启Aria2c的daemon模式，并开启RPC支持，到你**需要**的下载目录执行语句  
```aria2c --enable-rpc --rpc-listen-all --rpc-allow-origin-all  --file-allocation=none --max-connection-per-server=3 --max-concurrent-downloads=3 --continue -D```  
Aria2c会默认打开6800端口，如果怕麻烦也不用去修改  
打开Alfred，找到TurboX-NAS，修改其中的NAS地址如下图：  
![](https://img.skitch.com/20120829-81ch9w59weff9xx6g7gbpupqmc.jpg)  
把横线部分地址换成你自己的，比如在局域网中你的NAS地址为192.168.1.222，那么就是图中的地址，其他的默认不用去修改  
另外，为了更好的体验，我使用了YAAW这个Aria2c前端，默认它会在添加到NAS后自动打开，你可以从这里远程操作NAS上正在下载的任务，如图  
![](https://img.skitch.com/20120829-fihkmfenuhctwxjetp54xjh37n.jpg)  
在第一次使用你依旧需要去设置一下RPC地址如图：  
![](https://img.skitch.com/20120829-mmk3ccgp7tgiekjjjwjijqux8p.jpg)  
和上面一样，写入rpc地址

**以上步骤只需要初次设置一次**  
至于如何安装Aria2c，如果遇到问题Google一般都是可以解决的，安装并不复杂，但是要注意一定要  
**安装1.10版本以上（不包含1.10）**

**********************
###更新日志
* v1.4.1 修复了从2012-10-16日起无法正常下载的问题
* v1.4.0 增加了NAS版本的TurboX
* v1.3.7 增加了对10.8 Notification Center的支持&&更改了下载文件夹中文件的算法（只下载最大）
* v1.3.5 增加了对Aria2c支持，如果没有检测到任何支持的下载客户端则启用Aria2c
* v1.3.1 改写了AppleScript代码，检验Growl防止用户没有打开Growl而意外退出
* v1.3 增加了对Growl支持，给以适当提示。同时增强了连接可靠性
* v1.2 几乎重写了代码，采用了不同的构造方式，更稳定更方便
* v1.0 第一版发布  
 
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