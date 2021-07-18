

### 启动docker

```
systemctl start docker
```

### 查看docker服务状态

```bash
systemctl status docker
or
systemctl status docker.service

[root@CentOS7 ~]# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
   Active: `active (running)` since Sat 2020-07-18 19:19:18 CST; 1min 25s ago
     Docs: https://docs.docker.com
 Main PID: 5245 (dockerd)
   Memory: 125.1M
   CGroup: /system.slice/docker.service
           └─5245 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

### 查看Docker版本

```bash
[root@CentOS7 ~]# docker --version
Docker version 19.03.12, build 48a66213fe

# 可以查看 Docker Client 和 Server 的版本信息
[root@CentOS7 ~]# docker version
Client: Docker Engine - Community
 Version:           19.03.12
 API version:       1.40
 Go version:        go1.13.10
 Git commit:        48a66213fe
 Built:             Mon Jun 22 15:46:54 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.12
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.10
  Git commit:       48a66213fe
  Built:            Mon Jun 22 15:45:28 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.13
  GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
  
[root@CentOS7 ~]# docker info
Client:
 Debug Mode: false

Server:
 Containers: 6
  Running: 0
  Paused: 0
  Stopped: 6
 Images: 6
 Server Version: 19.03.12
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc version: dc9208a3303feef5b3839f4323d9beb36df0a9dd
 init version: fec3683
 Security Options:
  seccomp
   Profile: default
 Kernel Version: 3.10.0-514.26.2.el7.x86_64
 Operating System: CentOS Linux 7 (Core)
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 1.796GiB
 Name: CentOS7
 ID: SDIH:LINX:2TXQ:KMOC:MZEL:ERZV:NY54:OVO2:DTBJ:44KH:SWRV:C6W3
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Registry Mirrors:
  https://a0seo03l.mirror.aliyuncs.com/
 Live Restore Enabled: false
```

# 第 1 章 安装 Docker

https://blog.csdn.net/Spade_/article/details/107139575

# 第 2 章 容器核心知识概述

## 2.1 什么是容器？

Docker 容器是一种轻量级、可移植、自包含的软件打包技术，使应用程序可以在几乎任何地方以相同的方式运行。Docker 将集装箱思想运用到软件打包上，为代码提供了一个基于容器的标准化运输系统。开发人员在自己笔记本上创建并测试好的容器，无须任何修改就能够在生产系统的虚拟机、物理服务器或公有云主机上运行。

容器由两部分组成：（1）应用程序本身；（2）依赖：比如应用程序需要的库或其他软件容器在 Host 操作系统（产系统的虚拟机、物理服务器或公有云主机）的**用户空间**中运行，**与操作系统的其他进程隔离**。

## 2.2 容器的优势

- 轻量级，快速启动和迁移
- 可以打包任何软件及其依赖
- 容器无须修改便可运行在几乎所有的平台上
- 资源、网络、库都是隔离的，不会出现依赖问题
- 提供 run、start、stop 等标准化操作，非常适合自动化

1. 对于开发人员：Build Once、Run Anywhere

   容器意味着环境隔离和可重复性。开发人员只需为应用创建一次运行环境，然后打包成容器便可以在其他机器上运行。另外，容器环境与所在的 Host 环境是隔离的，就像虚拟机一样，但更快更简单。

2. 对于运维人员：Configure Once、Run Anything

   只需要配置好标准的 runtime 环境，服务器就可以运行任何容器。这使得运维人员的工作变得更高效、一致和可重复。容器消除了开发、测试、生存环境的不一致性。

## 2.3 容器的工作原理

### 2.3.1 Docker 的架构和核心组件

- Docker 客户端：Client
- Docker 服务器：Docker daemon
- Docker 镜像：Image
- Docker 镜像仓：Registry 
- Docker 容器：Container

Docker 采用的是 Client/Server 架构。客户端向服务器发送请求，服务器负责构建、运行和分发容器。客户端和服务器可以运行在同一个 Host 上，客户端也可以通过 socket 或 REST API 与远程的服务器通信。Docker 架构如下图：

![image-20200718191129449](C:\Users\haita\AppData\Roaming\Typora\typora-user-images\image-20200718191129449.png)

### 2.3.2 Docker 客户端

Host 上输入docker 可以方便查看 docker 的命令。

```bash
[root@CentOS7 ~]# docker

Usage:	docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/root/.docker")
...

Management Commands:
  builder     Manage builds
...

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
...

Run 'docker COMMAND --help' for more information on a command.
```

### 2.3.3 Docker 服务器

Docker daemon 是服务器组件，以 Linux 后台服务的方式运行，负责创建、运行、监控容器，构建、存储镜像。说白了，就是一个后台服务进程。

```bash
systemctl status docker
or
systemctl status docker.service

[root@CentOS7 ~]# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
   Active: `active (running)` since Sat 2020-07-18 19:19:18 CST; 1min 25s ago
     Docs: https://docs.docker.com
 Main PID: 5245 (dockerd)
   Memory: 125.1M
   CGroup: /system.slice/docker.service
           └─5245 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

### 2.3.4 Docker 服务器允许远程访问

Docker daemon 默认只能 响应本地 Host 的客户端请求。如果要允许远程客户端请求，需要在配置文件中打开 TCP 监听，步骤如下：

（1）修改配置文件：

