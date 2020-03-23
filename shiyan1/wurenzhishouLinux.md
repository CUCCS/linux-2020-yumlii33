# 无人值守Linux安装
## 基本工具
* windows10 本机
* Oracle VM VirtualBox
* putty
* ubuntu-18.04.4-server-amd64.iso
## 基本步骤
* [有人值守下配置好一台双网卡的Linux虚拟机](#一、有人值守下配置好一台双网卡的Linux虚拟机)
* [利用该虚拟机完成镜像制作](#二、利用虚拟机完成镜像制作)
* [无人值守安装](#三、无人值守安装)
* [问题与解决](#四、问题与解决)
## 过程
#### 一、有人值守下配置好一台双网卡的Linux虚拟机

（1）有人值守安装好一台Linux18.04的虚拟机  
（2）采用虚拟介质管理的方式clone一台linux18.04的虚拟机  【clone】  
（3）配置双网卡 NET+Host-Only  
（4）进入虚拟机clone开启双网卡并查看IP地址

```
//
sudo vi /etc/netplan/01-netcfg.yaml
//
  enp0s8:
    dhcp4: yes
//
sudo netplan apply
//
ifconfig -a
```

![IP地址](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/ip.PNG)  

#### 二、利用该虚拟机完成镜像制作

（1）#利用psftp把镜像传入虚拟机  
```
open cuc@192.168.56.101

//输入password


cd /home/cuc

//此处修改了ubuntu-18.04.4-server-amd64.iso名称
put 1.iso
```
![putISO](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/putISO.PNG)

（2）利用putty连接虚拟机【clone】（putty里面方便粘贴）  
![putty](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/putty.PNG)

（3）在/home/cuc(当前目录下)创建一个用于挂载iso镜像文件的目录  
`mkdir loopdir`  

（4）挂载iso镜像文件到该目录(loopdir)  
`sudo mount -o loop 1.iso loopdir`  

（5） 创建一个工作目录用于克隆光盘内容  
`mkdir cd`  

（6）同步光盘内容到目标工作目录  
`rsync -av loopdir/ cd`

（7） 卸载iso镜像  
`sudo umount loopdir`

（8）进入目标工作目录  
`cd cd/`  

（9）编辑Ubuntu安装引导界面增加一个新菜单项入口  
`vim isolinux/txt.cfg`

（10）添加以下内容到该文件首部（default install）下面  

```
label autoinstall
  menu label ^Auto Install Ubuntu Server
  kernel /install/vmlinuz
  append  file=/cdrom/preseed/ubuntu-server-autoinstall.seed debian-installer/locale=en_US console-setup/layoutcode=us keyboard-configuration/layoutcode=us console-setup/ask_detect=false localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz root=/dev/ram rw quiet ---
```  

![label autoinstall](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/labelAutoinstall.PNG)  

（11）强制保存退出  
`:wq!`  

（12）将seed文件保存到刚才创建的工作目录/home/cuc/cd/preseed/ubuntu-server-autoinstall.seed
（这里使用的是老师给的seed文件） 

`put D:\Linux\wuren\ubuntu-server-autoinstall.seed /home/cuc/cd/preseed/ubuntu-server-autoinstall.seed`  

(13)重新生成md5sum.txt  

```
sudo su -

cd /home/cuc/cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt
```  

（14）封闭改动后的目录到.iso  

```
IMAGE=custom.iso

BUILD=/home/cuc/cd/

mkisofs -r -V "Custom Ubuntu Install CD" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o $IMAGE $BUILD
```

(15)打开pfstp窗口查看custom.iso,并下载到本地

```
ls

get custom.iso
```

#### 三、无人值守安装
（1）使用custom.iso创建虚拟机  
（2）安装  
这里并不是完全自动，前面还需要手动点击两步。  
![anzhuang1](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/anzhuang1.PNG)  
![anzhuang2](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/anzhuang2.PNG)  
![anzhuang3](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/anzhuang3.PNG)

#### 四、问题与解决

* 在使用psftp传送seed文件时，报错:  
![wrong1](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch1/shiyan1/img/wrong1.PNG)  
错误原因：psftp对该文件夹没有write的权限
解决方法：  
`chmod 777 /home/cuc/cd/preseed`

* mkisofs命令报错：  
![截图失败](..)  
解决方法：  
`apt-get update`  
`apt-get install genisoimage`  

## 参考资料

（1）[无人值守Linux安装镜像制作_运维_wujiahua的博客-CSDN博客.html](https://blog.csdn.net/qq_31989521/article/details/58600426)  

（2）[psftp的用法（超级详细）_运维_赵晓雷的专栏-CSDN博客.html](https://blog.csdn.net/zxl315/article/details/5955202)  

（3）[Linux常用命令：chmod修改文件权限 777和754_运维_pythonw的博客-CSDN博客.html](https://blog.csdn.net/pythonw/article/details/80263428)  

（4）[Linux chmod命令修改文件与文件夹权限方法_运维_Kevin的博客-CSDN博客.html](https://blog.csdn.net/starshinning975/article/details/71036921)  

（5）[关于github上的README.md文件不能显示图片信息 - 简书.html](https://www.jianshu.com/p/ae49c026aacf)