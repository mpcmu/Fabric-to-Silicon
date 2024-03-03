Post your questions and raise issues on our [gitter](https://app.gitter.im/#/room/!caIZPIzqZRxWsNVwfm:gitter.im) room.

## Tool versions & dependencies

* FPGA CAD
    * [Yosys](https://github.com/YosysHQ/yosys): 0.33+34
    * [VPR](https://github.com/verilog-to-routing/vtr-verilog-to-routing/): 8.1.0-dev+7a9676256

* eFPGA Verification
    * [cocotb](https://github.com/cocotb/cocotb): 1.8.1
    * [pytest](https://docs.pytest.org/en/8.0.x/): 7.0.1
    * Cadence Xcelium: 22.03

* Physical Design
    * [ASAP7](https://github.com/The-OpenROAD-Project/asap7) PDK 
    * Cadence Genus: 21.12
    * Cadence Innovus: 21.13

Note: Other versions of Genus/Innovus/Xcelium should also work but are not tested.


## Instructions


### STEP 1: Create an FPGA fabric using VTR 
There are several test applications available to you in fpga_cad_flow directory. Edit `vpr_env.sh` to point to your VPR installation location.

```command
cd fpga_cad_flow
source vpr_env.sh
cd example_designs/<test_application>
source design.sh

cd yosys
make synth

cd ../vpr_pnr
make vpr
make genfasm
```

This will generate RRXML (FPGA routing resource graph)  and FASM (FPGA assembly) files which are used by Fabric-to-Silicon to generate the eFPGA Verilog and bitstream. To view the FPGA fabric used in the test applications please run the following command in `vpr_pnr` directory:

```command
make vpr_gui
```

To create your own application, use one of the example directories as template and make changes to the `inputs/<example>.v` file. Make sure that the `DESIGN_NAME` in `design.sh` matches your top level module name.

### STEP 2: Generate FPGA RTL

```command
cd fabric_gen
export RRXML=<path to rr xml>
make gen_fabric $RRXML
```


### STEP 3: Generate the bitstream for your application
To execute a specific application you need to generate the bitstream to configure your FPGA fabric

```command
export RRXML=<path to rr xml>
export FASM=<path to fasm>
make gen_bitstream $RRXML $FASM
```

### STEP 4: Verification of test application

Once you have generated the bitstream, you would want to load it onto your FPGA fabric and verify it's functionality.
For hardware verification, we use the cocotb framework to simulate our FPGA fabric using python libraries.

To setup cocotb environment, you need to run these commands from the root directory:
```command
cd cocotb_verif
virtualenv -p /usr/bin/python3.6 cocotb_env/
source cocotb_env/bin/activate
pip install cocotb
pip install pysilicon
pip install numpy
pip install pytest
```
Once you have set up the cocotb python environment, you can use your preferred verilog simulator to run tests
For our tutorial, we used Cadence Xcelium software and we will be structuring the tutorial based on this.

First, you add the location for your xcelium installation to the PATH variable. We do this using the `xrun_env.sh` script. You will need to make changes to this script according to your file system.

```command
source xrun_env.sh
```

In `cocotb_verif` you will find several tests named `tutorial_efpga_<application>_test` corresponding to the specific applications whose bitstream you want to load onto the FPGA fabric and test.
To verify all tests at once, you can run the following command and check if all tests are passing.

```command
pytest -o log_cli=true
```

This will pick up all pytest test files with name `test_*.py` from the subdirectories and execute them. We have added `assert` statements in the testbenches that will stop the execution and report errors if expected output does not match with the actual output of the verilog simulation.

For in-depth tests and a closer look at waveforms for all signals in the fabric, you can go to the respective test directory and follow the following steps

```command
cd tutorial_efpga_<application>_test
make -B
```

This will dump a waveform file `dump.shm` which you can open using any waveform viewer and examine the waveforms. For our tutorial we use simvision.

```command
simvision dump.shm
```

In the Makefile, you can choose what test you want to run by changing the `MODULE` variable. This will execute the `<MODULE>.py` cocotb testbench which has the main test module and several other python functions to support the test.

### STEP 5: Physical Design flow

Before running the commands please edit the cadence_asap7_template.bash to point to your Cadence and ASAP7 tool installation directories.


```command
cd physical_design
cd simple_fpga
source scripts/cadence_asap7_template.bash
source scripts/design.sh

make synth
make pnr
``` 


