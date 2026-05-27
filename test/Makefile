# Makefile
# Firmware Signature Verification Accelerator
# Tiny Tapeout / Cocotb Simulation Setup

# Default simulator
SIM ?= icarus

# Enable FST waveform dump
FST ?= -fst

# HDL language
TOPLEVEL_LANG ?= verilog

# Source directory
SRC_DIR = $(PWD)/../src

# Project source file
PROJECT_SOURCES = tt_um_fw_signature_verify.v

ifneq ($(GATES),yes)

# -----------------------------
# RTL Simulation
# -----------------------------
SIM_BUILD = sim_build/rtl

VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))

else

# -----------------------------
# Gate-Level Simulation
# -----------------------------
SIM_BUILD = sim_build/gl

COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1

# GF180 standard cell libraries
VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/primitives.v

VERILOG_SOURCES += $(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog/gf180mcu_fd_sc_mcu7t5v0.v

# Gate-level netlist
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# -----------------------------
# Include project headers
# -----------------------------
COMPILE_ARGS += -I$(SRC_DIR)

# -----------------------------
# Testbench Sources
# -----------------------------
VERILOG_SOURCES += $(PWD)/tb.v

# Top-level module
TOPLEVEL = tb

# Cocotb Python test file
COCOTB_TEST_MODULES = test

# -----------------------------
# Include Cocotb Makefiles
# -----------------------------
include $(shell cocotb-config --makefiles)/Makefile.sim
