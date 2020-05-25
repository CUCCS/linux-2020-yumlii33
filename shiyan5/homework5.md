# 第五章 Web服务器 实验 

[TOC]



## 实验环境

* Windows10

* Ubuntu 18.04.4 Server 64bit（双网卡）

  ![image-20200524115950979](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524115950979.png)

* Nginx

* VeryNginx

* WordPress 4.7 

* Damn Vulnerable Web Application (DVWA)

## 实验内容

- 基本要求
- 安全加固要求
- VeryNginx配置要求

## 基本要求

### 安装配置Nginx

1. 安装Nginx

   `sudo apt-get install nginx`

2. 监听端口默认为80端口

3. 启动Nginx

   `sudo systemctl start nginx`

4. 通过192.168.56.102访问Nginx

   ![image-20200524120201427](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524120201427.png)

### 安装verynginx

1. 克隆 VeryNginx 仓库到本地：

   `git clone https://github.com/alexazhou/VeryNginx.git`

2. 然后进入仓库目录，执行以下命令：

   ```
   cd VeryNginx/
   
   sudo apt install gcc
   
   sudo apt install libssl-dev libssl-dev
   sudo apt install libpcre3 libpcre3-dev
   
   #执行python install.py install报错，根据错误提示执行下列命令：
   #ERROR:No gmake nor make found in PATH.
   sudo apt install make
   
   #error: the HTTP gzip module requires the zlib library.
   sudo apt-get install zlib1g
   sudo apt-get install zlib1g.dev
   
   #cannot create directory Permission denied
   sudo python install.py install
   ```

3. 修改配置文件nginx.conf：

   ```
   user www-data;
   listen 192.168.56.102:8080;
   ```

   

4. 执行启动服务代码

   ```
   #启动服务
   sudo /opt/verynginx/openresty/nginx/sbin/nginx
   
   #停止服务
   /opt/verynginx/openresty/nginx/sbin/nginx -s stop
   
   #重启服务
   /opt/verynginx/openresty/nginx/sbin/nginx -s reload
   ```

   

5. 通过192.168.56.102:8080访问verynginx

   ![image-20200524122339023](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524122339023.png)

   ![image-20200524122315898](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524122315898.png)

   ![image-20200524122443965](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524122443965.png)
   
6. 在windows的hosts里添加：

   `vn.sec.cuc.edu.cn    192.168.56.101`

   


### 配置wordpress站点环境

1. 安装mysql

   ```
   #安装
   sudo apt-get install mysql-server
   #执行
   sudo mysql_secure_installation
   #查看版本
   mysql -V
   
   #设置新密码
   sudo mysql
   
   use mysql;
   update mysql.user set authentication_string=PASSWORD('新密码'), plugin='mysql_native_password' where user='root';
   flush privileges;
   
   #重启mysql
   sudo service mysql restart
   ```

   

2. 安装php

   ```
   sudo apt-get install php
   
   sudo apt install php-fpm php-mysql
   ```

   

3. 配置Nginx

   ```
   sudo vim /etc/nginx/sites-enabled/default
   #修改server里的root为： root 你的网站根目录; 
   root 
   
   #在server里添加：
   location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
   }
   
   #重启Nginx
   sudo service nginx restart 
   ```

   

4. 安装WordPress

   1. 下载安装

      ```
      #下载安装包
      sudo wget https://wordpress.org/wordpress-4.7.zip
      
      #解压安装包
      unzip wordpress-4.7.zip
      
      #将解压后的wordpress移到指定路径
      sudo mkdir /var/www/html/wp.sec.cuc.edu.cn
      sudo cp -r wordpress /var/www/html/wp.sec.cuc.edu.cn
      ```

      

   2. mysql中新建一个数据库用于wordpress

      ```
      mysql -u root -p
      #新建一个数据库wordpress
      CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
      
      ```

      

   3. 安装PHP扩展

      ```
      
      sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
      
      #重启php-fpm
      sudo systemctl restart php7.2-fpm
      ```

      

   4. 在windows主机 hosts文件中添加`192.168.56.102 wp.sec.cuc.edu.cn`

   5. 通过`http://wp.sec.cuc.edu.cn`访问Nginx

### 配置EVWA站点环境

1. 下载安装EVWA

   ```sudo git clone https://github.com/ethicalhack3r/DVWA /tmp/DVWA
   sudo git clone https://github.com/ethicalhack3r/DVWA /tmp/DVWA
   sudo mv /tmp/DVWA /var/www/html
   
   #重命名DVWA中的/config/config.inc.php.dist为/config/config.inc.php
   sudo cp /var/www/html/DVWA/config/config.inc.php.dist /var/www/html/DVWA/config/config.inc.php
   ```

   

2. 在mysql为DVWA新建一个用户名, 修改DVWA中的配置,用于连接mysql数据库

   ```
   #新建数据库dvwa
   CREATE DATABASE dvwa DEFAULT CHARACTER SET utf8 COLLATE 
   utf8_unicode_ci;
   
   #新建mysql用户名和密码
   GRANT ALL ON dvwa.* TO 'dvwauser'@'localhost' IDENTIFIED BY '自己的密码';
   FLUSH PRIVILEGES;
   EXIT;
   
   #重启mysql
   sudo systemctl restart mysql
   ```

   

