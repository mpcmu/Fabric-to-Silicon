.PHONY: gen_fabric gen_bitstream

gen_fabric:
	test -n "$(RRXML)" # provide $RRXML=<xml_file_path>
	./mill -i fts.runMain efpga.top.FabricGen $(RRXML)
	echo "Done. => Fabric RTL in verilog/fabric/flatFabric.sv"

gen_bitstream:
	test -n "$(RRXML)" # provide $RRXML=<xml_file_path>
	test -n "$(FASM)" # provide $FASM=<fasm_file_path>
	./mill -i fts.runMain vtrutils.fasm.BitstreamGen $(RRXML) $(FASM)
	echo "Done. Outputs in bitstream/ folder"


