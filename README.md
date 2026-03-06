# 🗂️ Register File Architecture

> A detailed study and implementation reference for **Register File** design in digital computer architecture — covering high-level block diagrams, internal read path (multiplexer-based), and write path (decoder-driven).

---

## 📖 Overview

A **Register File** is a small, fast memory component used in CPUs to store temporary values during instruction execution. This repository documents the architecture of a register file at **three levels of abstraction**:

| Level | Description |
|---|---|
| 🔲 **Block-Level Interface** | Inputs/outputs: read register numbers, write register, write data, and the `RegWrite` control signal |
| 📤 **Read Path** | Two independent read ports implemented via multiplexers selecting from *n* registers |
| 📥 **Write Path** | Decoder-driven write enable logic controlling D flip-flops for each register |

---

## 1. 🔲 Top-Level Interface

<img width="315" height="169" alt="Top-Level Interface Diagram" src="https://github.com/user-attachments/assets/ce60edfa-8580-4844-b7c1-9074b3a0e79b" />

The register file exposes the following ports:

- **2 read ports** — combinational (asynchronous)
- **1 write port** — clocked, gated by `RegWrite`

### Port Summary

| Port | Direction | Description |
|---|---|---|
| `Read Register 1` | Input | Address of the first register to read |
| `Read Register 2` | Input | Address of the second register to read |
| `Write Register` | Input | Address of the register to write |
| `Write Data` | Input | Data value to be written |
| `RegWrite` | Input | Control signal enabling write operation |
| `Read Data 1` | Output | Data from the first read port |
| `Read Data 2` | Output | Data from the second read port |

---

## 2. 📤 Read Path — Dual Multiplexer Design

<img width="389" height="344" alt="Write Path Decoder Diagram" src="https://github.com/user-attachments/assets/959c4951-bf8f-4175-881e-223d078ed2df" />


Both read ports are **asynchronous**: the register number directly selects one of *n* register outputs via a **multiplexer**.

### Key Characteristics

- ⚡ **Combinational logic** — no clock required for reads
- 🔀 **Dual independent ports** — two registers can be read simultaneously
- 🔁 **MUX-based selection** — the register address acts as the select line

---

## 3. 📥 Write Path — Decoder Design

<img width="472" height="390" alt="Read Path Dual Multiplexer Diagram" src="https://github.com/user-attachments/assets/fa071069-6d0e-4a14-8b6e-af247f71ade9" />

The write path consists of three stages:

1. **Decoder** — selects the target register from the write register number
2. **AND Gate** — combines the decoder output with the `RegWrite` control signal to gate the write
3. **D Flip-Flop** — one per register; latches the incoming data on the **rising clock edge**

### Write Operation Flow

```
Write Register Number
        │
        ▼
   [ Decoder ]  ←── RegWrite
        │
        ▼
   [ AND Gate ]
        │
        ▼
   [ D Flip-Flop ]  ←── Write Data, Clock
        │
        ▼
   Register Updated
```

---

## 📁 Repository Structure

```
Register_file_VHDL/
├── README.md          # Architecture documentation (this file)
└── ...                # VHDL source files
```

---

## 📚 References

- Patterson & Hennessy — *Computer Organization and Design*
- IEEE Standard VHDL Language Reference Manual
