# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_fw_signature_verification(dut):

    dut._log.info("Starting Firmware Signature Verification Test")

    # Create clock: 100 KHz
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # -----------------------------
    # Reset DUT
    # -----------------------------
    dut._log.info("Applying Reset")

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 10)

    dut.rst_n.value = 1

    dut._log.info("Reset Complete")

    # ------------------------------------------------
    # Test Case 1 : Valid Firmware Signature
    # ------------------------------------------------
    dut._log.info("Test Case 1 : Valid Signature")

    dut.ui_in.value = 0xAA
    dut.uio_in.value = 0xAA

    await ClockCycles(dut.clk, 1)

    # uo_out[0] = verify_valid
    assert dut.uo_out.value & 0x01 == 1, \
        "ERROR: Valid firmware signature test failed"

    # ------------------------------------------------
    # Test Case 2 : Invalid Firmware Signature
    # ------------------------------------------------
    dut._log.info("Test Case 2 : Invalid Signature")

    dut.ui_in.value = 0x55
    dut.uio_in.value = 0x0F

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value & 0x01 == 0, \
        "ERROR: Invalid firmware signature test failed"

    # ------------------------------------------------
    # Test Case 3 : Another Valid Signature
    # ------------------------------------------------
    dut._log.info("Test Case 3 : Another Valid Signature")

    dut.ui_in.value = 0xF0
    dut.uio_in.value = 0xF0

    await ClockCycles(dut.clk, 1)

    assert dut.uo_out.value & 0x01 == 1, \
        "ERROR: Second valid signature test failed"

    # ------------------------------------------------
    # Test Completed
    # ------------------------------------------------
    dut._log.info("All Firmware Signature Verification Tests Passed")
