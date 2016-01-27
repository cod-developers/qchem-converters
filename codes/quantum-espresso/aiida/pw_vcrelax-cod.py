#!/usr/bin/env runaiida
# -*- coding: utf-8 -*-

__copyright__ = u"Copyright (c), 2015, ECOLE POLYTECHNIQUE FEDERALE DE LAUSANNE (Theory and Simulation of Materials (THEOS) and National Centre for Computational Design and Discovery of Novel Materials (NCCR MARVEL)), Switzerland and ROBERT BOSCH LLC, USA. All rights reserved."
__license__ = "MIT license, see LICENSE.txt file"
__version__ = "0.4.1"
__contributors__ = "Andrea Cepellotti, Giovanni Pizzi, Nicolas Mounet"

sssp_names = [
    'ag_pbe_v1.4.uspp.F.UPF',
    'Al.pbe-n-kjpaw_psl.1.0.0.UPF',
    'Ar.pbe-n-rrkjus_psl.1.0.0.UPF',
    'As.pbe-n-rrkjus_psl.0.2.UPF',
    'Au_ONCV_PBE-1.0.upf',
    'Ba_ONCV_PBE-1.0.upf',
    'be_pbe_v1.4.uspp.F.UPF',
    'Bi.pbe-dn-kjpaw_psl.0.2.2.UPF',
    'B.pbe-n-kjpaw_psl.0.1.UPF',
    'br_pbe_v1.4.uspp.F.UPF',
    'Ca_pbe_v1.uspp.F.UPF',
    'Cd.pbe-dn-rrkjus_psl.0.3.1.UPF',
    'cl_pbe_v1.4.uspp.F.UPF',
    'Co_pbe_v1.2.uspp.F.UPF',
    'C_pbe_v1.2.uspp.F.UPF',
    'cr_pbe_v1.5.uspp.F.UPF',
    'Cs_pbe_v1.uspp.F.UPF',
    'Cu_pbe_v1.2.uspp.F.UPF',
    'Fe.pbe-spn-kjpaw_psl.0.2.1.UPF',
    'f_pbe_v1.4.uspp.F.UPF',
    'Ga.pbe-dn-rrkjus_psl.0.2.UPF',
    'Ge.pbe-dn-kjpaw_psl.1.0.0.UPF',
    'He_ONCV_PBE-1.0.upf',
    'Hf.pbe-spn-rrkjus_psl.0.2.UPF',
    'Hg_pbe_v1.uspp.F.UPF',
    'H.pbe-rrkjus_psl.0.1.UPF',
    'In.pbe-dn-rrkjus_psl.0.2.2.UPF',
    'I_pbe_v1.uspp.F.UPF',
    'Ir_pbe_v1.2.uspp.F.UPF',
    'K.pbe-spn-rrkjus_psl.1.0.0.UPF',
    'Kr.pbe-n-rrkjus_psl.0.2.3.UPF',
    'li_pbe_v1.4.uspp.F.UPF',
    'mg_pbe_v1.4.uspp.F.UPF',
    'Mn.pbe-spn-kjpaw_psl.0.3.1.UPF',
    'Mo_ONCV_PBE-1.0.upf',
    'Na_pbe_v1.uspp.F.UPF',
    'Nb.pbe-spn-kjpaw_psl.0.3.0.UPF',
    'Ne.pbe-n-kjpaw_psl.1.0.0.UPF',
    'ni_pbe_v1.4.uspp.F.UPF',
    'N.pbe.theos.UPF',
    'O_pbe_v1.2.uspp.F.UPF',
    'Os_pbe_v1.2.uspp.F.UPF',
    'Pb.pbe-dn-kjpaw_psl.0.2.2.UPF',
    'Pd.pbe-spn-kjpaw_psl.1.0.0.UPF',
    'Po.pbe-dn-rrkjus_psl.1.0.0.UPF',
    'P.pbe-n-rrkjus_psl.1.0.0.UPF',
    'pt_pbe_v1.4.uspp.F.UPF',
    'Rb_ONCV_PBE-1.0.upf',
    'Re_pbe_v1.2.uspp.F.UPF',
    'Rh.pbe-spn-kjpaw_psl.1.0.0.UPF',
    'Rn.pbe-dn-rrkjus_psl.1.0.0.UPF',
    'Ru_ONCV_PBE-1.0.upf',
    'sb_pbe_v1.4.uspp.F.UPF',
    'Sc_pbe_v1.uspp.F.UPF',
    'Se_pbe_v1.uspp.F.UPF',
    'Si.pbe-n-rrkjus_psl.1.0.0.UPF',
    'Sn_pbe_v1.uspp.F.UPF',
    'S_pbe_v1.2.uspp.F.UPF',
    'Sr.pbe-spn-rrkjus_psl.1.0.0.UPF',
    'Ta_pbe_v1.uspp.F.UPF',
    'Tc_ONCV_PBE-1.0.upf',
    'Te_pbe_v1.uspp.F.UPF',
    'ti_pbe_v1.4.uspp.F.UPF',
    'Tl.pbe-dn-rrkjus_psl.0.2.3.UPF',
    'V_pbe_v1.uspp.F.UPF',
    'W_pbe_v1.2.uspp.F.UPF',
    'Xe.pbe-dn-rrkjus_psl.1.0.0.UPF',
    'Y_pbe_v1.uspp.F.UPF',
    'Zn_pbe_v1.uspp.F.UPF',
    'Zr_pbe_v1.uspp.F.UPF',
]

