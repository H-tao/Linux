## Linux BASH_SOURCE

> `BASH_SOURCE[0]` 等价于 `BASH_SOURCE` ，取得当前执行的 shell 文件所在的路径及文件名

> `dirname`  去除文件名中的非目录部分，仅显示与目录有关的部分

1. 假如当前目录为/root/var，执行source ./test/bash_source.sh

```bash
# 当前路径 
[root@i var]# pwd
/root/var

# 新建文件夹和shell脚本
[root@i var]# mkdir test
[root@i var]# vim ./test/bash_source.sh 
```
2. 添加内容如下：

```bash
#!/bin/bash
# 取得当前执行脚本所在的路径及文件名
echo "${BASH_SOURCE[0]}"	# ./test/bash_source.sh

# 同上
echo "${BASH_SOURCE}" 		# ./test/bash_source.sh

# 父目录
echo "$( dirname "${BASH_SOURCE[0]}" )"		# ./test

# 使用pwd获取完整父目录的路径
DIR="$( cd "$( dirname ${BASH_SOURCE[0]} )" && pwd )"	# /root/var/test
echo $DIR
```
3. 执行脚本

```bash
[root@i var]# source ./test/bash_source.sh 
./test/bash_source.sh
./test/bash_source.sh
./test
/root/var/test
```
### 常用
```bash
# 使用pwd获取完整父目录的路径
DIR="$( cd "$( dirname ${BASH_SOURCE[0]} )" && pwd )"	# /root/var/test
echo $DIR
```
