#! /bin/bash

echo "开始执行初始化"
while true; do
    # echo "请输入地区(英文大写:CN,PH,HK...):"
    read -p "请输入地区(英文大写:CN,PH,HK...):" area

    grep -w ${area} region_list.txt
    if [ $? -eq 0 ]; then
        echo "已确认地区: ${area}"
    else
        echo "请选择地区"
        continue
    fi

    echo "1.wbt | 2.gbt | 3.nbt | 4.bpt | 5.bdt | 6.video | 7.pbt"
    read -p "选择要加入的资产组(选择数字):" input

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