​	**Ubuntu：**vim /etc/systemd/system/multi-user.target.wants/docker.service

​	**CentOS：**vim /lib/systemd/system/docker.service

​	在环境变量 `ExecStart` 后面添加 `-H tcp://0.0.0.0[:port]`，允许来自任意 IP 客户端连接。

```bash
[Service]
# ExecStart=/usr/bin/dockerd -H fd:// --		
# 修改为：
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0
# 指定端口：
# ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2222
```

（2）重启 Docker daemon

```bash
systemctl daemon-reload
systemctl restart docker.service
# ss -lt | grep 2222	# 查看监听端口
```

（3）客户端远程连接服务器

```bash
# 服务器IP为 192.168.2.144，info 用于查看 Docker 服务器的信息
docker -H 192.168.2.144 info
```

### 2.3.5 Docker 镜像

Docker 镜像看成只读模版，通过它可以创建 Docker 容器。

例如某个镜像可能包含一个 Ubuntu 操作系统、一个 Apache HTTP Server 以及用户开发的 Web 应用。

### 2.3.6 Docker 容器

Docker 容器就是 Docker 镜像的运行实例。

用户可以通过 CLI （Docker）或是 API 启动、停止、移动或删除容器。可以这么认为，对于应用软件，镜像是软件生命周期的构建和打包阶段，而容器则是启动和运行阶段。

### 2.3.7 Registry

Registry 是存放 Docker 镜像的仓库，Registry 分私有和公有两种。

Docker Hub （https://hub.docker.com/）是默认的Registry，由 Docker 公司维护，上面有数以万计的镜像，用户可以自由下载和使用。

出于对速度或安全的考虑，用户也可以创建自己的私有 Registry。后面我们会学习如何搭建私有 Registry。

docker pull 命令可以从 Registry 下载镜像。

docker run 命令则是先下载镜像（如果本地没有），然后再启动容器。

### 2.3.8 一个完整的例子

```bash
# 后台运行一个 httpd 容器。-d 指定后台运行 -p 指定端口映射
[root@CentOS7 ~]# docker run -d -p 8888:8888 httpd
Unable to find image 'httpd:latest' locally			# 本地未发现 httpd 镜像
latest: Pulling from library/httpd					# 从 library/httpd 拉取 最新的 httpd 镜像
8559a31e96f4: Already exists
bd517d441028: Pull complete 		# 拉取
f67007e59c3c: Pull complete 
83c578481926: Pull complete 
f3cbcb88690d: Pull complete 
Digest: sha256:387f896f9b6867c7fa543f7d1a686b0ebe777ed13f6f11efc8b94bec743a1e51
Status: Downloaded newer image for httpd:latest		# 下载完成，镜像 httpd 被保存到本地，latest 代表最新版
9ccf7d1be502e06bef0cf0cba65dab00abf6ff35c1fc57d27bd47180c4404678	# ID：镜像的 "长ID"，前12个字符代表镜像的 "短ID"

# 查看下载的所有镜像
[root@CentOS7 ~]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
httpd               latest              ccbcea8a6757        5 weeks ago         166MB

# 查看运行中的容器
[root@CentOS7 ~]# docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                            NAMES
9ccf7d1be502        httpd               "httpd-foreground"   5 minutes ago       Up 5 minutes        80/tcp, 0.0.0.0:8888->8888/tcp   happy_fermi
```

# 第 3 章 Docker 镜像

## 3.1 镜像的内部结构

### 3.1.1 hello-world

1. 拉取最小镜像——hello-world

   ```bash
   # 拉取 hello-world镜像
   docker pull hello-world
   
   # 查看
   docker images hello-world
   
   # 运行
   docker run hello-world
   ```

2. hello-world 的 Dockerfile

   ```bash
   FROM scratch
   COPY hello /
   CMD ["/hello"]
   ```

### 3.1.2 bash 镜像

- 不依赖其他镜像，从 scratch 构建
- 其他镜像可以以之为基础进行扩展
- 通常是各种 Linux 发行版的 Docker 镜像，如Ubuntu、Debian、CentOS等

```bash
# 下载一个 bash 镜像
docker pull centos

# 查看镜像描述：REPOSITORY TAG ID CREATED SIZE
docker images centos
```

1. rootfs

   包含 /dev、/proc、/bin 等目录。内核空间是 kernel ( bootfs文件系统，Linux 刚启动时会加载 bootfs 文件系统，之后bootfs 会被卸载掉 )。

   base 镜像底层使用 Docker Host 的 kernel (bootfs)，本身提供 rootfs。

2. base 镜像提供最小安装的 Linux 发行版本

   CentOS 镜像的 Dockerfile：

   ```bash
   FROM scratch
   ADD centos-7-docker.tar.xz /
   CMD ["/bin/bash"]
   ```

   ADD ： 添加 CentOS 7 rootfs 的 tar 包。制作镜像时，tar 会自动解压到 / 目录下，生成 /dev、/proc、/bin 。

3. 支持运行多种 Linux OS 

   - Ubuntu 14.04： 使用 upstart 管理服务，apt 管理软件包

   - CentOS 7：使用 systemd 和 yum

   - Debian、BusyBox ( 一种嵌入式 Linux ) 

### 3.1.3 镜像分层

