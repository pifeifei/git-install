#!/bin/bash

##########################
# author : kis龍 <270228163@qq.com>
# 
# 自动安装 git , 目前只支持 centos,其他系统没有适配
#
##########################


GIT_VERSION=$1
# . common.conf

# common var
IN_PWD=$(pwd)
IN_SRC=${IN_PWD}/src
LOGPATH=${IN_PWD}/logs
INF=${IN_PWD}/inf
SOFT_DIR=${SOFT_DIR:-"/www/soft"}
RE_INS=0
BIT=`getconf LONG_BIT`

CPUS=`cat /proc/cpuinfo | grep "processor" | wc -l`

# 初始化目录
[ ! -d "$IN_SRC" ] && mkdir "$IN_SRC"
[ ! -d "$LOGPATH" ] && mkdir "$LOGPATH"
[ ! -d "$INF" ] && mkdir "$INF"
[ ! -d "${SOFT_DIR}/git" ] && mkdir -p "${SOFT_DIR}/git"

# 初始化安装(SOFT_DIR)目录
# 目前数据在各自软件文件夹内(如果存在数据文件)
[ ! -d "${SOFT_DIR}/bin" ] && mkdir -p "${SOFT_DIR}/bin"
[ ! -d "${SOFT_DIR}/etc" ] && mkdir -p "${SOFT_DIR}/etc"
[ ! -d "${SOFT_DIR}/sbin" ] && mkdir -p "${SOFT_DIR}/sbin"

# git source url | 可以改成自己的 git 源码镜像库链接
GIT_SOURCES=${GIT_SOURCES:-"https://github.com/git/git.git"}

# software version
# GIT_VERSION=${GIT_VERSION:-"master"}
GIT_VERSION=${GIT_VERSION:-"v2.22.0"}



function err_exit {
    echo 
    echo 
    uname -m
    [ -f /etc/redhat-release ] && cat /etc/redhat-release
    echo -e "\033[31m----Install Error: $1 -----------\033[0m"
    echo
    echo -e "\033[0m"
    echo
    exit
}


yum install -y gcc gcc-c++ make sudo autoconf openssl-devel cmake \
            sendmail pam-devel ntpdate
yum -y install git curl-devel expat-devel gettext-devel \
    openssl-devel zlib-devel asciidoc xmlto texinfo \
	openjade perl perl-XML-SAX
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/d/docbook2X-0.8.8-17.el7.x86_64.rpm
ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

#if [ "$GIT_VERSION" == "master" ]
cd $IN_SRC
[ ! -d "$IN_SRC/git-${GIT_VERSION}" ] && git clone ${GIT_SOURCES} --branch ${GIT_VERSION} --depth 1 --single-branch git-${GIT_VERSION}
# err = 1 为什么, 文件夹存在时
# [ $? != 0 ] && err_exit "git clone err"
# [ ! -d "/www/pff/git-install/src/git-v2.21.0" ] && echo 111
# else
#	git clone ${GIT_SOURCES} --branch ${GIT_VERSION} --depth 1 --single-branch git-${GIT_VERSION} 
#fi

cd $IN_SRC/git-${GIT_VERSION}

make configure
[ $? != 0 ] && err_exit "make configure err"
./configure --prefix=${SOFT_DIR}/git-${GIT_VERSION}
[ $? != 0 ] && err_exit "./configure err"
make -j $CPUS all doc info
[ $? != 0 ] && err_exit "make err"
make install install-doc install-html install-info
[ $? != 0 ] && err_exit "make install err"

GIT_VERSION_NOW=`${SOFT_DIR}/git-${GIT_VERSION}/bin/git --version| cut -c13-`
[ $GIT_VERSION_NOW != $GIT_VERSION ] && mv "${SOFT_DIR}/git-${GIT_VERSION}" "${SOFT_DIR}/git-${GIT_VERSION_NOW}"
[ $GIT_VERSION_NOW != $GIT_VERSION ] && GIT_VERSION=$GIT_VERSION_NOW

#GIT_VERSION_NOW=`/www/soft/git-2.22.GIT/bin/git --version| cut -c13-`

ln -sf "${SOFT_DIR}/git-${GIT_VERSION}" "${SOFT_DIR}/git"
ln -sf "${SOFT_DIR}/git-${GIT_VERSION}/bin/git" "${SOFT_DIR}/bin/git"
ln -sf "${SOFT_DIR}/git-${GIT_VERSION}/bin/gitk" "${SOFT_DIR}/bin/gitk"
ln -sf "${SOFT_DIR}/git-${GIT_VERSION}/bin/git-shell" "${SOFT_DIR}/bin/git-shell"

yum -y remove git

cd "${SOFT_DIR}/git-${GIT_VERSION}/"
#cp -rf share/man/* /usr/local/share/man/

ADDPATH=`cat /etc/bashrc | grep SOFT_PATH`
[ -z "$ADDPATH" ] && echo "SOFT_PATH=\"${SOFT_DIR}/bin:${SOFT_DIR}/libexec/git-core\"">>/etc/bashrc
[ -z "$ADDPATH" ] && echo "PATH=\"\$PATH:\$SOFT_PATH\"">>/etc/bashrc
[ -z "$ADDPATH" ] && source /etc/bashrc

touch ~/.gitconfig
git config --global init.templatedir "${SOFT_DIR}/git-${GIT_VERSION}/share/git-core/templates"

cd $IN_PWD

    echo
    echo
    echo
    echo -e "      \033[31mCongratulations ,git install is complete"
    echo -e "      source /etc/bashrc"
    echo -e "      more infomation please visit http://github.com/pifeifei/git-install\033[0m"
    echo