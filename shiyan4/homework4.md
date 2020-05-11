# 第四章实验

[TOC]

## 实验环境

* Ubuntu18.04

* Windows x64 SSH

## 任务一

⽤bash编写⼀个图⽚批处理脚本，实现以下功能：

*  ☑⽀持命令⾏参数⽅式使⽤不同功能
* ☑⽀持对指定⽬录下所有⽀持格式的图⽚⽂件进⾏批处理
* ☑⽀持以下常⻅图⽚批处理功能的单独使⽤或组合使⽤
  	* ☑⽀持对jpeg格式图⽚进⾏图⽚质量压缩
  	* ☑⽀持对jpeg/png/svg格式图⽚在保持原始宽⾼⽐的前提下压缩分辨率
  	*  ☑⽀持对图⽚批量添加⾃定义⽂本⽔印
  	* ☑⽀持批量重命名（统⼀添加⽂件名前缀或后缀，不影响原始⽂ 件扩展名）
  	* ☑⽀持将png/svg图⽚统⼀转换为jpg格式图⽚ 

### 结果

![answer](https://github.com/yumlii33/linux-2020-yumlii33/blob/branch4/shiyan4/img/answer1.png)

[1](1)

### 代码

[代码1](a.sh)

## 任务二

⽤bash编写⼀个⽂本批处理脚本，对以下附件分别进⾏批量处理，完成相应的数据统计任务： 

- ☑统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的 球员数量 、百分比
- ☑统计不同场上位置的球员数量、百分⽐
- ☑名字最⻓的球员是谁？名字最短的球员是谁？
- ☑年龄最⼤的球员是谁？年龄最⼩的球员是谁？ 

### 结果

```
age:
1.22283%       9 <20
81.5217%     600 [20,30]
17.2554%     127 >30

position:
32.0652%     236 Defender
0.13587%       1 Défenseur
18.3424%     135 Forward
13.0435%      96 Goalie
36.413%     268 Midfielder

the longest name
 Liassine Cadamuro-Bentaeba

the shortest name
 Jô

the oldest is
 Fabrice Olinga

the youngest is
 Faryd Mondragon
```

### 代码

[代码2](b.sh)

## 任务三

⽤bash编写⼀个⽂本批处理脚本，对以下附件分别进⾏批量处理，完成相应的数据统计任务： 

- ☑统计访问来源主机TOP 100和分别对应出现的总次数
- ☑统计访问来源主机TOP 100 IP和分别对应出现的总次数
- ☑统计最频繁被访问的URL TOP 100
- ☑统计不同响应状态码的出现次数和对应百分⽐
- ☑分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
- ☑给定URL输出TOP 100访问来源主机

### 结果

[结果3](answer3.txt)

### 代码

[代码3](c.sh)

## 参考资料

* [虚拟机共享挂载问题](https://www.cnblogs.com/xuange306/p/11226292.html)
* [ubuntu安装和使用ImageMagik](https://blog.csdn.net/jacke121/article/details/76126245)
* [imageMagik命令行工具文档](https://imagemagick.org/script/command-line-processing.php)
* [shell中的文本处理（grep，sed，awk命令）](https://blog.csdn.net/su_use/article/details/80742686)
* [技术干货-Linux Shell精通教程](https://www.bilibili.com/video/BV117411e7TC?from=search&seid=8714070765139737202)
