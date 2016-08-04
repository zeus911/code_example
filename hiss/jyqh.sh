#!/bin/sh
# ./jyqh.sh 10015  /cygdrive/d/现场实施/软件/cygwin/Test/ /cygdrive/d/工作/项目/金源期货/InvestorPositionDetail.csv 
# 参数说明：
#$1=客户号(10015)
#$2=10015.txt文件所在目录
#$3=/cygdrive/d/工作/项目/金源期货/InvestorPositionDetail.csv 

kh_file_name=$2$1.txt
echo $kh_file_name

iconv -f GBK -t UTF-8 $kh_file_name  >jyqh-khh.txt
file1_1=$(cat $3 | gawk -v kh_id=$1 -F, '{ if ($5 == 1 && $3 == kh_id) he[$1]+=$8 } END{ for (var in he) print var,1,he[var]; }')
file1_2=$(cat $3 | gawk -v kh_id=$1 -F, '{ if ($5 == 0 && $3 == kh_id) he[$1]+=$8 } END{ for (var in he) print var,0,he[var]; }')

if [[ ! -z "$file1_1" ]]
  then
  newline2="\n"
fi 

file1=$(echo -e "$file1_1""$newline2""$file1_2"|sort -k1,2)

info_1=$(cat ./jyqh-khh.txt | sed -n '/持仓汇总/,/本帐单/p'| sed -n '5,$ p'|head -n -5|gawk -F\| ' {if ($6!=0) print $2$3 $6} '|gawk '{print $1$2" 1 "$3} ')
info_2=$(cat ./jyqh-khh.txt | sed -n '/持仓汇总/,/本帐单/p'| sed -n '5,$ p'|head -n -5|gawk -F\| ' {if ($4!=0) print $2$3 $4} '|gawk '{print $1$2" 0 "$3}')

if [[ ! -z "$info_1" ]]
  then
  newline="\n"
fi 
file2=$(echo -e "$info_1""$newline""$info_2"| sed 's/铜/cu/'| sed 's/铁/Au/'|sort -k1,2)

echo "----------InvestorPositionDetail.csv用户持仓情况----------"
echo "$file1"
echo "----------10015.txt用户持仓情况----------"
echo "$file2"

if [ "$file1" == "$file2" ]
then
    echo "Files have the same content"
    exit 0
else
    echo "Files have NOT the same content"
    exit 1
fi


