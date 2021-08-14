#! /bin/bash

sh choose_business.sh

if [ $? -eq 0 ]; then
    echo "已确认业务"
else
    echo "机器业务未确认"
    exit 1
fi

echo "开始安装salt"
sh install_salt_minion.sh

echo "加入Jump"