1. Docker 支持通过扩展现有镜像，创建新的镜像：

   新镜像是从 base 镜像一层层叠加生成的。每安装一个软件，就在现有镜像的基础上增加一层。

2. 共享资源：

   镜像的每一层都可以被共享，源于 Copy-on-Write 特性。

3. Copy-on-Write 特性：

		所有对容器的改动，无论添加、删除，还是修改文件都只会发生在容器层中。只有容器层是可写的，容器层下面的所有镜像层都是只读的。

## 3.2 如何构建镜像?

### 3.2.1 docker commit

```bash
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

OPTIONS说明：

- **-a :**提交的镜像作者；
- **-c :**使用Dockerfile指令来创建镜像；
- **-m :**提交时的说明文字；
- **-p :**在commit时，将容器暂停。

**实例1：**进入容器，修改，并保存为新镜像

```bash
# 1. 运行，并进入容器
docker run -it ubuntu

# 2. 修改容器，比如安装 vi
apt-get install -y vim

# 3. 打开新的 host 端口，查看运行中的<容器名>
docker ps

# 4. 保存为新镜像
docker commit <容器名> <新的容器名>

# 5. 进入新镜像，查看vi
docker run -it <新的容器名>
which vi
```

**实例2：** 将容器直接保存为新镜像

```bash
# 将容器 a404c6c174a2 保存为新的镜像，并添加提交人信息 "Spade_" 和说明信息 "my apache"，版本仓为 mymysql:v1
root@CentOS:~$ docker commit -a "Spade_" -m "my apache" a404c6c174a2  mymysql:v1 
sha256:37af1236adef1544e8886be23010b66577647a40bc02c0885a6600b33ee28057

# 查看 mymysql:v1
root@CentOS:~$ docker images mymysql:v1
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mymysql             v1                  37af1236adef        15 seconds ago      329 MB
```

### 3.2.2 Dockerfile

1. 创建自己的 Dockerfile

   ```bash
   vim Dockerfile
   # 添加如下内容：
   FROM ubuntu
   RUN apt-get update && apt-get install -y vim
   ```

2.  docker build

   ```bash
   # 构建镜像，命名为 "ubuntu-with-vi-dockerfile"，"." 当前目录
   docker build -t ubuntu-with-vi-dockerfile .
   ```

3. 执行步骤

   1) 执行FROM，选择基础镜像

   2) 执行RUN，安装软件 -> 启动临时容器 -> 将容器保存为镜像 ( 实际上是 docker commit ，会生成一个镜像ID ) -> 创建容器ID -> 删除临时容器 -> 构建成功

### 3.2.3 镜像的特性

1. 分层结构

   ```bash
   # 查看 ubuntu 镜像的分层
   docker history ubuntu
   
   # 查看 ubuntu-with-vi-dockerfile 镜像的分层
   docker history ubuntu-with-vi-dockerfile
   ```

   注意：missing 表示无法获取 IMAGE ID，通常从 Docker Hub 下载的镜像会有这个问题。

2. 缓存特性

   - Docker 会缓存已有镜像的镜像层，构建新镜像时，如果某镜像层已经存在，就直接使用，无需重新创建。

   - `docker build --no-cache` 可以取消构建镜像时使用缓存的机制。

   - Dockerfile 中每一个指令都会创建一个镜像层，上层是依赖于下层的。无论什么时候，只要某一层发生变化，其上面所有层的缓存都会失败。


### 3.2.4 调试 Dockerfile

总结一下通过 Dockerfile 构建镜像的过程：

   (1) 从 base 镜像运行一个容器。

   (2) 执行一条指令，对容器做修改。

   (3) 执行类似 docker commit 的操作，生成一个新的镜像层。

   (4) Docker 再给予刚刚提交的镜像运行一个新的容器。

   (5) 重复 2-4 步，直到 Dockerfile 中的所有指令执行完毕。

如果 Dockerfile 由于某种原因执行到某个指令失败了，我们也将能够得到前一个指令成功构建出的镜像，这对调试 Dockerfile 非常有帮助。

**调试例子：**

```bash
# 编写 Dockerfile
vim Dockerfile
# 添加如下内容：
FROM busybox
RUN touch tmpfile
RUN /bin/bash -c echo "continue to build..."
COPY testfile /

# debug 显示调试过程
docker build -t image-debug
`第二步 touch tmpfile 执行成功之后，会返回一个镜像 ID`

