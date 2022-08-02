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