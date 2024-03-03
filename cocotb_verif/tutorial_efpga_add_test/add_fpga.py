from operator import xor
import cocotb
from cocotb.triggers import Timer,ClockCycles
from cocotb.result import TestFailure, TestSuccess
from cocotb.binary import BinaryValue
from cocotb.clock import Clock
from cocotb.utils import get_sim_time
from cocotb.triggers import Edge,FallingEdge,ClockCycles
from cocotb.handle import HierarchyObject, Force
import numpy as np
import random, copy, sys
from pysilicon.scan_driver import *
from pysilicon.binary import *
from pysilicon.essentials import *
from collections import deque
import math
import os

cur_dir = os.path.dirname(__file__)


step = "simple_efpga_asap7"
_ns = 1000
T = 1*_ns



@cocotb.test()
def core_test(d):
    global dut, io, conf_chain
    dut = d

    io = setup_io(dut)
    
    yield Timer(1*_ns)

    reset_signals()

    yield Timer(5*_ns)


    cocotb.fork(Clock(dut.clock,10,'ns').start())

    yield Timer(10*_ns)
    yield ClockCycles(dut.clock, 10)

    dut.reset = 1


    write_to_i(5, 13, dut, io, 8)

    yield setup_fpga()

    yield ClockCycles(dut.clock, 5)

    dut.reset = 0

    yield ClockCycles(dut.clock, 5)

    val = read_from_o(dut, io, 8)

    assert val == (5+13)%255

    yield ClockCycles(dut.clock, 5)

    write_to_i(0, 255, dut, io, 8)

    yield ClockCycles(dut.clock, 5)

    val = read_from_o(dut, io, 8)

    assert val == (0+255)%255
    

    yield Timer(5000*_ns)

def write_to_i(a, b, dut, io, width):
    x = BinaryValue(a, width, False).binstr
    y = BinaryValue(b, width, False).binstr

    [io['io_IO_i'][i] <= int(bit,2) for i, bit in enumerate(reversed(x))]
    [io['io_IO_i'][i+width] <= int(bit,2) for i, bit in enumerate(reversed(y))]

def read_from_o(dut, io, width):
    x = ""

    for i in range(16):
        x = str(io['io_IO_o'][i+32].value) + x

    return(int(x, 2))


@cocotb.coroutine
def setup_fpga():
    
    # Read & force FPGA config
    with open(os.path.join(cur_dir, "bitstream/bitstream_force"), "r") as f:
        lines = f.readlines()

        for line in lines:
            confbus = line.split(' ')[0]
            bitstream = line.split(' ')[1].strip()
            #print(f" BUS: {confbus} force BinaryValue(bitstream)")
            getattr(dut, confbus).value = BinaryValue(bitstream)

    # Setup control signals
    dut.io_ctrlSignals_gndBlkOuts = 0
    dut.io_ctrlSignals_pathBreak = 0
    yield ClockCycles(dut.clock, 2)
    dut.reset.value = 0
    yield ClockCycles(dut.clock, 2)


def setup_io(dut):
    io = {}
    for i in range(128):
        io[f'io_IO_i[{i}]'] = dut.io_IO_i[i]

    for i in range(128):
        io[f'io_IO_o[{i}]'] = dut.io_IO_o[i]

    io['io_IO_i'] = [io[f'io_IO_i[{i}]'] for i in range(128)]
    io['io_IO_o'] = [io[f'io_IO_o[{i}]'] for i in range(128)]

    io = {name: getattr(dut, name) for name, sig in io.items()}

    io['a'] = [dut.io_IO_i[i] for i in range(7, 0)]
    io['b'] = [dut.io_IO_i[i] for i in range(15, 8)]
    
    io['c'] = [io[f'io_IO_o[{i}]'] for i in range(39, 32)]
    print (io['a'])


    return io

def reset_signals():
    dut.clock = 0
    dut.reset = 1
    dut.io_IO_i.value = 0
    dut.io_ctrlSignals_gndBlkOuts = 0
    dut.io_ctrlSignals_pathBreak = 0
    dut.io_ctrlSignals_confClock = 0
    dut.io_confPorts_0_scanIn.value = 0
    dut.io_confPorts_0_tileSelect.value = 0
    dut.io_confPorts_0_scanEn = 0
    dut.io_confPorts_1_scanIn.value = 0
    dut.io_confPorts_1_tileSelect.value = 0
    dut.io_confPorts_1_scanEn = 0
    dut.io_confPorts_2_scanIn.value = 0
    dut.io_confPorts_2_tileSelect.value = 0
    dut.io_confPorts_2_scanEn = 0
    dut.io_confPorts_3_scanIn.value = 0
    dut.io_confPorts_3_tileSelect.value = 0
    dut.io_confPorts_3_scanEn = 0
    dut.io_confPorts_4_scanIn.value = 0
    dut.io_confPorts_4_tileSelect.value = 0
    dut.io_confPorts_4_scanEn = 0