sssp_config = {
    "Ag": [ 35, 8 ],
    "Al": [ 30, 8 ],
    "Ar": [ 120, 8 ],
    "As": [ 30, 8 ],
    "Au": [ 45, 4 ],
    "B": [ 40, 8 ],
    "Ba": [ 40, 4 ],
    "Be": [ 40, 8 ],
    "Bi": [ 35, 8 ],
    "Br": [ 30, 8 ],
    "C": [ 50, 8 ],
    "Ca": [ 30, 8 ],
    "Cd": [ 40, 8 ],
    "Cl": [ 35, 8 ],
    "Co": [ 55, 8 ],
    "Cr": [ 40, 8 ],
    "Cs": [ 30, 8 ],
    "Cu": [ 40, 8 ],
    "F": [ 50, 8 ],
    "Fe": [ 90, 12 ],
    "Ga": [ 35, 8 ],
    "Ge": [ 40, 8 ],
    "H": [ 55, 8 ],
    "He": [ 55, 4 ],
    "Hf": [ 35, 8 ],
    "Hg": [ 30, 8 ],
    "I": [ 30, 8 ],
    "In": [ 35, 8 ],
    "Ir": [ 40, 8 ],
    "K": [ 50, 8 ],
    "Kr": [ 100, 8 ],
    "Li": [ 30, 8 ],
    "Mg": [ 35, 8 ],
    "Mn": [ 70, 12 ],
    "Mo": [ 35, 4 ],
    "N": [ 55, 8 ],
    "Na": [ 30, 8 ],
    "Nb": [ 35, 8 ],
    "Ne": [ 200, 8 ],
    "Ni": [ 45, 8 ],
    "O": [ 45, 8 ],
    "Os": [ 35, 8 ],
    "P": [ 30, 8 ],
    "Pb": [ 40, 8 ],
    "Pd": [ 55, 8 ],
    "Po": [ 45, 8 ],
    "Pt": [ 30, 8 ],
    "Rb": [ 50, 4 ],
    "Re": [ 30, 8 ],
    "Rh": [ 45, 8 ],
    "Rn": [ 45, 8 ],
    "Ru": [ 40, 4 ],
    "S": [ 30, 8 ],
    "Sb": [ 40, 8 ],
    "Sc": [ 30, 8 ],
    "Se": [ 30, 8 ],
    "Si": [ 30, 8 ],
    "Sn": [ 35, 8 ],
    "Sr": [ 35, 8 ],
    "Ta": [ 30, 8 ],
    "Tc": [ 30, 4 ],
    "Te": [ 30, 8 ],
    "Ti": [ 35, 8 ],
    "Tl": [ 30, 8 ],
    "V": [ 40, 8 ],
    "W": [ 30, 8 ],
    "Xe": [ 120, 8 ],
    "Y": [ 35, 8 ],
    "Zn": [ 40, 8 ],
    "Zr": [ 30, 8 ],
}

import sys
import os

from aiida.common.example_helpers import test_and_get_code

################################################################

UpfData = DataFactory('upf')
ParameterData = DataFactory('parameter')
KpointsData = DataFactory('array.kpoints')
StructureData = DataFactory('structure')
try:
    dontsend = sys.argv[1]
    if dontsend == "--dont-send":
        submit_test = True
    elif dontsend == "--send":
        submit_test = False
    else:
        raise IndexError
except IndexError:
    print >> sys.stderr, ("The first parameter can only be either "
                          "--send or --dont-send")
    sys.exit(1)

try:
    codename = sys.argv[2]
except IndexError:
    codename = None

queue = None
settings = None

code = test_and_get_code(codename, expected_code_type='quantumespresso.pw')
max_seconds = 600

kpoints = KpointsData()
kpoints_mesh = 4
kpoints.set_kpoints_mesh([kpoints_mesh, kpoints_mesh, kpoints_mesh])

from aiida.tools.dbimporters.plugins.cod import CodDbImporter
from aiida.orm.data.cif import parse_formula
codi = CodDbImporter()

