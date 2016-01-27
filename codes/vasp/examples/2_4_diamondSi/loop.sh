#! /bin/bash
BIN=/fs/local/users/koulu1/vasp/bin/vasp
rm WAVECAR SUMMARY.dia
for i in  5.1 5.2 5.3 5.4 5.5 5.6 5.7 ; do
cat >POSCAR <<!
cubic diamond
   $i 
 0.0    0.5     0.5
 0.5    0.0     0.5
 0.5    0.5     0.0
  2
Direct
 -0.125 -0.125 -0.125
  0.125  0.125  0.125
!
echo "a= $i" ; aprun -n 2 $BIN
E=`awk '/F=/ {print $0}' OSZICAR` ; echo $i $E  >>SUMMARY.dia
done
cat SUMMARY.dia
