# 第三章 实验三

## 实验环境

- Ubuntu18.04 Server 64bit

## 实验任务

- Systemd 入门教程：命令篇 by 阮一峰的网络日志
- Systemd 入门教程：实战篇 by 阮一峰的网络日志

## 实验录像

### 入门篇

[1.3](https://asciinema.org/a/u3MvlpCLQLMqD8CwXBa3bQgxD)&[1.4](https://asciinema.org/a/cYTQnzAKmSIw01RKVAlm7ybbW)&[1.5](https://asciinema.org/a/sUgdpuUGTmCMDM9v5VH8qBe3W)&[1.6](https://asciinema.org/a/IQH73ofZwmJYC762K3oOjAVzK)&[1.7](https://asciinema.org/a/r4j3ldKPOLwyjNtfkozL0yJDS)

### 实战篇

 [2.1&2.2&2.3](https://asciinema.org/a/gI8zgDQAZMh7EGo8JcxHe83Lz)

[2.4&2.5&2.6&2.7&2.8&2.9](https://asciinema.org/a/eOA2w7cLEiDBQQ7lIygQPma3i)

## 自查清单

1. 如何添加一个用户并使其具备sudo执行程序的权限？

   ```
   #方法1：
   #root 用户下进行操作或sudo
   useradd username
   usermod -a -G adm username
   
   #方法2：
   #root 用户下进行操作或sudo
   useradd username
   vi /etc/sudoers
   #找到root   ALL=(ALL)   ALL，并在下面添加一行
   username ALL=(ALL) ALL
   
   ```

2. 如何将一个用户添加到一个用户组？

   ```
   usermod -a -G groupname username
   ```

3. 如何查看当前系统的分区表和文件系统详细信息？

   ```
   fdisk -l
   ```

4. 如何实现开机自动挂载Virtualbox的共享目录分区?

   ```
   # 1、用VirtualBox虚拟机的共享文件夹设置共享的本地文件
   # D:\ubuntu1804Share
   
   # 进入虚拟机Ubuntu系统，打开终端，用root用户操作
   # 2、创建共享目录
   mkdir /mnt/share
    
   # 3、实现挂载
   mount -t vboxsf Ubuntu1804Share /mnt/share
   # 4、实现开机自动挂载功能
   # 在文件 /etc/rc.local 中（用root用户）追加如下命令
   mount -t vboxsf java /mnt/share
   # 5、检查是否挂载成功
   ```

  ![share1](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch3/shiyan3/img/share1.png)

   ![share2](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch3/shiyan3/img/share2.png)

5. 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

   ```
   # 为逻辑卷/dev/vg1000/lvol0增加100M空间
   lvextend -L +100M /dev/vg1000/lvol0
   # 将逻辑卷的空间大小减少50M
   lvreduce -L -50M /dev/vg1000/lvol0     
   ```

6. 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

   ```
   #修改systemd-networkd.service配置文件的service块
   ExecStartPost = <path1> service1
   ExecStopPost = <path2> service2 
   ```

7. 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现***杀不死***？

   ```
   # 修改对应文件的[service]，在此以nginx.service为例
   vim /lib/systemd/system/nginx.service
   
   [Service]
   Restart=always
   RestartSec=1
   Type=forking
   PIDFile=/run/nginx.pid
   
   
   systemctl daemon-reload
   systemctl start nginx
   # 之后kill 掉nginx，nginx会自动重启
   ```

## 参考资料

1. [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

2. [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)

3. [VirtualBox 共享文件夹设置 及 开机自动挂载](https://blog.csdn.net/ysh198554/article/details/73335844)

4. [systemctl可以实现nginx进程挂了之后自动重新启动](https://www.cnblogs.com/oxspirt/p/11013865.html)

5. [LINUX lvreduce命令-收缩逻辑卷空间](http://www.bluestep.cc/linux-lvreduce命令-收缩逻辑卷空间/)

6. [LINUX lvextend命令-扩展逻辑卷空间](http://www.bluestep.cc/linux-lvextend命令-扩展逻辑卷空间/)
