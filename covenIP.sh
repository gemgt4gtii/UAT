#! /bin/bash{
IP_ADDR=$(curl ipinfo.io/ip)
echo ${IP_ADDR} | awk -F. '{printf "%d\n", ($1*(2^24))+($2*(2^16))+($3*(2^8))+$4}'
