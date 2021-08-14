#! /bin/bash

echo "開始執行初始化"
while true; do
    # echo "請輸入地區(英文大寫:CN,PH,HK...):"
    read -p "請輸入地區(英文大寫:CN,PH,HK...):" area

    grep -n ${area} region_list.txt
    if [ $? -eq 0 ]; then
        echo "已確認地區: ${area}"
    else
        echo "請選擇地區"
        continue
    fi

    echo "1.wbt | 2.gbt | 3.nbt | 4.bpt | 5.bdt | 6.video | 7.pbt"
    read -p "選擇要加入的資產組(選擇數字):" input

    case $input in
    1)
        group="wbt"
        echo "你选择了 $group"
        ;;
    2)
        group="gbt"
        echo "你选择了 $group"
        ;;
    3)
        group="nbt"
        echo "你选择了 $group"
        ;;
    4)
        group="bpt"
        echo "你选择了 $group"
        ;;
    5)
        group="bdt"
        echo "你选择了 $group"
        ;;
    6)
        group="video"
        echo "你选择了 $group"
        ;;
    7)
        group="pbt"
        echo "你选择了 $group"
        ;;
    *)
        echo '請選擇小組'
        continue
        # exit 1
        ;;
    esac

    echo "${area}-${group}-$(sh covenIP.sh)" >/etc/hostname
    cat /etc/hostname
    break
done
