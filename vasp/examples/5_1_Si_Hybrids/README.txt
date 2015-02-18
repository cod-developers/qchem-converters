For each HF+DFT method (B3LYP, PBE0, HSE06, and HF) compute the bandgap of Si
adopting the following procedure:

i) Perform a standard PBE calculation
ii) Perform a HF+DFT run
iii) Calculate the value of the bandgap by running the script 'gap': 
     bandgap = min(cband) - max(vband) 