# 调试
docker run -it <镜像 ID>
RUN /bin/bash -c echo "continue to build..."
`发现busybox 镜像中没有 bash `
```

### 3.4.5 Dockerfile 常用指令

- FROM：指定 bash 镜像。

- MAINTARNER：设置镜像的作者，任意字符串。

- COPY：将文件从 build context 复制到镜像。`COPY src dest` 或 `COPY ["src", "dest"]`，src 只能指定 build context 中的文件或目录。

- ADD：与COPY类似，从 build context 复制文件到镜像。不同的是，如果 src 是归档文件 (tar、zip、tgz、xz 等)，文件会被自动解压到 dest。

- ENV：设置环境变量，环境变量可被后面的指令使用。例如：

  > ENV MY_VERSION 1.3 RUN apt-get install -y mypackage=$MY_VERSION

- EXPOSE：指定容器中的进程会监听某个端口，Docker 可以将该端口暴露出来。

- VOLUME：将文件或目录声明为 volume。

- WORKDIR：为后面的 RUN、CMD、ENTERPOINT、ADD 或 COPY 指令设置镜像中的当前工作目录。

- RUN：在容器中运行指定的命令。

- CMD：容器启动时运行指定的命令。多个CMD只有最后一个生效。**CMD 可以被 docker run 之后的参数替换。**

- ENTERPOINT：设置容器启动时运行的命令。多个ENTERPOINT只有最后一个生效。**CMD 或 docker run 之后的参数会被当做参数传递给 ENTERPOINT**。

### 3.4.6 Dockerfile 示例

  1) 编写 Dockerfile ( `vim Dockerfile` )

  ```bash
  FROM busybox	# 执行 bash 镜像为 busybox (一种嵌入式Linux系统)
  MAINTAINER spade_	# 镜像的作者
  WORKDIR /testdir	# 工作目录，不存在则 Docker 会自动创建
  RUN touch tmpfile1	# 运行命令
  COPY ["tmpfile2", "."]		# 复制 tmpfile2 到"." 当前目录
  ADD ["bunch.tar.gz", "."] 	# 解压 bunch.tar.gz 到 "." 当前目录
  ENV WELCOME "You are in my container, welcome! "	# 设置一个字符串环境变量 WELCOME 
  ```

  2) 构建镜像

  ```bash
  root@ubuntu:~# ls
  Dockerfile bunch.tar.gz tmpfile2
  
  # my-image 是镜像名
  root@ubuntu:~# docker build -t my-image .
  ...
  ```

  3) 运行容器，验证镜像内容

  ```bash
  root@ubuntu:~# docker run -it my-image
  /testdir #
  /testdir # ls 				
  bunch tmpfile1 tmpfile2
  /testdir # echo $WELCOME		# 输出 Dockerfile 设置的环境变量
  You are in my container, welcome! 
  ```

## 3.3 RUN vs CMD vs ENTERPOINT

(1) RUN：执行命令并创建镜像层，RUN 经常用于安装软件包。

(2) CMD：设置容器启动后默认执行的命令及其参数，但 CMD 能够被 docker run 后面跟的命令行参数替换。

(3) ENTRYPOINT：配置容器启动时运行的命令。

### 3.3.1 Shell 和 Exec格式

#### Shell 格式

```bash
<instruction> <command>
```

例如：

```bash
RUN apt-get install python3
CMD echo "Hello World"
ENTRYPOINT echo "Hello World"
```

**当指令执行时，shell 格式底层会调用 `/bin/sh -c [command]`。**例如下面的 Dockerfile 片段：

```bash
ENV name Spade_		# ENV 指令用于设置环境变量，环境变量可以被后面的指令调用
ENTRYPOINT echo "Hello, $name"	# 调用环境变量 name
```

执行 docker run [image] 将输出：

```bash
Hello, Spade_	# 环境变量 name 已经被值 Spade_ 替换
```

#### Exec 格式

```bash
<instruction> ["executable", "param1", "param2", ...]
```

例如：

```bash
RUN ["apt-get", "install", "python3"]
CMD ["/bin/echo", "Hello World"]
ENTRYPOINT ["/bin/echo", "Hello World"]
```

**当指令执行时，会直接调用 [command]，不会被 shell 解析。**

例如下面的 Dockerfile 片段：

```bash
ENV name Spade_ 
ENTRYPOINT ["/bin/echo", "Hello, $name"]
```

运行容器将输出:

```bash
Hello, $name
```

注意：**环境变量 name 没有被替换。**

如果希望使用环境变量，做如下修改 Dockerfile：

```bash
ENV name Spade_
ENTRYPOINT ["/bin/echo", "-c", "echo Hello, $name"]
```

运行容器将输出:

```bash
Hello, Spade_
```

#### 二者区别

Shell 格式：**当指令执行时，shell 格式底层会调用 `/bin/sh -c [command]`。**

Exec 格式：**当指令执行时，会直接调用 [command]，不会被 shell 解析。**若需要使用环境变量，需要添加 `-c` 参数。

CMD 和 ENTRYPOINT 推荐使用 Exec 格式，因为指令可读性更强，更容易理解。RUN 则两种格式都可以。

### 3.3.2 RUN

RUN 常用于安装应用和软件包。

RUN 在当前镜像的顶部执行命令，并创建新的镜像层。Dockerfile 中常常包含多个 RUN 指令。

RUN 有两种格式：

(1) Shell 格式：RUN

(2) Exec 格式：RUN  ["executable", "param1", "param2"]

使用 RUN 安装多个**最新版**包的例子：

```bash
RUN apt-get update && apt-get install -y \bzr\cvs\git\mercurial\subversion
```

### 3.3.3 CMD

CMD 指令允许用户指定容器默认执行的命令。

此命令会在容器启动且 docker run 没有指定其他命令时运行。

- 如果 docker run 指定了其他命令，CMD 指定的默认命令将被忽略。
- 如果 Dockerfile 中有多个 CMD 指令，只有最后一个 CMD 有效。

CMD 有三种格式：

(1) Exec 格式：CMD  ["executable", "param1", "param2"]。 **推荐使用。**

(2) Shell 格式：CMD command param1 param2

(3) CMD ["param1", "param2"] 为 ENTRYPOINT 提供额外的参数，此时 ENTRYPOINT 必须使用 Exec 格式。

CMD Dockerfile 片段：

```bash
CMD echo "Hello World"
```

运行容器 docker run -it [image] 将输出：

```bash
Hello World
```

运行容器 docker run -it [image]  /bin/bash, CMD 会被忽略掉，命令 bash 将被很执行：

```bash
root@10ds037c8458:/#
```

### 3.3.4 ENTRYPOINT

ENTRYPOINT 指令可以让容器以应用程序或者服务的形式运行。

ENTRYPOINT 看上去与 CMD 很像，它们都可以指定要执行的命令及其参数。不同的地方在于 ENTRYPOINT 不会被忽略，一定会被执行，即使运行 docker run 时执行了其他命令。

- **多个 ENTRYPOINT 只有一个生效。**

ENTRYPOINT 有两种格式：

(1) Exec 格式：ENTRYPOINT ["executable", "param1", "param2"] 。这是 ENTRYPOINT 的**推荐格式**。ENTRYPOINT 中的参数始终会被使用，而 CMD 的额外参数可以在容器启动时动态替换掉。

(2) Shell 格式：ENTRYPOINT command param1 param2。会忽略任何 CMD 或者 docker run 提供的参数。

ENTRYPOINT Dockerfile 片段：

```bash
ENTRYPOINT ["/bin/echo", "Hello"] CMD ["World"]
```

docker run -it [image]

```bash
Hello World
```

docker run -it [image] Spade_

```bash
Hello Spade_
```

## 3.4 如何分发镜像?

1. 用相同的 Dockerfile 在其他 host 构建镜像。

2. 将镜像上传到公共 Registry

   (1) 需要 Internet 连接，而且下载和上传速度慢。

   (2) 上传到 Docker Hub 的镜像任何人都能够访问，虽然可以用私有 repository，但不是免费的。

   (3) 因安全原因很多组织不允许将镜像放到外网。

3. 搭建私有的 Registry

### 3.4.1 镜像名

   ```bash
