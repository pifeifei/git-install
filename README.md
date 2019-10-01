# git install

>  This installation file is based on [`github.com`](https://github.com/git/git) source code, `CentOS` system installation, `Ubuntu` I am not commonly used.
>
>  welcome to submit compatible code.
>


### use 
```shell

wget -O git.sh https://raw.githubusercontent.com/pifeifei/git-install/master/git.sh


# Install the specified version (recommend)
sh git.sh 2.21.0

# Install the latest version.
sh git.sh

# PATH variable takes effect
#PATH="$PATH:$SOFT_PATH" => $PATH:/www/soft/bin
source /etc/bashrc

# Installation directory(default:/www/soft)
echo $SOFT_DIR
```

### Extra detail

> 1. Git instructions for using the portal: [click me](https://git-scm.com/book/zh/v2)
>
> 2. `CentOS` does not have [`docbook2X`](http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/d/docbook2X-0.8.8-17.el7.x86_64.rpm)  software, Need to install the `epel` extension source.
>

