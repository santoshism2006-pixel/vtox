import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_project(dut):

    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.ena.value = 1
    dut.clk.value = 0
    dut.rst_n.value = 0

    await Timer(10, units="ns")

    dut.rst_n.value = 1

    for i in range(10):

        dut.ui_in.value = i

        dut.clk.value = 0
        await Timer(5, units="ns")

        dut.clk.value = 1
        await Timer(5, units="ns")

    assert True
