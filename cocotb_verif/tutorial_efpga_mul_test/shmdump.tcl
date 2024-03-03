database -open -shm dump -into dump.shm -default
#probe -all -memories -shm -depth 7
probe -create -shm core_south.soc.axi_cfuAccel.fpga.flatFabric_1 -depth 5 -all
probe -all -shm -depth 3
probe -ports -shm -depth 6
run