3. 修改EVWA配置文件

   ```
   sudo vim /var/www/html/DVWA/config/config.inc.php
    
   #修改内容
    $_DVWA[ 'db_server' ]   = '127.0.0.1';
    $_DVWA[ 'db_database' ] = 'dvwa';
    $_DVWA[ 'db_user' ]     = 'dvwauser';
    $_DVWA[ 'db_password' ] = '自己的密码';
   ```

4. 修改php的配置

   ```
   sudo vim /etc/php/7.2/fpm/php.ini
   
   #修改内容
   allow_url_include = on
   allow_url_fopen = on
   display_errors = off
   
   #重启php-fpm使配置生效
   sudo systemctl restart php7.2-fpm
   ```

5. 设置DVWA文件夹访问权限

   `sudo chown -R www-data.www-data /var/www/html/DVWA`

6. 配置nginx 5566端口监听DVWA的访问

   ```
   #打开nginx配置文件
   sudo vim /etc/nginx/sites-enabled/default
   
   #添加对应的监听模块
   server {
           listen 5566；
           root /var/www/html/DVWA;
           index index.html setup.php index.htm index.php index.nginx-debian.html;
            location / {
                   try_files $uri $uri/ =404;
             }
           #配置php-fpm反向代理
           location ~ \.php$ {
                   include snippets/fastcgi-php.conf;
                   fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
           }
       }
   
   #重启nginx使配置生效
   sudo systemctl restart nginx
   ```

7. 此时访问dvwa

   ![image-20200524143934683](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524143934683.png)

8. 在主机hosts文件中增加：`192.168.56.102    dvwa.sec.cuc.edu.cn`

9. 通过`http://dvwa.sec.cuc.edu.cn:5566`访问

   ![image-20200524144038633](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200524144038633.png)
   
   

## 安全加固要求

1. 使用IP地址方式均无法访问上述任意站点，并向访客展示自定义的**友好错误提示信息页面-1**

   * Add Matcher

     ![image-20200525070318474](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525070318474.png)

   * Add Response

     ![image-20200525070347740](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525070347740.png)

   * Add Filter

     ![image-20200525070452048](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525070452048.png)

   * 以ip无法正常访问：

     ![image-20200525070415936](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525070415936.png)

   注：如果修改后save失败，可能是权限问题修改权限:

   `sudo chmod -R 777 /opt/verynginx/verynginx/configs`

   

2. Damn Vulnerable Web Application (DVWA)只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的**友好错误提示信息页面-2**

   * Add Matcher

     ![image-20200525071531305](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525071531305.png)

   * Add Response

     ![image-20200525071508333](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525071508333.png)

   * Add Filter

     ![image-20200525072205162](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525072205162.png)

   * 不在白名单的客户端访问不成功

     ![image-20200525071424359](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525071424359.png)

3. 在不升级Wordpress版本的情况下，通过定制VeryNginx的访问控制策略规则，热修复WordPress < 4.7.1 - Username Enumeration

   * Add Matcher

     ![image-20200525071831308](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525071831308.png)

   * Add Response

     ![image-20200525072009998](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525072009998.png)

   * Add Filter

   * ![image-20200525072135121](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525072135121.png)

   * 访问

     ![image-20200525072421652](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525072421652.png)

     

4. 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护

   * Add Matcher

     ![image-20200525072911291](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525072911291.png)

   * Add Response

     ![image-20200525073013603](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525073013603.png)

   * Add Filter

     ![image-20200525073115583](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525073115583.png)

     

## VeryNginx配置要求

1. verynginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的**友好错误提示信息页面-3**

   * Add Matcher

     ![image-20200525073629992](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525073629992.png)

     ![image-20200525073643706](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525073643706.png)

   * Add Response

     ![image-20200525073834590](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525073834590.png)

   * Add Filter

     ![image-20200525074009629](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525074009629.png)

   * 

2. 通过定制VeryNginx的访问控制策略规则实现：

   限制DVWA站点的单IP访问速率为每秒请求数 < 50

   限制Wordpress站点的单IP访问速率为每秒请求数 < 20

   超过访问频率限制的请求直接返回自定义**错误提示信息页面-4**

   * Add Matcher

     ![image-20200525075952330](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525075952330.png)

     ![image-20200525080005780](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525080005780.png)

   * Add Response

     ![image-20200525074932203](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525074932203.png)

   * Add Frequency Limit

     ![image-20200525080153417](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525080153417.png)

     

3. 禁止curl访问

   * Add Matcher

     ![image-20200525080725375](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525080725375.png)

   * Add Fliter

     ![image-20200525080812421](https://github.com/CUCCS/linux-2020-yumlii33/blob/branch5/shiyan5/img/image-20200525080812421.png)

   

## 参考链接

1. [VeryNginx官方文档](https://github.com/alexazhou/VeryNginx)

2. [Ubuntu18.04下配置wordpress站点环境](https://www.jianshu.com/p/a51889a5f00e)

3. [CUCCS/linux-2019-jackcily](https://github.com/CUCCS/linux-2019-jackcily)

   