launched_calcs = {}

## SQL query, executed in the COD database:
## select file, formula
## from data
## where nel = 3 and a < 5 and b < 5 and c < 5 and
##       alpha = 90 and beta = 90 and gamma = 90
## order by file

for entry in [
#     1001184,
#     1001185,
#     1001186,
#     1001619,
#     1001775,
#     1004073,
#     1005047,
#     1005048,
#     1008016,
#     1008017,

#     1008114,
#     1008127,
#     1008128,
#     1008562,
#     1008756,
#     1008763,
#     1008957,
#     1008958,
#     1008959,
#     1009040,

#     1009044,
#     1009045,
#     1009046,
#     1009048,
#     1009050,
#     1009051,
#     1009073,
#     1009074,
#     1010020,
#     1010301,

1010348,
1010404,
1010406,
1010407,
1010419,
1010420,
1010424,
1010425,
1010652,
1010653,

    ]:

    r = codi.query(id=entry)
    cif = r[0].get_cif_node(store=True)

    try:
        struct = cif._get_aiida_structure(store=True)
    except KeyError:
        print('{}: unable to construct AiiDA structure -- structure '
              'possibly contains deuterium'.format(entry))
        continue

    elements = parse_formula(cif.get_formulae()[0])

    ecutwfc_max = 0
    ecutrho_max = 0

    try:
        for e in elements:
            if  ecutwfc_max < sssp_config[e][0]:
                ecutwfc_max = sssp_config[e][0]
            if  ecutrho_max < sssp_config[e][0] * sssp_config[e][1]:
                ecutrho_max = sssp_config[e][0] * sssp_config[e][1]
    except KeyError:
        print('{}: can not find pseudopotential for one or more '
              'elements in a structure'.format(entry))
        continue

    parameters = ParameterData(dict={
        'CONTROL': {
            'calculation': 'vc-relax',
            'restart_mode': 'from_scratch',
            'wf_collect': True,
            'max_seconds': max_seconds,
        },
        'SYSTEM': {
            'ecutwfc': ecutwfc_max,
            'ecutrho': ecutrho_max,
            'smearing': 'mv',
            'degauss': 0.01,
            'occupations': 'smearing',
        },
        'ELECTRONS': {
            'conv_thr': 1.e-10,
        }})

    calc = code.new_calc()
    calc.label = "Test QE pw.x"
    calc.description = "Test vc-relax calculation with the Quantum ESPRESSO pw.x code"
    calc.set_max_wallclock_seconds(max_seconds)
    # Valid only for Slurm and PBS (using default values for the
    # number_cpus_per_machine), change for SGE-like schedulers 
    calc.set_resources({"num_machines": 1})

    if queue is not None:
        calc.set_queue_name(queue)

    calc.use_structure(struct)
    calc.use_parameters(parameters)

    from aiida.orm.querytool import QueryTool
    for e in elements:
        fname = None
        for name in sssp_names:
            if name.lower().startswith("{}.".format(e.lower())):
                fname = name
            if name.lower().startswith("{}_".format(e.lower())):
                fname = name

        q = QueryTool()
        q.set_class(UpfData)
        q.add_attr_filter('filename', 'exact', fname)
        upf = q.run_query().next()
        calc.use_pseudo(upf, kind=e)

    calc.use_kpoints(kpoints)

    if settings is not None:
        calc.use_settings(settings)

    from aiida.common.exceptions import InputValidationError

    try:
        if submit_test:
            subfolder, script_filename = calc.submit_test()
            print "Test_submit for calculation (uuid='{}')".format(
                calc.uuid)
            print "Submit file in {}".format(os.path.join(
                os.path.relpath(subfolder.abspath),
                script_filename
            ))
        else:
            calc.store_all()
            calc.submit()
            print "{}: submitted for calculation, pk={}".format(entry,
                                                            calc.dbnode.pk)
            launched_calcs[calc.dbnode.pk] = { "codid": entry,
                                               "calculation": calc }
    except InputValidationError:
        pass

from aiida.tools.dbexporters.tcod import deposit
import time

for pk in launched_calcs.keys():
    codid = launched_calcs[pk]['codid']
    calc  = launched_calcs[pk]['calculation']

    while not calc.has_finished_ok() and not calc.has_failed():
        time.sleep(15)

    if not calc.has_finished_ok():
        print "{}: calculation was not successful".format(codid)
        continue

    struct = calc.out.output_structure
    deposit(struct,
            'personal',
            url="http://www.crystallography.net/tcod/cgi-bin/cif-deposit.pl",
            title='Relaxation of COD entry {} using '
                  'Quantum ESPRESSO and SSSP'.format(codid),
            code_label='cif_cod_deposit_local',
            computer_name='theospc11',
            gzip=True)
