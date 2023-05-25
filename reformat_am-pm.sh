# Different one-liner AWK's to write the output format: YYYYMMDD HHMM XXXXX
# Choose the option you need

# original format (D)D/(M)M/YYYY , (H)H:MM AM/PM , XXXX
cat file | awk -F',' '{split($1,a,"/")split($2,b,":"); if (($2~/PM/)&&(substr($2,1,2)!=12)) printf "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],12+b[1]b[2],$20,$19; else if (($2~/AM/)&&(substr($2,1,2)==12)) printf "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],-12+b[1]b[2],$20,$19; else printf  "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],b[1]b[2],$20,$19 }'

# original format (M)M/(d)d/YYYY (H)H:MM AM/PM, XXXX (Notice the missing comma between date and time)
cat file.csv  | awk -F ' ' '{split($1,a,"/")split($2,b,":"); if (($3~/PM/)&&(substr($2,1,2)!=12)) printf "%4d%02d%02d %04d, %s\n", a[3],a[1],a[2],12+b[1]b[2],$0; else if (($3~/AM/)&&(substr($2,1,2)==12)) printf "%4d%02d%02d %04d, %s\n", a[3],a[1],a[2],-12+b[1]b[2],$0; else printf  "%4d%02d%02d %04d, %s\n", a[3],a[1],a[2],b[1]b[2],$0}' | awk -F "," '(NR>4){print $1,$20,$19}' | awk '(NF==4){print $0}' > final.txt

# original format 7/1/2019 1:10 AM ;504
 awk '{split($1,a,"/")split($2,b,":"); if (($3~/PM/)&&(substr($2,1,2)!=12)) printf "%4d%02d%02d %04d %s\n", a[3],a[1],a[2],12+b[1]b[2],$4; else if (($3~/AM/)&&(substr($2,1,2)==12)) printf "%4d%02d%02d %04d %s\n", a[3],a[1],a[2],-12+b[1]b[2],$4; else printf  "%4d%02d%02d %04d %s\n", a[3],a[1],a[2],b[1]b[2],$4}' | sed "s/;//g" 

# original format 1/1/2014 1:10 am 5.21 315.0
 awk '{split($1,a,"/")split($2,b,":"); if (($3~/pm/)&&(substr($2,1,2)!=12)) printf "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],12+b[1]b[2],$4,$5; else if (($3~/am/)&&(substr($2,1,2)==12)) printf "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],-12+b[1]b[2],$4,$5; else printf  "%4d%02d%02d %04d %s %s\n", a[3],a[2],a[1],b[1]b[2],$4,$5 }' 

# Inverted direction
cat file | awk '{if ($4<180) print $1,$2,$3,$4+180; else print $1,$2,$3,$4-180}'
