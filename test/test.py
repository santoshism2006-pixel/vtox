import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import Timer


@cocotb.test()
async def test_ecdsa_verify(dut):

    # Start clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Initial values
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Reset delay
    await Timer(20, units="ns")

    # Release reset
    dut.rst_n.value = 1

    # Wait one clock
    await RisingEdge(dut.clk)

    # -------------------------------------------------
    # Test Case 1 : Correct Signature
    # -------------------------------------------------

    dut.ui_in.value = 0xA5

    await RisingEdge(dut.clk)

    assert dut.uo_out.value == 0x01, \
        f"Expected output 0x01 but got {dut.uo_out.value}"

    # -------------------------------------------------
    # Test Case 2 : Wrong Signature
    # -------------------------------------------------

    dut.ui_in.value = 0x55

    await RisingEdge(dut.clk)

    assert dut.uo_out.value == 0x00, \
        f"Expected output 0x00 but got {dut.uo_out.value}"

    # -------------------------------------------------
    # End Test
    # -------------------------------------------------

    await Timer(20, units="ns")
