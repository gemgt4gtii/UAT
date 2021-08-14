#! /bin/bash

sh choose_business.sh

if [ $? -eq 0 ]; then
    echo "已確認業務"
else
    echo "機器業務未確認"
    exit 1
fi

echo "開始安裝salt"
sh install_salt_minion.sh

echo "加入Jump"
