#! /bin/bash

ls /etc/yum.repos.d/salt-latest.repo
if [ $? -eq 0 ]; then
    echo "salt-minion rpm包已安装"
else
    echo "salt-minion rpm包未安装"
fi

echo "检测salt rpm源"
yum install https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm -y
if [ $? -eq 0 ]; then
    echo "添加salt rpm源 -> 成功"
else
    echo "添加salt rpm源 -> 失败"
fi

echo "安装salt-minion"
# 安装salt-minion
yum install salt-minion -y
if [ $? -eq 0 ]; then
    echo "安裝salt-minion -> 成功"
    # 清理yum缓存
    echo "清理yum缓存"
    yum clean expire-cache
    echo "启动服务"

    systemctl start salt-minion.service
    systemctl start salt-minion

    systemctl enable salt-minion.service
    systemctl enable salt-minion

    echo "服务状态:"
    service salt-minion status

else
    echo "安装salt-minion -> 失败"
    exit 1
fi

# 修改salt-minion配置文件
echo "修改salt-minion配置文件"
cat >>/etc/salt/minion <<EOF
master: 192.168.254.101
id: $(hostname -s)
EOF

if [ $? -eq 0 ]; then
    echo "修改salt-minion配置文件 -> 成功"
else
    echo "修改salt-minion配置文件 -> 失败"
fi

# 重启salt-minion
echo "重启salt-minion"
systemctl restart salt-minion.service

if [ $? -eq 0 ]; then
    echo "重启salt-minion -> 成功"
else
    echo "重启salt-minion -> 失败"
fi

salt-call test.ping
if [ $? -ne 0 ]; then
    echo "连接salt失败"
    exit
else
    echo "连接salt成功"
fi
salt-call state.sls init.user.init
