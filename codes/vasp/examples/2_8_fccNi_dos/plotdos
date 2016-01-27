awk 'BEGIN{i=1} /dos>/,\
                /\/dos>/ \
                 {a[i]=$2 ; b[i]=$3 ; i=i+1} \
     END{for (j=12;j<i-5;j++) print a[j],b[j]}' vasprun.xml > dos.dat

ef=`awk '/efermi/ {print $3}' vasprun.xml`

cat >plotfile<<!
# set term postscript enhanced eps colour lw 2 "Helvetica" 20
# set output "optics.eps"
plot "dos.dat" using (\$1-$ef):(\$2) w lp
!

gnuplot -persist plotfile

rm dos.dat plotfile
