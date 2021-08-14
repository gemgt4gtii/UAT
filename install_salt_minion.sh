#! /bin/bash

ls /etc/yum.repos.d/salt-latest.repo
if [ $? -eq 0 ]; then
    echo "salt-minion rpm包已安裝"
else
    echo "salt-minion rpm包未安裝"
fi

echo "檢測salt rpm源"
yum install https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm -y
if [ $? -eq 0 ]; then
    echo "添加salt rpm源 -> 成功"
else
    echo "添加salt rpm源 -> 失敗"
fi

echo "安裝salt-minion"
# 安裝salt-minion
yum install salt-minion -y
if [ $? -eq 0 ]; then
    echo "安裝salt-minion -> 成功"
    # 清理yum緩存
    echo "清理yum緩存"
    yum clean expire-cache
    echo "啟動服務"

    systemctl start salt-minion.service
    systemctl start salt-minion

    systemctl enable salt-minion.service
    systemctl enable salt-minion

    echo "服務狀態:"
    service salt-minion status

else
    echo "安裝salt-minion -> 失敗"
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
    echo "修改salt-minion配置文件 -> 失敗"
fi

# 重啓salt-minion
echo "重啓salt-minion"
systemctl restart salt-minion.service

if [ $? -eq 0 ]; then
    echo "重啓salt-minion -> 成功"
else
    echo "重啓salt-minion -> 失敗"
fi

salt-call test.ping
if [ $? -ne 0 ]; then
    echo "連接salt失敗"
    exit
else
    echo "連接salt成功"
fi
salt-call state.sls init.user.init
