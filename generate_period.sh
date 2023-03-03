#!/bin/sh
sdate=$1;
edate=$2;
n=0;
date=$sdate
idate=`echo $date | sed 's/-//g'`
iedate=`echo $edate | sed 's/-//g'`
echo $date;
while [ $idate -le $iedate ];do 
	date=`gdate '+%Y-%m-%d' --date='+1 day '$date`; 
	idate=`gdate '+%Y%m%d' --date='+1 day '$date`; 
	echo $date;
done