# 镜像名
[image name] = [repository]:[tag]
   
# 构建一个镜像
   docker build -t <镜像名>
   
# 查看镜像信息
docker images <镜像名>
   
# docker build 默认tag使用latest
docker build -t <镜像名>:<latest>
   ```

   ```bash
# repository 的完整格式， 只有 Docker Hub 上的镜像可以省略 registry-host:[port]
[registry-host]:[port]/[username]/[image name]:[tag]
   ```

### 3.4.2 tag

我们知道: `[image name] = [repository]:[tag]`， 那么我们如何指定tag?

假设目前发布了一个镜像 **myimage**，版本为 v1.9.1，我们可以打上 4 个 tag：1.9.1、1.9、1 和 latest。

(1) myimage:1 始终指向 1 这个分支中最新的镜像。

(2) myimage:1.9 始终指向 1.9.x 中最新的镜像。

(3) myimage:latest 始终指向所有版本中最新的镜像。

(4) 如果想使用特定版本，可以选择myiamge:1.9.1、myiamge:1.9.2 或 myiamge:2.0.0

```bash
# 给版本v1.9.1的镜像 `myimage` 打tag
docker tag myimage-v1.9.1 myiamge:1 
docker tag myimage-v1.9.1 myiamge:1.9
docker tag myimage-v1.9.1 myiamge:1.9.1
docker tag myimage-v1.9.1 myiamge:latest

# 假如版本v1.9.2发布了， 1、1.9、latest迁移为1.9.2
docker tag myimage-v1.9.2 myiamge:1 
docker tag myimage-v1.9.2 myiamge:1.9
docker tag myimage-v1.9.2 myiamge:1.9.2
docker tag myimage-v1.9.2 myiamge:latest

# 假如版本v2.0.0发布了， latest迁移为2.0.0
docker tag myimage-v2.0.0 myiamge:2 
docker tag myimage-v2.0.0 myiamge:2.0
docker tag myimage-v2.0.0 myiamge:2.0.0
docker tag myimage-v2.0.0 myiamge:latest
```

### 3.4.3 使用公共 Registry 

——————

### 3.4.4 搭建本地 Registry 

——————

## 3.5 小结-常用命令

- `images`：显示镜像列表。

- `history`：显示镜像构建历史。

- `commit`：从容器创建新镜像。

- `tag`：给镜像打 tag。

- `pull`：从 registry 下载镜像。

- `push`：将镜像上传到 registry。

- `rmi`：删除 Docker host 中的镜像。例如删除 httpd镜像：

  ```bash
  # 查看所有 httpd 容器
  [root@CentOS7 ~]# docker ps -a | grep httpd
  d7050c2cabf0        httpd               "httpd-foreground"       13 days ago         Exited (0) 12 days ago                       pensive_faraday
  63dcc8bd1687        httpd               "httpd-foreground"       13 days ago         Exited (0) 13 days ago                       condescending_lamport
  
  # 删除所有 httpd 镜像创建容器 
  [root@CentOS7 ~]# docker ps -a | grep httpd | awk '{print $1}' | xargs -n1 -I {} docker rm {}
  ```

- `search`：搜索 Docker host 中的镜像。


# 第 4 章 Docker容器

**指定容器**
```
# 指定容器
<container> = "短ID" / "长ID" / "容器名称"
```

## 4.1 容器常用命令
```bash
# 创建容器
docker create ...

# 后台方式启动容器
docker start <container>
# 进入容器
docker attach <container>

