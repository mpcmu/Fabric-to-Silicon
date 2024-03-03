export DESIGN_NAME="alu_sub"
export WORK_DIR=$PWD
export VPR_RUN_DIR="${WORK_DIR}/vpr_pnr/"


# Yosys / VPR Setup
#====================

# Architecture file with a Fixed size eFPGA (4x4)
# export ARCH_FILE="${WORK_DIR}/../../vpr_arch_files/k4_N8_sparse_xbar_4x4.xml"
export ARCH_FILE="${WORK_DIR}/../../vpr_arch_files/k4_N8_simple_fpga.xml"


# Bitstream generator 
#====================

# Hier instance path from top module (used to run LEC/PnR) to redacted wrapper. (eg. gps_xregs --> "p/xregs_efpga/")
# If redacted wrapper is the top module this variable can be left empty. (eg. add16 --> "")
export REDACTED_DESIGN_HIER=""
# Do not modify EFPGA_HIER
export EFPGA_HIER="${REDACTED_DESIGN_HIER}efpga/"

# Fabric generator
#====================

# GOLDEN_MODULE_NAME should be same as design name
export GOLDEN_MODULE_NAME="${DESIGN_NAME}"
# REDACTED_MODULE_NAME is typically same as design name. Can be modified if needed.
export REDACTED_MODULE_NAME="${DESIGN_NAME}"
# Name of the clock signal must be specified here.
export CLOCK_NAME="clock"
# Output wrapper verilog file name
export OUT_WRAPPER_FILENAME="${DESIGN_NAME}_efpga.v"


# LEC
#====

# Change LEC_RUN_DIR_NAME if needed
export LEC_RUN_DIR_NAME="${DESIGN_NAME}"

# If you are running LEC on top level module change this variable to the top level module name
# If you are running LEC on wrapper leave as is. (GOLDEN_MODUE_NAME & REDACTED_MODULE_NAME must be same in this case)
export LEC_TOP_MODULE_NAME="${DESIGN_NAME}"

export BITSTREAM_LEC_FILE="${WORK_DIR}/../../bitstream_gen/scripts/outputs/bitstream_LEC_${DESIGN_NAME}.tcl"
