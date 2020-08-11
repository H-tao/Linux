<https://blog.csdn.net/qq_42556161/article/details/82908466> 

<https://www.runoob.com/linux/linux-comm-grep.html> 



### 创建内容

```bash
[root@kwephispra58237 ~]# cat -n /etc/rc.local > a.txt
[root@kwephispra58237 ~]# cat a.txt 
     1	#!/bin/bash
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     3	#
     4	# It is highly advisable to create own systemd services or udev rules
     5	# to run scripts during boot instead of using this file.
     6	#
     7	# In contrast to previous versions due to parallel execution during boot
     8	# this script will NOT be run after all other services.
     9	#
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    11	# that this script will be executed during boot.
    12	
    13	touch /var/lock/subsys/local
```

#### –color 匹配到的字符串显示颜色 

```bash
[root@kwephispra58237 ~]# grep --color 'bash' a.txt 
     1	#!/bin/bash
```

#### -i 忽略字符大小写 

```bash
[root@kwephispra58237 ~]# grep -i 'this' a.txt 
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     5	# to run scripts during boot instead of using this file.
     8	# this script will NOT be run after all other services.
    11	# that this script will be executed during boot.
```



#### -o 仅显示匹配的字串 

```bash
[root@kwephispra58237 ~]# grep -o 'this' a.txt 
this
this
this
```

#### -v 反向选取，即显示不匹配的行 
```bash
[root@kwephispra58237 ~]# grep -v 'this'  a.txt 
     1	#!/bin/bash
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     3	#
     4	# It is highly advisable to create own systemd services or udev rules
     6	#
     7	# In contrast to previous versions due to parallel execution during boot
     9	#
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    12	
    13	touch /var/lock/subsys/local
```
#### -n 显示行号 
```bash
[root@kwephispra58237 ~]# grep -n 'this' a.txt 
5:     5	# to run scripts during boot instead of using this file.
8:     8	# this script will NOT be run after all other services.
11:    11	# that this script will be executed during boot.

```
#### -E 使用扩展正则表达式 
```bash
# ^word 搜寻word开头的行
[root@kwephispra58237 ~]# grep -E '^touch' /etc/rc.local 
touch /var/lock/subsys/local


# bash$ 搜寻bash结尾的行
[root@kwephispra58237 ~]# grep -E 'boot$' /etc/rc.local 
# In contrast to previous versions due to parallel execution during boot


# . 匹配任意一个字符
[root@kwephispra58237 ~]# grep -E 'b.ot' a.txt 
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot
    11	# that this script will be executed during boot.


# \ 转义字符
[root@kwephispra58237 ~]# grep -E '\/bin\/bash' a.txt 
     1	#!/bin/bash


# * 前面的一个字符重复0到多次
[root@kwephispra58237 ~]# grep -E 'bo*t' a.txt 
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot
    11	# that this script will be executed during boot.


# [list] 匹配一系列字符中的一个
[root@kwephispra58237 ~]# grep -E '[abc]' a.txt 
     1	#!/bin/bash
     4	# It is highly advisable to create own systemd services or udev rules
     5	# to run scripts during boot instead of using this file.
     7	# In contrast to previous versions due to parallel execution during boot
     8	# this script will NOT be run after all other services.
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    11	# that this script will be executed during boot.
    13	touch /var/lock/subsys/local


# [n1-n9] 匹配一个字符范围中的一个字符
[root@kwephispra58237 ~]# grep -E '[0-9]' a.txt 
     1	#!/bin/bash
     2	# THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
     3	#
     4	# It is highly advisable to create own systemd services or udev rules
     5	# to run scripts during boot instead of using this file.
     6	#
     7	# In contrast to previous versions due to parallel execution during boot
     8	# this script will NOT be run after all other services.
     9	#
    10	# Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
    11	# that this script will be executed during boot.
    12	
    13	touch /var/lock/subsys/local


# [^list] 匹配字符集以外的字符

```