# 创建并运行容器
docker run = docker create + docer start

# 重启
docker --restart

# -it 以交互模式进入容器，并打开终端
docker run -it <container>

# -d 后台运行容器
docker run -d <container>

# --name 为容器命名
docker run --name "my.http.servre" -d <container>

# 查看当前运行的容器，-a显示所有状态的容器
docker ps [-a]
or
docker container ls [-a]

# 两种方法进入容器
# 1. docker attach <container>("长ID")
# 退出：Ctrl+p，然后 Ctrl+q 退出attach终端
# 2. docker exec -it <container>("短ID") bash|sh
# 查看进程：ps -elf
# 退出：exit
# 3. attach VS exec
# 	(1) attach 直接进入容器启动命令的终端，不会启动新的进程；exec 则在容器中打开新的终端，并且可以启动新的进程。
#	(2) 如果想直接在终端中查看命令的输出，用attach；其他情况使用exec

# 查看启动命令的输出， -f 类似 tail -f ，持续打印输出
docker logs -f <container>
```

- `create`：创建容器

- `start`：启动容器

- `ps`：查看运行的容器，**-a** 显示所有状态的容器

  详细使用方法：https://docs.docker.com/engine/reference/commandline/ps/

  | Name, shorthand | Default | Description                                   |
  | --------------- | ------- | --------------------------------------------- |
  | `--all , -a`    |         | 列出所有容器，默认显示运行中的容器            |
  | `--filter , -f` |         | 根据条件过滤显示内容                          |
  | `--format`      |         | 指定Go模版美观打印容器信息                    |
  | `--last , -n`   | `-1`    | 显示最近创建的`n`个容器（包含所有状态的容器） |
  | `--latest , -l` |         | 显示最近创建容器（包含所有状态的容器）        |
  | `--no-trunc`    |         | 不截断输出                                    |
  | `--quiet , -q`  |         | 只展示容器ID，“静默模式”                      |
  | `--size , -s`   |         | 显示容器总的文件大小                          |

- `run`：运行容器

  docker run = docker create + docer start

  | Options | Mean                                               |
  | ------- | -------------------------------------------------- |
  | -i      | 以交互模式运行容器，通常与 -t 同时使用；           |
  | -t      | 为容器重新分配一个伪输入终端，通常与 -i 同时使用； |
  | -d      | 后台运行容器，并返回容器ID；                       |

- `stop`：发送SIGTERM停止容器

- `restart`：重启容器，相当于 docker stop + docker start

  **--restart=always**   无论容器以何种原因退出（包括正常退出），都立即重启。

  **--restart=on-failure:3**，意思是如果启动进程退出代码非 0，则重启容器，最多重启 3 次。

- `kill`：发送SIGKILL快速停止容器

- `pause`：暂停运行容器，暂停的容器不会占用 CPU 资源

- `unpause`：继续运行容器

- `attach`：attach 到容器启动进程的终端

- `exec`：在容器中启动新进程，通常使用 "-it" 参数

- `logs`：显示容器启动进程的控制台输出，用 "-f" 持续打印

- `rm`：从磁盘中删除容器，可以删除不会再重启的容器，以减少占用 host 文件系统资源

  ```bash
  # 批量删除所有已经退出的容器
  docker rm -v $(docker ps)
  
  # 查看所有 httpd 容器
  [root@CentOS7 ~]# docker ps -a | grep httpd
  d7050c2cabf0        httpd               "httpd-foreground"       13 days ago         Exited (0) 12 days ago                       pensive_faraday
  63dcc8bd1687        httpd               "httpd-foreground"       13 days ago         Exited (0) 13 days ago                       condescending_lamport
  
  # 删除所有 httpd 镜像创建容器 
  [root@CentOS7 ~]# docker ps -a | grep httpd | awk '{print $1}' | xargs -n1 -I {} docker rm {}
  ```

  注意： `docker rm` 是删除容器， `docker rmi` 是删除镜像。

## 4.2 如何运行服务器/工具类容器

### 1. 服务器类容器

服务器容器类以 daemon 的形式运行，对外提供服务，比如 Web Server、数据库等。通过 -d 以后台方式启动这类容器是非常合适的。如果要排查问题，可以通过 `exec -it` 进入容器。

```bash
# 启动容器
docker run -d <container>

# 进入容器
docker exec -it <container>("短ID")

# 查看进程
ps -elf

# 退出
exit
```

### 2. 工具类容器

工具类容器通常为了提供临时工作环境，常以 `run -it` 方式运行，`run -it` 的作用是在容器启动后就直接进入。

```bash
# run -it 的作用是在容器启动后就直接进入
docker run -it <container>

# 退出
exit
```

## 4.3 资源限制

### 4.3.1 内存限额

1. `-m` | `--memory`：设置内存的使用限额，例如 100MB，2GB。
2.  `--memory-swap`：设置内存+swap 的使用限额，不指定则默认为 `-m` 的两倍。
3. `--vm` 1：启动 1 个内存工作线程。
4. `--vm-bytes 280M`：每个线程分配 280M 内存。

```bash


