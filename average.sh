#!/bin/sh

if [ $# -ne 3 ]
    then
        echo "Usage: ./average.sh timefreq numcol inputfile 
Input
 - timefreq: hour, day, month -1
             (if -1 no time averaging, using entire file)
 - numcol: number of column where the data is stored
 - Inputfile: N column ascii file (yyyymmdd HHMM XX XX data)  " >&2
        exit 1
    fi



timefreq=$1
filename=$3
numcol=$2
RUNDIR=`pwd`

case "$timefreq" in
hour)

for day in `cat $RUNDIR/$filename | awk '(NR>3) {print $1}'| uniq`
do
for hour in `cat $RUNDIR/$filename | grep $day | awk ' {print substr($2,1,2)}'| uniq`
do
cat $RUNDIR/$filename | awk '($1 == "'$day'")&&(substr($2,1,2)=="'$hour'") {sum+=$'$numcol' ; count++ } END { printf "%8d %02d00 %f \n",'$day','$hour',sum/count}' 
done
done

;;

day)

for day in `cat $RUNDIR/$filename | awk '(NR>3) {print $1}'| uniq`
do
cat $RUNDIR/$filename | awk '($1 == "'$day'") {sum+=$'$numcol' ; count++ } END { print '$day',sum/count}'
done

;;

month)

for month in `cat $RUNDIR/$filename | awk '(NR>3) {print substr($1,1,6)}'| uniq`
do
cat $RUNDIR/$filename | awk '(substr($1,1,6) == "'$month'") {sum+=$'$numcol' ; count++ } END { print '$month',sum/count}'
done

;;


ymon)

for month in `cat $RUNDIR/$filename | awk '(NR>3) {print substr($1,5,2)}'| sort -u`
do
cat $RUNDIR/$filename | awk '(substr($1,5,2) == "'$month'") {sum+=$'$numcol' ; count++ } END { print '$month',sum/count}'
done

;;



year)

for year in `cat $RUNDIR/$filename | awk '(NR>3) {print substr($1,1,4)}'| uniq`
do
cat $RUNDIR/$filename | awk '(substr($1,1,4) == "'$year'") {sum+=$'$numcol' ; count++ } END { print '$year',sum/count}'
done
;;


-1)

# Absolute value
cat $RUNDIR/$filename | awk '{sum+=sqrt($'$numcol'^2) ; count++ } END { print sum/count}'

;;

esac
