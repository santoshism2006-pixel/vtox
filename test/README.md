# Tiny Tapeout - ECDSA Verification

## Project Description

This project implements a simplified ECDSA-inspired digital signature verification module using Verilog HDL.

The design checks input data and validates a digital signature condition.

## Features

- Verilog RTL design
- Modular architecture
- Tiny Tapeout compatible
- OpenLane compatible
- ASIC implementation ready

## Inputs

| Signal | Description |
|--------|-------------|
| ui_in[7:0] | Input data |

## Outputs

| Signal | Description |
|--------|-------------|
| uo_out[0] | Signature valid output |

## Working

If input data equals `8'hA5`, the signature is considered valid.

## Tools Used

- Verilog HDL
- Icarus Verilog
- OpenLane
- Magic
- Tiny Tapeout

## Author

Lyra
