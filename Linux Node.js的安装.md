# Linux Node.js的安装

## 安装上传下载包
```bash
# 安装包
yum install lrzsz -y

# 使用方法
# 上传文件
rz
# 下载文件
sz file
```

## 安装同版本Node.js
- Node.js 安装包及源码下载地址为：https://nodejs.org/dist/

```bash

[root@i ~]# cd /opt/buildtools/

[root@i buildtools]# rz

# 解压文件
[root@i buildtools]# tar -zxvf node-v10.16.0-linux-x64.tar.gz

[root@i buildtools]# vim /etc/profile
# 修改内容，注释掉原来的NODE_HOME，添加新的NODE_HOME：
#export NODE_HOME=/opt/buildtools/node.js-10.16.0
export NODE_HOME=/opt/buildtools/node-v10.16.0-linux-x64
export NODE_HOME=/opt/buildtools/node-v14.4.0-linux-x64


# 查看原来的软连接位置
[root@i ~]# which node
/usr/local/bin/node
[root@i ~]# which npm
/usr/local/bin/npm

# 查看原来的软连接指向
[root@i ~]# ll /usr/local/bin/npm 
lrwxrwxrwx 1 root root 39 Jun  1 11:25 /usr/local/bin/npm -> /opt/buildtools/node.js-10.16.0/bin/npm
[root@i ~]# ll /usr/local/bin/node
lrwxrwxrwx 1 root root 40 Jun  1 11:25 /usr/local/bin/node -> /opt/buildtools/node.js-10.16.0/bin/node

# 删除软连接
[root@i ~]# rm /usr/local/bin/npm
rm: remove symbolic link ‘/usr/local/bin/npm’? y
[root@i ~]# rm /usr/local/bin/node 
rm: remove symbolic link ‘/usr/local/bin/node’? y

# 重新配置软连接
[root@i ~]# ln -s /opt/buildtools/node-v10.16.0-linux-x64/bin/npm /usr/local/bin/npm
[root@i ~]# ln -s /opt/buildtools/node-v10.16.0-linux-x64/bin/node /usr/local/bin/node


```

## 安装最新版本Node.js

```bash
[root@i ~]# cd /opt/buildtools/

[root@i buildtools]# rz

# 解压文件
[root@i buildtools]# tar -zxvf node-v14.4.0-linux-x64.tar.gz

[root@i buildtools]# vim /etc/profile
# 修改内容，注释掉原来的NODE_HOME，添加新的NODE_HOME：
#export NODE_HOME=/opt/buildtools/node.js-10.16.0
#export NODE_HOME=/opt/buildtools/node-v10.16.0-linux-x64
export NODE_HOME=/opt/buildtools/node-v14.4.0-linux-x64

# 查看原来的软连接位置
[root@i ~]# which node
/usr/local/bin/node
[root@i ~]# which npm
/usr/local/bin/npm

# 查看原来的软连接指向
[root@i buildtools]# ll /usr/local/bin/npm
lrwxrwxrwx 1 root root 47 Jun 29 09:58 /usr/local/bin/npm -> /opt/buildtools/node-v10.16.0-linux-x64/bin/npm
[root@i buildtools]# ll /usr/local/bin/node 
lrwxrwxrwx 1 root root 48 Jun 29 09:59 /usr/local/bin/node -> /opt/buildtools/node-v10.16.0-linux-x64/bin/node

# 删除软连接
[root@i buildtools]# rm /usr/local/bin/npm 
rm: remove symbolic link ‘/usr/local/bin/npm’? y
[root@i buildtools]# rm /usr/local/bin/node 
rm: remove symbolic link ‘/usr/local/bin/node’? y

# 重新配置软连接
[root@i buildtools]# ln -s /opt/buildtools/node-v14.4.0-linux-x64/bin/npm /usr/local/bin/npm
[root@i buildtools]# ln -s /opt/buildtools/node-v14.4.0-linux-x64/bin/node /usr/local/bin/node

# 查看版本
[root@i buildtools]# node -v
v14.4.0
[root@i buildtools]# npm -v
6.14.5
```



## 配置华为源

### Node.js安装和NPM设置

<http://3ms.huawei.com/km/blogs/details/6059335> 

```bash
# 另一种代理
npm config rm proxy
npm config rm http-proxy
npm config rm https-proxy
npm config set no-proxy .huawei.com
npm config set registry http://cmc-cd-mirror.rnd.huawei.com/npm
```




## npm install -g @angular/cli@latest 失败
[npm install -g @angular/cli@latest 失败](https://www.cnblogs.com/AlienXu/p/8632855.html)



## npm i (npm install)出现问题

###  1. npm ERR! code EINTEGRITY

```
npm ERR! code EINTEGRITY
npm ERR! sha512-x8RUl6oiZy0H68nKbY+Z2fzmxZ80FGjyGwvaSfDqFpXxOn+Wekk+CzB0mUv3nJTix+WR87rHTSxR32IubTH+BA== integrity checksum failed when using sha512: wanted sha512-x8RUl6oiZy0H68nKbY+Z2fzmxZ80FGjyGwvaSfDqFpXxOn+Wekk+CzB0mUv3nJTix+WR87rHTSxR32IubTH+BA== but got sha512-/5dwdKBtZWP2kMxTunzpbycFLmL/xWxWoqSKr8/pogSpfHIIsnZBfN4RimXk4ZiGJo1OT23qjH6a5gIDTwL80Q==. (15670 bytes)
```

```
rm -rf package-lock.json node_modules/ && npm cache clean --force && npm install
```

### 2. 接着出现

```
npm ERR! code ENOPACKAGEJSON
npm ERR! package.json Non-registry package missing package.json: tiny@http://rnd-think.huawei.com/tiny3doc/tiny3npm/3.1.2/tiny.tgz.
npm ERR! package.json npm can't find a package.json file in your current directory.
```





### sh: ng: command not found



##### Your New Personal Access Token

>Pq_x44ACyi7wRXUFTNe-

Make sure you save it - you won't be able to access it again.
