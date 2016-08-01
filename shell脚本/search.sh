#!/bin/bash

#获取seed.txt中的url路径
urlpath=../urls/
#rm seed.txt
#echo http://www.jmu.edu.cn>seed.txt

seedfile=seed.txt
cd /opt/apache-nutch-2.2.1/runtime/local/urls
seed=$(cat ${seedfile})

echo "seed.txt:"
echo $seed
leftseed=${seed%%.*}
leftwww=${seed%//*}
echo "leftseed:"
echo ${leftseed}
echo "leftwww:"
echo ${leftwww}
if [[ "${leftseed}" = "www" ]] || [[ "${leftseed}" = "http://www" ]];then
	subseed=${seed#*.}
elif [[ "${leftwww}" = "http:" ]];then
	subseed=${seed#*http://}
else
	subseed=${seed}
fi		

newseed='+^http://([a-z0-9]*\.)*'${subseed}/
echo "new regex filter:"
echo ${newseed}

#更改regex-urlfilter.txt
cd /opt/apache-nutch-2.2.1/runtime/local/conf
echo "current path:"
echo | pwd
regexfile=regex-urlfilter.txt
startLine=`sed -n '/anything/=' ${regexfile}` #先计算带any字符串行的行号
lineAfter=1
echo ${startLine}
let endLine="startLine + lineAfter"
echo ${endLine}
sed -i ${endLine}','$endLine'd' ${regexfile}
echo ${newseed} >> ${regexfile}


#执行nutch开始爬取数据
cd /opt/apache-nutch-2.2.1/runtime/local/
echo "current path:"
echo | pwd
bin/nutch crawl urls -threads 30
echo "nutch work finished"


#使用elasticsearch-jdbc导入数据
cd /opt/elasticsearch-jdbc-2.3.1.0/bin
echo "current path:"
echo | pwd
./import.sh
echo "import data to elasticsearch finished"

		


