# 第二章 实验 From GUI to CLI

## 软件环境

Ubuntu18.04 Server 64bit  
asciinema

## 实验任务

* [安装asciinema](#安装asciinema)
* [vimtutor操作录像](#vimtutor实验录像)
* [自查清单](#自查清单)

## 安装asciinema

```//安装
sudo apt-get install asciinema
//开始一个记录文件 test.cast
asciinema rec test.cast
//结束录制 ctrl+D or exit
//本地配置
asciinema auth
//上传
asciinema upload test.cast
```

## vimtutor实验录像

### Lesson 1 & Lesson 2

[lesson 1 & lesson 2](https://asciinema.org/a/4BtbEYWfLdH44hyzUSJWthRY1)

### Lesson 3 & Lesson 4

[lesson 3 & lesson 4](https://asciinema.org/a/pjMx82wcdiQKeTAwEBIX5ea3n)

### Lesson 5 & Lesson 6 & Lesson 7

[lesson 5 & lesson 6 & lesson 7](https://asciinema.org/a/1ZWam4vxAjuXOUvwBAML8ACOY)  
[补充：lesson 7.2](https://asciinema.org/a/plGCutui0g36tYe3eBPOtvVsL)

### 自查清单

* 你了解vim有哪几种工作模式？

    ```
    NORMAL  
    COMMAND  
    INSERT  
    VISUAL
    ```

* Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？  

    ```
    //一次向下移动10行
    10j
    //快速移动到文件开始
    :0
    gg
    //快速移动到文件结束
    G
    //快速跳转到文件第N行
    ：N
    Ngg
    ```

* Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

    ```
    //删除单个字符
    x
    //删除单个单词
    dw
    //从当前光标位置一直删除到行尾
    d$
    //删除单行
    dd
    //删除当前行开始向下数N行
    Ndd
    ```

* 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

    ```
    //在vim中快速插入N个空行
    N a <ENTER> <esc>

    //在vim中快速输入80个-
    80 a - <esc>
    ```

* 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

    ```
    //撤销最近一次编辑操作
    u

    //重做最近一次被撤销的操作
    <ctrl> r
    ```

* vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

    ```
    V  //选择整行
    v  //开始选择字符，按h/j/k/l选择单个字符或单词或多行
    d  //剪切
    y  //复制
    p  //在鼠标位置前粘贴
    P  //在鼠标位置后粘贴
    ```

* 为了编辑一段文本你能想到哪几种操作方式（按键序列）？

    ```
    x
    i
    a
    :wq
    :q!
    dw
    d$
    de
    dd
    ```

* 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

    ```
    //查看当前正在编辑的文件名
    :f
    <ctrl>+g

    //查看当前光标所在行的行号
    <ctrl>+g
    ```

* 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

    ```
    //查找errroor
    //默认向下查找
    /errroor <enter>  //normal模式.
    //进行和上一次查找相同的操作
    n
    //进行和上一次查找内容相同，方向相反的操作
    N
    //逆向查找，即向上查找，例如：逆向查找Lesson
    ？Lesson  //normal模式.

    //设置忽略大小写的匹配搜索
    :set ignorecase
    //恢复到大小写敏感
    :set noignorecase

    //高亮显示查找
    :set hls
    //禁用高亮查找
    :set nohlsearch
    :se nohls
    :se hls!

    //批量替换
    :#,#s/old/new/g  //#,# 代表的是替换操作的若干行中首尾两行的行号
    :%s/old/new/g   //替换整个文件中的每个匹配串
    :%s/old/new/gc  //会找到整个文件中的每个匹配串，并且对每个匹配串提示是否进行替换
    ```

* 在文件中最近编辑过的位置来回快速跳转的方法？

    ```
    //takes you back to older positions
    <ctrl>+o

    //to newer positions
    <ctrl>+i
    ```

* 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

    ```
    //1.把光标移到待匹配的括号上
    //2.按 %
    %
    ```

* 在不退出vim的情况下执行一个外部程序的方法？

    ```
    ! cmd <enter>
    ```

* 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

    ```
    //使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法
    <help>  //或者
    <F1>  //或者
    :help <enter>  //或者
    :help cmd <enter>  //或者

    //在两个不同的分屏窗口中移动光标
    ctrl+w  //在不同窗口之间跳转
    ```
