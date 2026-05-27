# Firmware Signature Verification Accelerator Testbench

This is the verification environment for the **Firmware Signature Verification Accelerator** Tiny Tapeout project.

The testbench uses [cocotb](https://docs.cocotb.org/en/stable/) to verify the functionality of the hardware security accelerator used for firmware authentication in V2X communication systems.

The project validates firmware integrity and authenticity using signature verification logic.

For more information about Tiny Tapeout testing flow, visit the Tiny Tapeout documentation website.

---

# Project Overview

The Firmware Signature Verification Accelerator performs:

- Firmware hash verification
- Signature authentication
- Secure firmware validation
- Detection of tampered firmware
- Hardware-based security processing

The design is implemented in Verilog HDL and verified using Cocotb simulation.

---

# Setting up

## 1. Update the Makefile

Edit the `Makefile` and modify:

```makefile
PROJECT_SOURCES = tt_um_fw_signature_verify.v
