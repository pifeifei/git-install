# git 安装


### 使用 
```shell

wget -O git.sh https://raw.githubusercontent.com/pifeifei/git-install/master/git.sh

# 安装最新版本
sh git.sh

# 安装指定版本
sh git.sh 2.21.0

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

