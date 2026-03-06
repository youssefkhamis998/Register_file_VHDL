Register File Architecture
A detailed study and implementation reference for Register File design in digital computer architecture — covering high-level block diagrams, internal read path (multiplexer-based), and write path (decoder)

Overview
A Register File is a small, fast memory component used in CPUs to store temporary values during instruction execution. This repository documents the architecture of a register file at three levels of abstraction:

Block-Level Interface — Inputs/outputs: read register numbers, write register, write data, and the RegWrite control signal.
Read Path — Two independent read ports implemented via multiplexers selecting from n registers.
Write Path — Decoder-driven write enable logic controlling D flip-flops for each register.

1. Top-Level Interface
  <img width="315" height="169" alt="Screenshot from 2026-03-06 05-11-14" src="https://github.com/user-attachments/assets/ce60edfa-8580-4844-b7c1-9074b3a0e79b" />

    The register file exposes:
    2 read ports (combinational)
    1 write port (clocked, gated by RegWrite)
2. Read Path — Dual Multiplexer Design
   <img width="472" height="390" alt="Screenshot from 2026-03-06 05-09-27" src="https://github.com/user-attachments/assets/fa071069-6d0e-4a14-8b6e-af247f71ade9" />
   Both read ports are asynchronous: the register number directly selects one of n register outputs via a multiplexer.
3. Write Path — Decoder
    <img width="389" height="344" alt="Screenshot from 2026-03-06 05-10-30" src="https://github.com/user-attachments/assets/959c4951-bf8f-4175-881e-223d078ed2df" />
   A decoder to select the target register from the register number
   An AND gate combining the decoder output with the Write control signal
   A D flip-flop (with clock C and data D) per register to latch the value on the rising clock edge
