#!/bin/bash
 
SYSTEM_NAME=`lsb_release -is`
SYSTEM_VERSION=`lsb_release -cs`
SYSTEM_VERSION_NUMBER=`lsb_release -rs`
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m            提供以下国内更新源可供选择： \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m *  1)    中科大 \033[0m'
echo -e '\033[37m *  2)    华为云 \033[0m'
echo -e '\033[37m *  3)    阿里云 \033[0m'
echo -e '\033[37m *  4)    网易 \033[0m'
echo -e '\033[37m *  4)    搜狐 \033[0m'
echo -e '\033[37m *  6)    清华大学 \033[0m'
echo -e '\033[37m *  7)    南阳理工大学 \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e "\033[37m      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER \033[0m"
echo -e "\033[37m      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M) \033[0m"
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
CHOICE=$(echo -e '\033[32m请输入您想使用的国内更新源 [ 1~7 ]：\033[0m')
read -p "$CHOICE" INPUT
case $INPUT in
    1)
          SOURCE="mirrors.ustc.edu.cn"
            ;;
    2)
          SOURCE="mirrors.huaweicloud.com"
            ;;
    3)
          SOURCE="mirrors.aliyun.com"
            ;;
    4)
          SOURCE="mirrors.163.com"
            ;;
    5)
          SOURCE="mirrors.sohu.com"
            ;;
    6)
          SOURCE="mirrors.tuna.tsinghua.edu.cn"
            ;;
    7)
          SOURCE="mirror.nyist.edu.cn"
            ;;
*)
          SOURCE="mirrors.aliyun.com"
    echo -e ''
    echo -e '\033[33m----------输入错误，更新源将默认使用阿里源---------- \033[0m'
    sleep 3s
            ;;
esac
ls /etc/apt | grep sources.list.bak -qw
if [ $? -eq 0 ];then
    echo -e '\033[32m检测到已备份的 source.list源 文件，跳过备份操作...... \033[0m'
else
    cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
    echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
fi
sleep 2s
sed -i '1,$d' /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
sudo apt-get update