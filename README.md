# UART
📌 # Overview

This repository contains the Register Transfer Level (RTL) design of a digital hardware project implemented in Verilog HDL. The design follows a structured approach with datapath and controller separation, ensuring modularity, scalability, and ease of testing.

⚡ Features

✅ Synthesizable Verilog code

✅ Modular design (Datapath + Control)

✅ Finite State Machine (FSM) based control logic

✅ Testbench with simulation waveforms

✅ Targeted for FPGA (e.g., Xilinx Basys3, Altera, etc.)

✅ Well-commented and clean RTL code

📂 src/        -> RTL source files (Verilog)
📂 tb/         -> Testbench files
📂 sim/        -> Simulation outputs (waveforms, logs)
📂 docs/       -> Documentation (block diagrams, notes)

🧪 # Simulation & Verification

Testbenches provided for functional verification.

Can be simulated using ModelSim / Vivado / Icarus Verilog + GTKWave.

Covers normal, boundary, and edge cases to ensure correctness.

🚀 # Future Scope

FPGA implementation for real-time testing

Performance optimization and pipelining

Adding more configurable features
