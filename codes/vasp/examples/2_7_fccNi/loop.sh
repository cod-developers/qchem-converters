#! /bin/bash
BIN=/fs/local/users/koulu1/vasp/bin/vasp
rm WAVECAR SUMMARY.fcc
for i in 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 ; do
cat >POSCAR <<!
fcc:
   $i
 0.5 0.5 0.0
 0.0 0.5 0.5
 0.5 0.0 0.5
   1
cartesian
0 0 0
!
echo "a= $i" ; aprun -n 2 $BIN
E=`awk '/F=/ {print $0}' OSZICAR` ; echo $i $E  >>SUMMARY.fcc
done
cat SUMMARY.fcc
