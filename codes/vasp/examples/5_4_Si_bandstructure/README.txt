Bandstructure plot in VASP

1) Standard way: PBE
   1.1  Standard self-consistent (SC) run
   1.2  non-SC calculation (ICHARG=11) using preconverged CHGCAR file and KPOINTS_PBE_bands

2) Fake SC procedure: HSE (PBE)
   2.1 Standard self-consistent (SC) run
   2.2 Additional SC-run using KPOINTS_HSE_bands

3) VASP2WANNIER90: GW (HSE, PBE)
   3.1 Standard SC run using the existing wannier.win file  (uncomment one line for GW)
   3.2 run wannier90 (wannier90.x wannier90) to generate MLWFs
   3.3 uncomment bandstructure plot flags in wannier90.win and restart wannier90 

Extended version:

Bandstructure plot in VASP (Three different ways)

1) Standard way: PBE (Fcc Si bandstructure example).
   1.1  Standard self-consistent (SC) run
   1.2  non-SC calculation (ICHARG=11) using preconverged CHGCAR file and KPOINTS_PBE_bands

2) Fake SC procedure: PBE & HSE
   2.1 Standard self-consistent (SC) run
   2.2 Additional SC-run using KPOINTS_HSE_bands

----
The file KPOINTS_HSE_bands is constructed by copying the IBZKPT file from run 2.1 to the KPOINTS file:

IBZKPT
Automatically generated mesh
       8
Reciprocal lattice
    0.00000000000000    0.00000000000000    0.00000000000000             1
    0.25000000000000    0.00000000000000    0.00000000000000             8
    0.50000000000000    0.00000000000000    0.00000000000000             4
    0.25000000000000    0.25000000000000    0.00000000000000             6
    0.50000000000000    0.25000000000000    0.00000000000000            24
   -0.25000000000000    0.25000000000000    0.00000000000000            12
    0.50000000000000    0.50000000000000    0.00000000000000             3
   -0.25000000000000    0.50000000000000    0.25000000000000             6

Then add the desired additional k-points with zero weight and change the total number of k-points

Explicit k-points list
      18 <--- CHANGE TOTAL NUMBER OF K-POINTS !!
Reciprocal lattice
    0.00000000000000    0.00000000000000    0.00000000000000             1
    0.25000000000000    0.00000000000000    0.00000000000000             8
    0.50000000000000    0.00000000000000    0.00000000000000             4
    0.25000000000000    0.25000000000000    0.00000000000000             6
    0.50000000000000    0.25000000000000    0.00000000000000            24
   -0.25000000000000    0.25000000000000    0.00000000000000            12
    0.50000000000000    0.50000000000000    0.00000000000000             3
   -0.25000000000000    0.50000000000000    0.25000000000000             6
0.00000000 0.00000000 0.00000000 0.000 <--- ZERO WEIGHT !!
0.00000000 0.05555556 0.05555556 0.000
0.00000000 0.11111111 0.11111111 0.000
0.00000000 0.16666667 0.16666667 0.000
0.00000000 0.22222222 0.22222222 0.000
0.00000000 0.27777778 0.27777778 0.000
0.00000000 0.33333333 0.33333333 0.000
0.00000000 0.38888889 0.38888889 0.000
0.00000000 0.44444444 0.44444444 0.000
0.00000000 0.50000000 0.50000000 0.000
----

3) VASP2WANNIER90: PBE, HSE & GW 
   3.1 Standard SC run using the existing wannier.win file  
   3.2 run wannier90 (wannier90.x wannier90) to generate MLWFs
   3.3 uncomment bandstructure plot flags in wannier90.win and restart wannier90

----
If the wannier90.win file does not exist VASP will create a default wannier90.win compatible with
the POSCAR and INCAR, which need to be suitably modify by including the proper instruction required 
to generate the MLWFs (refer to the wannier90 manual):

default wannier90.win
 num_wann =     8  ! set to NBANDS by VASP

use_bloch_phases = .T.

begin unit_cell_cart
     2.7150000     2.7150000     0.0000000
     0.0000000     2.7150000     2.7150000
     2.7150000     0.0000000     2.7150000
end unit_cell_cart

begin atoms_cart
Si       0.0000000     0.0000000     0.0000000
Si       1.3575000     1.3575000     1.3575000
end atoms_cart

mp_grid =     4     4     4

begin kpoints
     0.0000000     0.0000000     0.0000000
     0.2500000     0.0000000     0.0000000
     0.5000000     0.0000000     0.0000000
     0.2500000     0.2500000     0.0000000
     0.5000000     0.2500000     0.0000000
    -0.2500000     0.2500000     0.0000000
     0.5000000     0.5000000     0.0000000
    -0.2500000     0.5000000     0.2500000
     0.0000000     0.2500000     0.0000000
     0.0000000     0.0000000     0.2500000
    -0.2500000    -0.2500000    -0.2500000
    -0.2500000     0.0000000     0.0000000
     0.0000000    -0.2500000     0.0000000
     0.0000000     0.0000000    -0.2500000
     0.2500000     0.2500000     0.2500000
     0.0000000     0.5000000     0.0000000
     0.0000000     0.0000000     0.5000000
    -0.5000000    -0.5000000    -0.5000000
     0.0000000     0.2500000     0.2500000
     0.2500000     0.0000000     0.2500000
    -0.2500000    -0.2500000     0.0000000
    -0.2500000     0.0000000    -0.2500000
     0.0000000    -0.2500000    -0.2500000
     0.0000000     0.5000000     0.2500000
     0.2500000     0.0000000     0.5000000
    -0.2500000    -0.2500000     0.2500000
    -0.5000000    -0.2500000    -0.5000000
     0.2500000     0.5000000     0.0000000
     0.2500000    -0.2500000    -0.2500000
    -0.5000000    -0.5000000    -0.2500000
     0.0000000     0.2500000     0.5000000
    -0.2500000     0.2500000    -0.2500000
    -0.2500000    -0.5000000    -0.5000000
     0.5000000     0.0000000     0.2500000
    -0.5000000    -0.2500000     0.0000000
     0.0000000    -0.5000000    -0.2500000
    -0.2500000     0.0000000    -0.5000000
     0.2500000     0.2500000    -0.2500000
     0.5000000     0.2500000     0.5000000
    -0.2500000    -0.5000000     0.0000000
    -0.2500000     0.2500000     0.2500000
     0.5000000     0.5000000     0.2500000
     0.0000000    -0.2500000    -0.5000000
     0.2500000    -0.2500000     0.2500000
     0.2500000     0.5000000     0.5000000
    -0.5000000     0.0000000    -0.2500000
     0.0000000    -0.2500000     0.2500000
     0.2500000     0.0000000    -0.2500000
    -0.2500000    -0.2500000    -0.5000000
     0.2500000     0.5000000     0.2500000
     0.2500000    -0.2500000     0.0000000
    -0.5000000    -0.2500000    -0.2500000
     0.2500000     0.2500000     0.5000000
     0.0000000     0.2500000    -0.2500000
    -0.2500000    -0.5000000    -0.2500000
     0.5000000     0.2500000     0.2500000
    -0.2500000     0.0000000     0.2500000
     0.0000000     0.5000000     0.5000000
     0.5000000     0.0000000     0.5000000
     0.2500000    -0.2500000     0.5000000
     0.5000000     0.2500000    -0.2500000
    -0.5000000    -0.2500000    -0.7500000
     0.2500000    -0.5000000    -0.2500000
    -0.2500000     0.2500000    -0.5000000
end kpoints
----   