# 启动一个容器并使用 progrium/stress 进行压力测试，分配 200MB 内存和 100MB 的 swap
docker run -it -m 200M --memory-swap=300M progrium/stress --vm 1 --vm-bytes 280M
```

### 4.3.2 CPU 限额

`-c` | `--cpu-shares`：设置 CPU 权重，不指定则默认值为 1024。

**注：分配的是权重值，比如有两个容器，一个为1024，另一个为512，则在 CPU 压满时，前者 CPU 资源是后者的两倍。若某一方空闲，另一方也可以分配到全部 CPU **

```bash
# 启动 container_A， cpu share 为 1024
docker run --name container_A -it -c 1024 progrium/stress --cpu 1

# 启动 container_B， cpu share 为 512
docker run --name container_B -it -c 512 progrium/stress --cpu 1

# 在 host 中执行top，查看容器对 CPU 的使用情况
top 

# 暂停 container_A，再次查看 CPU
docker pause container_A
top
```

### 4.3.3 Block IO 带宽限额

#### 1. block IO 权重

`-blkio-weight`：设置 Block IO 磁盘读写优先级。

```bash
# container_A 读写磁盘的带宽是 container_B 的两倍
docker run -it --name container_A --blkio-weight 600 ubuntu
docker run -it --name container_B --blkio-weight 300 ubuntu
```

#### 2. 限制 bps 和 iops

bps 是 byte per second，每秒读写的数据量。

iops 是 io per second，每秒 IO 的次数。

- `--device-read-bps`：限制读某个设备的 bps。
- `--device-write-bps`：限制写某个设备的 bps。
- `--device-read-iops`：限制读某个设备的 iops。
- `--device-write-iops`：限制写某个设备的 iops。

```bash
# 限制容器写 /dev/sda 的速率为 30MB/s
docker run -it --device-write-bps /dev/sda:30MB ubuntu

# 测试：dd 测试在容器中写磁盘的速度，容器的文件系统是在 host /dev/sda 上，所以相当于对 host /dev/sda 进行写操作。另外，oflag=direct 指定用 direct IO 方式写文件，这样 --device-write-bps 才能生效
time dd if=/dev/zero of=test.out bs=1M count=800 oflag=direct

# 不限速对比
docker run -it ubuntu
time dd if=/dev/zero of=test.out bs=1M count=800 oflag=direct
```

## 4.4 实现容器的底层技术

#### 4.4.1 cgroup

/sys/fs/cgroup 保存了容器所有 cgroup 相关的配置

- sys/fs/cgroup/cpu/docker/容器ID ：容器与 cpu 相关的 cgroup 配置
- sys/fs/cgroup/memory/docker/容器ID ：容器与内存相关的 cgroup 配置
- sys/fs/cgroup/blkio/docker/容器ID ：容器与 Block IO 相关的 cgroup 配置

```bash
# 启动一个容器
docker run -it --cpu-shares 512 progrium/stress -c 1

# 查看容器 ID
docker ps

# 查看容器 cpu 相关的 cgroup 配置
ls /sys/fs/cgroup/cpu/docker/容器 ID
```

#### 4.4.2 namespace

namespace 使得每个容器认为自己拥有文件系统、网卡等独立的资源。它管理着 host 中全局唯一的资源，实现了容器间资源的隔离。

- Mount namespace ： 容器看上去有整个文件系统，有自己的 `/` 目录，可以 `mount` 和 `unmount`。
- UTS namespace ： 容器有自己的hostname。
- IPC namespace ： 容器拥有自己的共享内存和信号量来实现进程间的通信。
- PID namespace  ： 容器在 host 中以进程的形式运行。host 通过 `docker ps` 查看容器进程，容器通过 `ps axf` 查看容器内的进程。所有容器的进程都挂在 dockerd 进程下。
- Network namespace ： 容器拥有自己独立的网卡、IP、路由等资源。
- User namespace ： 容器能够管理自己的用户，host 不能看到容器中创建的用户。 容器可以使用`useradd 用户名` 创建用户。


# 第 5 章 Docker 网络

`docker network ls` 查看 host 上的网络，Docker 安装时会自动创建 bridge、host、null 三个网络。

```bash
[root@i ~]# docker network ls
NETWORK ID          NAME                DRIVER
2df86fa81fa0        bridge              bridge              
80286d6ed4fb        host                host                
f72c16f0775d        none                null 
```

## 5.1 none 网络

none 网络，封闭的隔离网络，安全性要求高且不需要联网的应用可以使用。比如某个容器唯一用途是生成随机密码，可以放到 none 网络中避免密码被窃取。

```bash
# 容器创建时，通过 --network=none 指定使用none网络
docker run -it --network=none <container>
```

## 5.2 host 网络

连接到 host 网络的容器共享 Docker host 的网络栈。传输效率性能高，但容易产生端口冲突。

```bash
# 容器创建时，通过 --network=host 指定使用host网络
docker run -it --network=host <container>
```

## 5.3 bridge 网络 

Docker 安装时会创建一个命名为 `docker()` 的 Linux bridge。如果不指定 `--network`，创建的容器默认都会挂到 `docker()` 上。

```bash
[root@i ~]# brctl show
bridge name	bridge id		STP enabled	interfaces
docker0		8000.024219110166	no
```

**示例：查看新建容器的网络配置**

```bash
# 创建一个 httpd 容器
docker run -d httpd

# 进入容器
docker exec -it "短ID" bash

# 查看容器的网络配置
ip a

