

### 启动docker

```
systemctl start docker
```

### 查看docker服务状态

```bash
systemctl status docker
or
systemctl status docker.service

[root@i ~]$ systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: `active (running)` since Mon 2020-06-29 20:26:05 CST; 20h ago
     Docs: https://docs.docker.com
 Main PID: 6194 (docker)
    Tasks: 40
   Memory: 77.1M
   CGroup: /system.slice/system-hostos.slice/docker.service
           ├─6194 /usr/bin/docker daemon --live-restore
           └─6254 docker-containerd -l unix:///var/run/docker/libcontainerd/docker-containerd.sock --shim docker-containerd-shim --start-timeout 2m --state-dir ...
```

### 查看Docker版本

```bash
[root@i ~]# docker --version
Docker version 1.11.2, build e0843f8

[root@i ~]# docker version
Client:
 Version:        1.11.2
 UnicornVersion: 1.11.2.131
 API version:    1.23
 Go version:     go1.12.4
 Git commit:     e0843f8
 Built:          Tue Feb 12 00:00:00 2019
 OS/Arch:        linux/amd64

Server:
 Version:        1.11.2
 UnicornVersion: 1.11.2.131
 API version:    1.23
 Go version:     go1.12.4
 Git commit:     e0843f8
 Built:          Tue Feb 12 00:00:00 2019
 OS/Arch:        linux/amd64
 

[root@i ~]# docker info
Containers: 6
 Running: 0
 Paused: 0
 Stopped: 6
Images: 979
Server Version: 1.11.2
....
Live Restore Enabled: true

```



### hello-world

```
[root@i ~]# docker pull hello-world

```



## 如何创建镜像?

```


```



## 如何分发镜像?

1. 用相同的 Dockerfile 在其他 host 构建镜像。

2. 将镜像上传到公共 Registry

   (1) 需要 Internet 连接，而且下载和上传速度慢。

   (2) 上传到 Docker Hub 的镜像任何人都能够访问，虽然可以用私有 repository，但不是免费的。

   (3) 因安全原因很多组织不允许将镜像放到外网。

3. 搭建私有的 Registry



## 常用命令

```bash
docker build -t 镜像名

# 查看镜像信息
docker images <镜像名>
[image name] = [repository]:[tag]

# docker build 默认tag使用latest
docker build -t <镜像名>:<latest>

```

- `images`：显示镜像列表。

- `history`：显示镜像构建历史。

- `commit`：从容器创建新镜像。

- `tag`：给镜像打 tag。

- `pull`：从 registry 下载镜像。

- `push`：将镜像上传到 registry。

- `rmi`：删除 Docker host 中的镜像。

- `search`：搜索 Docker host 中的镜像。

  

## 如何指定tag？

(1) myimage:1 始终指向 1 这个分支中最新的镜像。

(2) myimage:1.9 始终指向 1.9.x 中最新的镜像。

(3) myimage:latest 始终指向所有版本中最新的镜像。

(4) 如果想使用特定版本，可以选择myiamge:1.9.1、myiamge:1.9.2 或 myiamge:2.0.0

```bash
# 给版本v1.9.1的镜像 `myimage` 打tag，示例
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



```
# repository 的完整格式， 只有 Docker Hub 上的镜像可以省略 registry-host:[port]
[registry-host]:[port]/[username]/[image name]:[tag]


```



# 第4章 Docker容器

**指定容器**
```
# 指定容器
<container> = "短ID" / "长ID" / "容器名称"
```
```bash
# 创建容器
docker create ...

# 后台方式启动容器
docker start <container>
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
# 退出：Ctrl+p，如何Ctrl+q 退出attach终端
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

- `run`：运行容器

  | Options | Mean                                               |
  | ------- | -------------------------------------------------- |
  | -i      | 以交互模式运行容器，通常与 -t 同时使用；           |
  | -t      | 为容器重新分配一个伪输入终端，通常与 -i 同时使用； |
  | -d      | 后台运行容器，并返回容器ID；                       |

- `pause`：取消暂停继续运行容器

- `stop`：发送SIGTERM停止容器

- `kill`：发送SIGKILL快速停止容器

- `start`：启动容器

- `restart`：重启容器

- `attach`：attach 到容器启动进程的终端

- `exec`：在容器中启动新进程，通常使用 "-it" 参数

- `logs`：显示容器启动进程的控制台输出，用 "-f" 持续打印

- `rm`：从磁盘中删除容器

## 运行容器的最佳实践

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

## 4.6 资源限制

### 4.6.1 内存限额

1. `-m` | `--memory`：设置内存的使用限额，例如 100MB，2GB。
2.  `--memory-swap`：设置内存+swap 的使用限额，不指定则默认为 `-m` 的两倍。
3. `--vm` 1：启动 1 个内存工作线程。
4. `--vm-bytes 280M`：每个线程分配 280M 内存。

```bash
# 启动一个容器并使用 progrium/stress 进行压力测试，分配 200MB 内存和 100MB 的 swap
docker run -it -m 200M --memory-swap=300M progrium/stress --vm 1 --vm-bytes 280M
```

### 4.6.2 CPU 限额

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

### 4.6.3 Block IO 带宽限额

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

### 4.7 实现容器的底层技术

#### 4.7.1 cgroup

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

#### 4.7.2 namespace

namespace 使得每个容器认为自己拥有文件系统、网卡等独立的资源。它管理着 host 中全局唯一的资源，实现了容器间资源的隔离。

- Mount namespace ： 容器看上去有整个文件系统，有自己的 `/` 目录，可以 `mount` 和 `unmount`。
- UTS namespace ： 容器有自己的hostname。
- IPC namespace ： 容器拥有自己的共享内存和信号量来实现进程间的通信。
- PID namespace  ： 容器在 host 中以进程的形式运行。host 通过 `docker ps` 查看容器进程，容器通过 `ps axf` 查看容器内的进程。所有容器的进程都挂在 dockerd 进程下。
- Network namespace ： 容器拥有自己独立的网卡、IP、路由等资源。
- User namespace ： 容器能够管理自己的用户，host 不能看到容器中创建的用户。 容器可以使用`useradd 用户名` 创建用户。


# 第5章 Docker 网络


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

 # 第6章 Docker 存储

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

​	Trunk口



flannel

​	vxlan

​	

​	host-gw

​	无DNS服务，容器无法通过 hostname 通信

​	
