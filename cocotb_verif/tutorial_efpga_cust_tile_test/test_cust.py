import os
import cocotb
import pytest
from cocotb.runner import get_runner

tests_dir = os.path.dirname(__file__)

def test_efpga_cust():
    sim = os.getenv("SIM", "xcelium")

    runner = get_runner(sim)
    runner.build( 
            verilog_sources=[
                os.path.join(tests_dir, "fabrics", "flatFabric.sv"),
                os.path.join(tests_dir, "fabrics", "muxC.v"),
                os.path.join(tests_dir, "fabrics", "sim_BUF_BB.v"),
                os.path.join(tests_dir, "fqmul.sv")
            ],
            hdl_toplevel="flatFabric",
            build_args=[
                "-define INTC_NO_PWR_PINS", 
                "-define INTEL_NO_PWR_PINS", 
                "-define INTCNOPWR",
                "-nowarn PRPASZ",
                "-nowarn LMTMSG",
                "-gateloopwarn",
                "-access +rwc",
                "-notimingchecks",
                "-warn_multiple_driver",
                "-ALLOWREDEFINITION",
                "-vlog_ext +.vg",
                "-libext +.sv",
                "-libext +.v"]

       )
    runner.test(hdl_toplevel="flatFabric", test_module="cust_fpga,")


    
