# # FPGA-Based Traffic Light Controller with Emergency Vehicle Priority

## Features

- Verilog HDL Design
- Finite State Machine (FSM)
- Highway and Side Road Control
- Emergency Vehicle Priority Override
- Compatible with Xilinx Spartan FPGA Boards
- Simulated using Vivado/ModelSim

## States

1. Highway Green
2. Highway Yellow
3. Side Road Green
4. Side Road Yellow

## Emergency Mode

When emergency input becomes HIGH:
- Highway immediately turns GREEN
- Side Road turns RED
- Normal sequence resumes after emergency signal clears

## Simulation

Run:

```bash
vsim traffic_light_tb
run -all
```

or in Vivado:

```bash
xvlog traffic_light_controller.v
xvlog traffic_light_tb.v
xelab traffic_light_tb
xsim traffic_light_tb -runall
```
