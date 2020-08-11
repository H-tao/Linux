首先使用 --help 参数查看一下。basename命令参数很少，很容易掌握。

 

1. $ basename --help

 

用法示例：

>  $ basename /usr/bin/sort       输出"sort"。
>
>  $ basename ./include/stdio.h .h  输出"stdio"。
>
>  
>
>  为basename指定一个路径，basename命令会删掉所有的前缀包括最后一个slash（‘/’）字符，然后将字符串显示出来。

basename命令格式：

> basename [pathname][suffix]
>
> basename [string] [suffix]
>
>  
>
> suffix为后缀，如果suffix被指定了，basename会将pathname或string中的suffix去掉。

示例：

 

1. $ basename /tmp/test/file.txt
2. file.txt
3. $ basename /tmp/test/file.txt .txt
4. file
