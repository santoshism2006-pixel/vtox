import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory


@cocotb.test()
async def test_ecdsa_verify(dut):

    dut.ui_in.value = 0b10101010

    await Timer(10, units="ns")

    result = dut.uo_out.value.integer

    assert result == 1, "ECDSA verification failed"
