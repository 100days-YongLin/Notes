Mac搭建Hadoop集群记录

系统：PD虚拟Ubuntu进行



## 踩坑：设置免密之后还需要密码

参考一：

下列修改的均是要远程登录的主机的目录/文件权限，xxx为远程主机用户名
1、用户主目录 /home/xxx 的权限如果为 777，修改为 755或700，降低权限
chmod 755 /home/xxx 或者  chmod 700 /home/xxx
2、/home/xxx/.ssh目录的权限，它的权限须是700
chmod 700 /home/xxx
3、密钥文件authorized_keys的权限，它的权限要求是600
chmod 600 /home/xxx/.ssh/authorized_keys



参考二：

修改一下.ssh的用户和权限

1. chown username: /home/username/.ssh 
2. chown username: /home/username/.ssh/* 
3. chmod 700 /home/username/.ssh 
4. chmod 600 /home/username/.ssh/* 



## 踩坑：明明配了JAVA环境变量还找不到

到Hadoop目录下的etc/hadoop/hadoop-env.sh

再配一遍



## 踩坑：NameNode访问网页 不能上传

修改Mac的Hosts 映射关系写清楚



## 踩坑：本地JPS好使但是ssh JPS不好使

建立一下软连接，每台机子都弄一下

sudo ln -s $JAVA_HOME/bin/jps /usr/local/bin/jps



## **Ubuntu关闭防火墙命令**

sudo ufw disable



## Ubuntu装Mysql：

**直接用指令安装**

apt-get install mysql-server



**初始密码在**

/etc/mysql/debian.cnf



**修改密码**

设置为无密登陆

use mysql;

alter user 'root'@'*' identified with mysql_native_password by '新密码';

退出 停止mysql服务

关闭无密登陆 开启服务 即可



**取消只有sudo可以登陆mysql：**

sudo vim /etc/mysql/my.cnf

添加

[mysqld]



**配置文件路径**

/etc/mysql/mysql.conf.d/mysqld.cnf

允许本地无密码登陆 添加 skip-grant-tables



## MySQL相关

**开启服务**

service mysql start/stop



**本地登陆**

mysql -uroot -p123456



peHOSOk05KQ2hDQl



## Hive相关

在Mac里Java爆内存，hive-site.xml添加以下

```xml
<property>
<name>yarn.nodemanager.vmem-check-enabled</name>
<value>false</value>
</property>

<property>
<name>yarn.scheduler.maximum-allocation-mb</name>
<value>10000</value>
</property>

<property>
<name>yarn.scheduler.minimum-allocation-mb</name>
<value>3000</value>
</property>

<property>
<property>
    <name>mapreduce.reduce.memory.mb</name>
    <value>4000</value>
</property>
  
<property>
    <name>mapreduce.map.memory.mb</name>
    <value>4000</value>
</property>

<name>yarn.nodemanager.vmem-pmem-ratio</name>
<value>2.1</value>
</property>

<property>
<name>mapred.child.java.opts</name>
<value>-Xmx3080m</value>
</property>

<property>
<name>mapreduce.cluster.map.memory.mb</name>
<value>-1</value>
</property>

<property>
<name>mapreduce.cluster.reduce.memory.mb</name>
<value>-1</value>
</property>
```

来源：[解决Hive内存溢出问题 2.1 GB of 2.1 GB virtual memory us... - 简书 (jianshu.com)](https://www.jianshu.com/p/7d32a32a6e43/)



Metastore mysql8不兼容问题

```

```



## Parallels配网问题

[(38条消息) Paralles Desktop网络设置相关问题_freshcoolman的博客-CSDN博客](https://blog.csdn.net/u014157109/article/details/101869118?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2)



## Arm centos yum源问题

[华为 arm架构服务器 centos7 yum源 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/430561706)



## Arm 安装 MySQL5.7问题

[ARM64架构下安装mysql5.7.22的全过程_Mysql_脚本之家 (jb51.net)](https://www.jb51.net/article/217014.htm)



## RPM安装依赖错误问题

[(38条消息) 依赖检测失败： libc.so.6(GLIBC_2.14)(64bit) 被 mysql-community-libs-5.7.28-1.el7.x86_64 需要_数据开发小胡的博客-CSDN博客](https://blog.csdn.net/qq_42209718/article/details/122960335)



## MYSQL5.7 初始密码问题

```
方法一：

grep 'temporary password' /var/log/mysqld.log

运行后会得到一个密码，这里我的centos7.4下没有反应，故尝试第二种方法

方法二：

该方法先修改mysql配置文件使其可以无密码登录，让后修改密码，之后便复原配置文件

修改/etc/my.cnf

vim /etc/my.cnf

配置文件添加skip-grant-tables

socket=/var/lib/mysql/mysql.sock

skip-grant-tables                       此处！！！！！！

保存后重启mysql

systemctl restart mysql

即可免密登录，命令行输入mysql直接登录

选择mysql数据库，输入下列命令重置密码，'new-password'即为所设置密码

USE mysql;

mysql> update mysql.user set authentication_string=password('****') where user='root'

修改完成后输入exit退出，重新回到/etc/my.cnf该文件删除之前添加语句即可完成
```

