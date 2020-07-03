# sed命令详解+示例
> sed（Stream EDitor）,流式编辑器
>
> 非交互式，基于模式匹配过滤及修改文本           //类比：Vim是一个交互的编辑器
>
> 逐行处理，并将结果输出到屏幕
>
> 可实现对文本的输出、删除、替换、复制、剪切、导入、导出等各种操作


1. 语法格式：

- 格式1：前置命令 | sed  [选项]   '[定址符]处理动作’

- 格式2：sed [选项]   '[定址符]处理动作’文件...

2. 常见命令选项: 

- -i：直接修改文件内容

- -n：屏蔽默认输出（全部文本）

- -r：启用扩展的正则表达式，若与其他选项一起使用，应作为首个选项

- -{}：可组合多个命令，以分号分隔

```bash
# 创建内容
[root@kwephisprb07363 shell_programs]# cat -n /etc/rc.local > a.txt
```


## 输出文本
```bash
# 输出所有行
[root@banana ~]# sed '1p' a.txt
     1	#!/bin/bash
     ...
    13	touch /var/lock/subsys/local

[root@banana ~]# sed -n 'p' a.txt 
     1	#!/bin/bash
     ...
    13	touch /var/lock/subsys/local

# 输出第1行
[root@banana ~]# sed -n '1p' a.txt 
     1	#!/bin/bash


# 输出第4行
[root@banana ~]# sed -n '4p' a.txt 
     4	# It is highly advisable to create own systemd services or udev rules


# 输出末行
[root@banana ~]# sed -n '$p' a.txt 
    13	touch /var/lock/subsys/local


# 输出[3,4]行
[root@banana ~]# sed -n '3,4p' a.txt 
     3	#
     4	# It is highly advisable to create own systemd services or udev rules


# 输出[11,末行]
[root@banana ~]# sed -n '11,$p' a.txt 
    11	# that this script will be executed during boot.
    12	
    13	touch /var/lock/subsys/local


# 输出[4, 4+2]行
[root@banana ~]# sed -n '4,+2p' a.txt 
     4	# It is highly advisable to create own systemd services or udev rules
     5	# to run scripts during boot instead of using this file.
     6	#


# 输出2,5,7三行
[root@banana ~]# sed -n '2p;5p;7p;' a.txt 
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot


# 输出2,5,7三行
[root@banana ~]# sed -n '{2p;5p;7p;}' a.txt 
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot


# 输出包含'a'的行
[root@banana ~]# sed -n '/a/p' a.txt 
     1	#!/bin/bash
     4	# It is highly advisable to create own systemd services or udev rules
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot
     8	# this script will NOT be run after all other services.
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    11	# that this script will be executed during boot.
    13	touch /var/lock/subsys/local


# 输出包含'A'的行
[root@banana ~]# sed -n '/A/p' a.txt 
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES


# 输出以touch开头的行
[root@banana ~]# sed -n '/^touch/p' a.txt 


# 输出以local结尾的行
[root@banana ~]# sed -n '/local$/p' a.txt 
    13	touch /var/lock/subsys/local


# 输出奇数行，n表示读入下一行文本（隔行）next
[root@banana ~]# sed -n 'p;n' a.txt 
     1	#!/bin/bash
     3	#
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot
     9	#
    11	# that this script will be executed during boot.
    13	touch /var/lock/subsys/local


# 输出偶数行，n表示读入下一行文本（隔行）
[root@banana ~]# sed -n 'n;p' a.txt 
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     4	# It is highly advisable to create own systemd services or udev rules
     6	#
     8	# this script will NOT be run after all other services.
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    12	


# 输出文件的行数，     wc -l返回行数及文件名
[root@banana ~]# sed -n '$=' a.txt 
13
```

## 删除文本，将p替换成d就成了删除文本
**不加入`-i`参数不会对原文本进行修改，需要修改源文本需要加入`-i`参数**
```bash
# 删除所有
[root@banana ~]# sed  'd' a.txt


# 删除文件的最后一行
[root@banana ~]# sed  '$d' a.txt


# 删除所有空行
[root@banana ~]# sed  '/^$/d' a.txt


# 删除第1行
[root@banana ~]# sed  '1d' a.txt


# 删除第2～5行
[root@banana ~]# sed  '2,5d' a.txt


# 删除第5、7、9行
[root@banana ~]# sed  '5d;7d;9d' a.txt


# 删除所有包含“init”或“bin”的行
[root@banana ~]# sed '/init/d;/bin/d' a.txt


# 删除包含数字[0-9]的行
[root@banana ~]# sed  '/[0-9]/d' a.txt


# 删除以"#"开头的行
[root@banana ~]# sed  '/^#/d' a.txt


# 删除以"s"开头的行
[root@banana ~]# sed  '/^s/d' a.txt


# -i对原文本进行修改，直接删除文本
[root@banana ~]# sed -i  '/^s/d' a.txt


# 删除以"install"开头的行
[root@banana ~]# sed  '/^install/d' a.txt


# 删除所有包含xml的行，只作输出，不更改原文件，若需要更改，应添加选项-i
[root@banana ~]# sed  '/xml/d' a.txt


# 删除不包含xml的行，!符号表示取反
[root@banana ~]# sed  '/xml/!d' a.txt


# sed -n '/xml/p' a.txt等效于sed  '/xml/!d' a.txt
[root@banana ~]# sed -n '/xml/p' a.txt

```


## 替换文本
```bash
# 将每行中第1个xml替换为XML
[root@banana ~]# sed 's/xml/XML/' a.txt


# 将每行中第3个xml替换为XML，只作输出，不更改原文件（若需要更改，应添加选项-i）
[root@banana ~]# sed 's/xml/XML/3' a.txt


# 将第2行中第3个xml替换为XML，只作输出，不更改原文件（若需要更改，应添加选项-i）
[root@banana ~]# sed '2s/xml/XML/3' a.txt


# 将所有的xml都替换为XML
[root@banana ~]# sed 's/xml/XML/g' a.txt


# 将所有的xml都删除（替换为空串）
[root@banana ~]# sed 's/xml//g' a.txt


# 将所有的doc都替换为docs，＆代表查找串
[root@banana ~]# sed 's/doc/＆s/g' a.txt


# 将第[4,7]行注释掉（行首加#号）
[root@banana ~]# sed '4,7s/^/#/' a.txt


# 解除文件第[3,5]行的注释 (去掉开头的 # )
[root@banana ~]# sed '3,5s/^#//' a.txt


# 解除以＃an开头的行的注释（去除行首的＃号）
[root@banana ~]# sed 's/^#an/an/' a.txt


# 删除所有的“xml”、所有的“XML”、所有的字母e，或者的关系用转义方式 \| 来表示
[root@banana ~]# sed 's/xml\|XML\|e//g' a.txt
```
