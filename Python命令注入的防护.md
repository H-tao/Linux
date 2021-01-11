## 什么是命令注入？

略

## 目的

解决命令注入不求人。

## 解决方案

1.       白名单校验，校验以下表格中的有注入风险的字符

2.       校验输入的变量是否是预期的变量（如后面的IP例子）

3.       安全函数，使用subprocess.Popen或subprocess.run

### 方案一（白名单）

| **分类**   | **符号**                                                     | **功能描述**                                                 |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 管道       | \|                                                           | 连结上个指令的标准输出，作为下个指令的标准输入。             |
| 内联命令   | ;                                                            | 连续指令符号。                                               |
| &          | 单一个& 符号，且放在完整指令列的最后端，即表示将该指令列放入后台中工作。 |                                                              |
| 逻辑操作符 | $                                                            | 变量替换(Variable Substitution)的代表符号。                  |
| 表达式     | $                                                            | 可用在${}中作为变量的正规表达式。                            |
| 重定向操作 | >                                                            | 将命令输出写入到目标文件中。                                 |
| <          | 将目标文件的内容发送到命令当中。                             |                                                              |
| 反引号     | ‘                                                            | 可在``之间构造命令内容并返回当前执行命令的结果。             |
| 倒斜线     | \                                                            | 在交互模式下的escape 字元，有几个作用；放在指令前，有取消 aliases的作用；放在特殊符号前，则该特殊符号的作用消失；放在指令的最末端，表示指令连接下一行。 |
| 感叹号     | !                                                            | 事件提示符(Event Designators),可以引用历史命令。             |
| 换行符     | \n                                                           | 可以用在一行命令的结束，用于分隔不同的命令行。               |

### 方案二（校验输入）

防范命令入注我们一般都会建议过滤\n$&;|'"()`等shell元字符，但自己实现一个个字符处理还是比较麻烦的，我们尽量寻求一种简单的方法最好是现成的函数或者库进行处理。 

```python
import shlex


filename_para = 'somefile'
command = 'ls -l {}'.format(filename_para)
print("except result command:")
print("{}\n".format(command))

filename_para= 'somefile; cat /etc/passwd'
command = 'ls -l {}'.format(filename_para)
print("be injected result command:")
print("{}\n".format(command))

filename_para = 'somefile; cat /etc/passwd'
command = 'ls -l {}'.format(shlex.quote(filename_para))
print("be injected but escape result command:")
print("{}\n".format(command))
```

### 方案三（调用安全函数subprocess）

#### 用途

此模块用来替换一些老的模块和函数，如：os.system、os.spawn*、os.popen*、popen2.*、commands.*

#### 使用

Subprocess中比较旧的API（有命令注入风险）：

subprocess.call()

subprocess. check_call ()

subprocess. check_output ()

subprocess. getoutput ()

subprocess. getstatusoutput ()

**推荐的API：**

subprocess.run()

subprocess. Popen()

以上两个API推荐使用，其中首选run函数。

#### Subprocess.run参数讲解

原型：

```python
subprocess.run(args, *, stdin=None, input=None, stdout=None, stderr=None, capture_output=False, shell=False, cwd=None, timeout=None, check=False, encoding=None, errors=None, text=None, env=None, universal_newlines=None, **other_popen_kwargs)
```

capture_output:

True：标准输出及标准错误默认为管道

False：标准输出及标准错误以用户输入为主

#### subprocess.run正确场景使用：

**场景1:**

```python
"""
场景1：常规调用:
    cmd = "cat %s" % (input_str)
"""

try:
    res = subprocess.run(shlex.split(cmd), shell=False, capture_output=True)
except Exception as e:
    print(res.returncode)  # 错误码
    print(res.stdout)  # 返回值
    print(res.stderr)  # 返回的错误信息
```

**场景****2****：**

```python
""" 场景2：带管道符
    cat /etc/passwd |grep 0:0 
"""

def fun_run2():
    ins1 = subprocess.run(args = ["cat", "/etc/passwd"], shell = False, capture_output = True)
    ins2 = subprocess.run(args = ["grep", "0:0"], input = ins1.stdout, shell = False, capture_output = True)
    print(ins2.returncode)
    print(ins2.stdout)
```

**场景****3****：**

```python
"""
    场景3：cat /etc/passwd 2>/dev/null
"""

def fun_run3():
    ins1 = subprocess.run(args = ["cat", "/etc/passwd"], shell = False, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
    print(ins2.returncode)
    print(ins2.stdout)
```

**场景****4****：**

```python
"""
    场景4：echo sssss22222 > test_write_something.txt 
"""

def fun_run4():
    # 正确示例 权限根据业务自行匹配
    flags = os.O_WRONLY | os.O_CREAT 
    modes = stat.S_IWUSR | stat.S_IRUSR
    with os.fdopen(os.open('test_write_something.txt', flags, modes), 'w') as fd:
        process = subprocess.run(["echo", "sssss222221"], shell=False, stdout=fd)
```

场景5：

```python
"""
    场景5：echo sssss22222 >> test_write_something.txt
"""

def fun_run4():
    # 正确示例 权限根据业务自行匹配
    flags = os.O_WRONLY | os.O_CREAT
    modes = stat.S_IWUSR | stat.S_IRUSR
    with os.fdopen(os.open('test_write_something.txt', flags, modes), 'a') as fd:
        process = subprocess.run(["echo", "sssss222221"], shell=False, stdout=fd)
```



以上代码成为无风险代码的前提是：

第1个参数列表的第一个元素不允许是bash、cmd、cmd.exe、/bin/sh、/usr/bin/expect，只有满足此前提条件，参数显示设置shell=False（默认False）参数才是有效防止命令注入的。

Popen亦可以防止命令注入问题，但是使用较为繁琐，推荐使用run

#### Subprocess.Popen可能引入的问题

如下代码：

```
process = Popen(args=emperor_arguments, stdout=PIPE, stderr=PIPE)
```

```
process.wait()
```

以上代码，它的stdout, stderr已被重定向到管道里面了。Linux里的管道都会有一定的容量，当道管满了写执行write操作就会block，直到可以写为止。在上面的代码里，父进程创建子进程后，没有对它们通信的管道进行read操，而是调用 wait 等待子进程结束。此时就会死锁。

解决方案：

1.     直接使用run

2.     使用如下方式

```
process = Popen(args=emperor_arguments, stdout=PIPE, stderr=PIPE)    
stdoutdata, stderrdata = process.communicate()
```

使用communicate，将输出放在内存中，这时候上限就和内存大小有关，内存耗尽会抛异常。

### 思考

双引号可以防止命令注入吗？ 不能！！！

```shell
$ echo "hello" >> "a.txt';touch b.txt'"
-rw-------  1 root root        6 Jan 11 16:58 a.txt';touch b.txt'
```

比如：

```
$ python
>>> cmd = "cat '%s'" % ("a.txt';touch b.txt'")
>>> import subprocess
>>> subprocess.getstatusoutput(cmd)

$ ls
b.txt
```

查看结果：可见b.txt已经被创建，命令注入成功 
