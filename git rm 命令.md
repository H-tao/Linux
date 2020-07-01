

## 删除本地和远端的文件

> rm <file> / rm -r <dir>
>
> git commit
>
> git push

```bash
# 删除本地文件
[root@CentOS7 hellopython]# rm t1.json 
[root@CentOS7 hellopython]# rm t2.xml 
[root@CentOS7 hellopython]# ls
helloworld.py  README.md


# 查看状态
[root@CentOS7 hellopython]# git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    t2.xml
	deleted:    t1.json

no changes added to commit (use "git add" and/or "git commit -a")


# git commit 提交删除信息
[root@CentOS7 hellopython]# git commit -m "删除自定义的t1.json和t2.xml" ./
[master 2df524d] 删除自定义的t1.json和t2.xml
 2 files changed, 3 deletions(-)
 delete mode 100644 t2.xml
 delete mode 100644 t1.json
 
 
# git push 将删除信息提交到远端
[root@CentOS7 hellopython]# git push
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
..
   4673d12..2df524d  master -> master

```



## 删除add的文件
> git rm --cached <file>
```bash
# 查看状态
[root@CentOS7 hellopython]# git status
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   build/log/build.log
	new file:   build/nohup.out


# 进行删除
[root@CentOS7 hellopython]# git rm --cached build/nohup.out
rm 'build/nohup.out'
[root@CentOS7 hellopython]# git rm --cached build/log/build.log
rm 'build/log/build.log'


# 删除之后，文件变成Untracked
[root@CentOS7 hellopython]# git status
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	build/log/
	build/nohup.out

```


## 删除add的文件夹
> git rm -f --cached <dir>
```bash
# 查看状态
[root@CentOS7 hellopython]# git status
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   config


# 删除文件夹
[root@CentOS7 hellopython]# git rm -f --cached config
rm 'config'


# 删除之后，文件夹变成untracked
[root@CentOS7 hellopython]# git status
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	config/
```
