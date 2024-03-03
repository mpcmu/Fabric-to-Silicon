###############################################################################
# Copyright (c) 2013 Potential Ventures Ltd
# Copyright (c) 2013 SolarFlare Communications Inc
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Potential Ventures Ltd,
#       SolarFlare Communications Inc nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL POTENTIAL VENTURES LTD BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################

######################################################
#	Cocotb settings
######################################################
TOPLEVEL_LANG ?= verilog
PWD=$(shell pwd)
SIM ?= xcelium
COCOTB_HDL_TIMEUNIT ?= 1ps
COCOTB_HDL_TIMEPRECISION ?= 1ps

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/../model;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../model:$(PYTHONPATH)
endif

######################################################
#	Testbench settings
######################################################
STEP 	 ?= simple_efpga_asap7
TOPLEVEL := flatFabric
MODULE   := sub_fpga
SHM ?= 1
PLUSARGS += "+STEP=$(STEP)"

######################################################
#	RTL simulation sources
######################################################

ifeq ($(STEP),simple_efpga_asap7)
VERILOG_SOURCES += ./fabrics/flatFabric.sv
VERILOG_SOURCES += ./fabrics/muxC.v
VERILOG_SOURCES += ./fabrics/sim_BUF_BB.v



TOPLEVEL := flatFabric
COMPILE_ARGS+="-define INTC_NO_PWR_PINS"
COMPILE_ARGS+="-define INTEL_NO_PWR_PINS"
COMPILE_ARGS+="-define INTCNOPWR"

endif




######################################################
#	Common simulation source files
######################################################


######################################################
#	Simulator flags/settings
######################################################
# Common simulator settings
COMPILE_ARGS+="-sv"
COMPILE_ARGS+="-y $(CHIPYARD_ROOT)/IP/MRAM/HIP/"
COMPILE_ARGS+="-define RANDOMIZE_REG_INIT"
COMPILE_ARGS+="-define RANDOMIZE_MEM_INIT"
COMPILE_ARGS+="-define PRINTF_COND=1"
COMPILE_ARGS+="-define INTC_NOXHANDLING"
#COMPILE_ARGS+="-define INTC_MEM_NOXHANDLING"
COMPILE_ARGS+="-define INTC_SVA_OFF"
# COMPILE_ARGS+="-define FUNCTIONAL"
COMPILE_ARGS+="-define FORMAL"

# Simulator-specific settings
ifeq ($(SIM),questa)
COMPILE_ARGS+="+acc=rc +libext+.v +libext+.sv"
COMPILE_ARGS+="-suppress vlog-12003"
SIM_ARGS+="-suppress vlog-12003"

else ifeq ($(SIM),xcelium)
COMPILE_ARGS+="-nowarn PRPASZ" # SHM can't probe wide signals warning
COMPILE_ARGS+="-nowarn LMTMSG" # SHM can't probe wide signals warning 2

#COMPILE_ARGS+="-xminitialize rand_2state"
#COMPILE_ARGS+="-xminit_log init.log"

#COMPILE_ARGS+="-initmem0"
COMPILE_ARGS+="-gateloopwarn"
# COMPILE_ARGS+="-override_timescale"
COMPILE_ARGS+="-access +rwc"
COMPILE_ARGS+="-notimingchecks"
COMPILE_ARGS+="-warn_multiple_driver"
COMPILE_ARGS+="-ALLOWREDEFINITION"
COMPILE_ARGS+="-vlog_ext +.vg"
# COMPILE_ARGS+="-sequdp_nba_delay"
COMPILE_ARGS+="-libext +.sv"
COMPILE_ARGS+="-libext +.v"
#COMPILE_ARGS+=-input initialize.tcl

ifeq ($(SHM),1)
COMPILE_ARGS+=-input shmdump.tcl
endif

endif

include $(shell cocotb-config --makefiles)/Makefile.sim
