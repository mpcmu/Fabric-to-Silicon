
synth:
	genus -file scripts/genus.tcl -log logs/syth.log

pnr:
	innovus -stylus -file scripts/invs_stylus.tcl -log logs/pnr.log

pd:
	genus -file scripts/genus.tcl -log logs/synth.log
	innovus -synth -file scripts/invs_stylus.tcl -log logs/pnr.log
