# git 安装

> 本安装文件是基于  [`github.com`](https://github.com/git/git) 源码，`CentOS` 系统安装，`Ubuntu` 我不常用。
>
> 欢迎提交兼容代码。


### 使用 
```shell

wget -O git.sh https://raw.githubusercontent.com/pifeifei/git-install/master/git.sh

# centos 需要安装 epel 源, 安装 `docbook2X` 时会用到
yum install -y epel-release
# 更新缓存
yum clean all && yum makecache


# 安装指定版本(推荐)
sh git.sh 2.23.0

# 安装最新版本
sh git.sh

# PATH 变量生效
#PATH="$PATH:$SOFT_PATH" => $PATH:/www/soft/bin
source /etc/bashrc

# 安装目录(default:/www/soft)
echo $SOFT_DIR

# 还会创建目录(日后可能有其他目录创建, 软件数据默认在软件文件夹内,如果存在的话.)
mkdir -p $SOFT_DIR/bin
mkdir -p $SOFT_DIR/etc
mkdir -p $SOFT_DIR/sbin
```

### 额外说明

> 1. git 使用说明传送门: [点我](https://git-scm.com/book/zh/v2)
> 2. `CentOS` 没有 [`docbook2X`](http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/d/docbook2X-0.8.8-17.el7.x86_64.rpm) 软件, 需要安装 `epel` 扩展源。

