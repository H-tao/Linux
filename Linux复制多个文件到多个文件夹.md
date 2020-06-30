## 单个文件复制到多个文件夹下

> echo dir1 dir2 dir3  |xargs -n 1 cp -v file

- -n 1 告诉 xargs 命令每个命令行最多使用一个参数，并发送到 cp 命令中。
-  cp 用于复制文件。 
- -v 启用详细模式来显示更多复制细节。 

```bash
# 我希望将某一个文件复制到下面三个文件夹下
[root@i build]$ echo ~/fruit/*/build/
/home/root/fruit/apple/build/ 
/home/root/fruit/banana/build/ 
/home/root/fruit/orange/build/


# echo ~/fruit/*/build/ | xargs -n 1 cp -v 文件
# 将delete_remote_tags.sh复制到~/fruit/*/build/
[root@i build]$ echo ~/fruit/*/build/ | xargs -n 1 cp -v delete_remote_tags.sh 
‘delete_remote_tags.sh’ -> ‘/home/root/fruit/apple/build/delete_remote_tags.sh’
‘delete_remote_tags.sh’ -> ‘/home/root/fruit/banana/build/delete_remote_tags.sh’
‘delete_remote_tags.sh’ -> ‘/home/root/fruit/orange/build/delete_remote_tags.sh’
```

## 多个文件复制到单个文件夹下

> ls <file> | xargs -n 1 -I {} cp {} dir

- -I {} 获取到xargs 命令前面命令的返回参数，之后的{}用返回参数替代

  ls 返回   x1.txt	x2.txt	x3.sh

  xargs构成 cp -v x1.txt ~/test/   	cp -v x2.txt ~/test/	cp -v x3.sh ~/test/

```bash
# 我希望将某一个文件夹下的*.txt和*.sh 复制到test文件夹下
[root@i ~]$ mkdir test
[root@i ~]$ ls test

# 复制~/shellprograms/*.txt和~/shellprograms/*.sh到~/test/文件夹下
[root@i ~]$ ls ~/shellprograms/*.txt ~/shellprograms/*.sh | xargs -n1 -I {} cp -v {} ~/test/
[root@i ~]$ ls test
a.txt  b.txt  delete_tags.sh  export.sh  makebuild.sh  sh1.sh  sh2.sh
```

## 多个文件复制到多个文件夹下

```bash
# 我希望将某一个文件夹下的*.txt和*.sh 复制到所有test*文件夹下
[root@i ~]$ vim mvto.sh
#!/bin/bash

## 将多个文件复制到多个文件夹下
for dir in `echo test*`; do
	#echo $dir
	# 复制~/shellprograms/*.txt和~/shellprograms/*.sh到~/test/文件夹下
	ls shellprograms/*.sh shellprograms/*.txt |xargs -n 1 -I {} cp -v {} ${dir}
done

[root@i ~]$ source mvto.sh
```