# 发现容器有一个网卡 ech0，网卡 eth0 和 docker() 的 interfaces 是一对 veth pair。veth pair 是一种成对出现的特殊网络设备，可以把它们想象成由一根虚拟网线连接起来的一对网卡，网卡的一头 eth0 在容器中， 另一头 veth 在网桥 docker() 上。

# 查看 bridge 网络的配置
docker network inspect bridge
```

## 5.4 user-defined 网络

```bash
# 通过 bridge 驱动创建类似默认的 bridge 网络
docker network create --driver bridge my_net
# 出现一个 "长ID"

# 查看 host 的网络结构变化
brctl show
# 新增了一个网桥 br-xxx，和 my_net 的 "短ID"

# 查看 my_net 配置信息
docker network inspect my_net

# 创建网段时指定 --subnet 和 --gateway 以指定IP网段 子网和网关
docker network create --driver bridge --subnet xxx.xxx.xx.0/24 --gateway xxx.xxx.xx.xxx my_net2

# 查看 my_net2 配置信息
docker network inspect my_net2

# --network 为容器指定新网络 
docker run -it --network=my_net2 <容器名>

# --ip 为容器指定静态IP 
docker run -it --network=my_net2 --ip xxx.xxx.xxx.xxx <容器名>
`注意：只有使用 --subnet 创建的网络才能指定静态 IP。否则会报错。`
```

- 同一网络中的容器、网关之间可以通信：挂在同一网络的不同容器可以通信
- 不同网桥的网络不同通信
- 使用同一网卡的容器可以通信

**示例：容器使用同一网卡通信**

```bash
# 第1个容器添加 my_net2 网卡
docker network connect my_net2 < 容器1的 "短ID" >

# 第2个容器添加 my_net2 网卡
docker network connect my_net2 < 容器2的 "短ID" >

# ping
ping -c 3 xxx.xxx.xxx.xxx
```

## 5.5 容器间通信

### 1. 同一网卡通信

见上**示例：容器使用同一网卡通信**。

### 2. Docker DNS Server

- 启动时使用 `--name` 为容器命名，就可以使用 DNS Server 通过 ”容器名“ 通信。
- 只能在 user-defined 网络中使用，默认的 bridge 网络无法使用。

```bash
# 第1个容器
docker run -it --network=my_net2 --name=bbox1 <容器名>

# 第2个容器
docker run -it --network=my_net2 --name=bbox2 <容器名>
```

### 3. joined 容器

joined 容器非常特别，它可以使多个容器共享一个网络栈，共享网卡和配置信息，可以通过 127.0.0.1 直接通信。比较适合：

- 不同容器中的程序希望通过本地回环 loopback 高效快速地通信，比如 Web Server 与 App Server。
- 希望监控其他容器的网络流量，比如运行在独立容器中的网络监控程序。

```bash
# 创建一个httpd容器，名为web1
docker run -d -it --name=web1 httpd

# 创建 busybox 容器并通过 --network=container:web1 指定 joined 容器为 web1
docer run -it --network=container:web1 busybox

# 分别查看 httpd 和 busybox 容器的网络配置信息
docker exec -it web1 bash
ip a

docker exec -it <busybox的"短ID">
ip a

`会发现 busybox 和 web1(httpd) 的网卡 MAC 地址和 IP 完全一样！它们共享了相同的网络栈。`

# busybox 通过 127.0.0.1 访问 web1 的 http服务
# docker exec -it <busybox的"短ID">
wget 127.0.0.1
cat index.html
```

## 5.6 将容器与外部世界连接

1. 容器访问外部世界 —— NAT

2. 外部世界访问容器 —— 端口映射

 # 第 6 章 Docker 存储

**storage driver** ：容器的运行时存储工作数据的一层，容器退出时会被删除。适合无状态（不需要持久化存储数据）的应用，随时可以从镜像直接创建。

**docker volume** ：本质上是 Docker Host 文件系统中的目录或文件，直接被 mount 到容器的文件系统中，容器可以读写，可以被永久地保存。通过 bind mount  将 host 上已存在的目录或文件 mount 到容器，` -v <host path>:<container path> `。<container path>原有的数据会被隐藏起来，取而代之是 <host path> 中的数据。常用：将源代码目录 mount 到容器中，host 中修改代码就可以看到效果； 将 MySQL 容器的数据放在 bind mount 里， 这样 host 可以方便地备份和迁移数据。缺点：需要指定 mount 路径，可移植性低。

**docker managed volum** ：解决docker volume 可移植性低的问题，不需要指定 mount 路径，复制数据到 volume 。通过 `docker inspect <容器短ID>` 可以看到 Mounts : Source 路径。缺点：不支持文件，不能控制读写权限。

**volume container** ： 数据存放在 host 上， 可以 mount 多个目录到 host 上，不需要处于运行状态。容器可以通过 `--volumes-from 容器名` 使用这个 volume container。

**data-packed volume container** ：数据完全存放在 volume container，可以与其他容器共享。移植性高，适合静态数据的存放，如应用的配置信息、Web server 的静态文件等。



#### 备份、恢复、迁移、销毁——



# 第7章 多主机管理

























# 第8章 容器网络

Sandbox

Endpoint

Network



overlay

​	VxLAN 

​	Consul (key-value 数据库)

​	docker_gwbridge



macvLAN （虚拟局域网)

​	sub-interface

​	

​	Trunk口
