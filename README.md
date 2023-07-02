# ICS Security Projects

This repository contains a collection of projects focusing on learning about Industrial Control System (ICS) security. The projects demonstrate the modelling and simulation of ICS with control logic, PLC programming, and network traffic analysis for reconnaissance.

## Project Overview

### 1. ICS Modelling and Logic Bombs (see `ics_logic_bombs/`)
- **Description**: This project involves the modelling of an Industrial Control System (ICS) using Factory I/O and Control I/O software. It aims to simulate the process and design the underlying controller. The project also introduces "logic bombs" which are sets of instructions embedded in the program that can cause changes to normal operating conditions.
- **Tools**: Factory I/O, Control I/O
- **Key Concepts**: ICS modelling, control logic, logic bombs

### 2. PLC Programming and Ladder Logic Bombs (see `plc_ladder_logic/`)
- **Description**: This project involves creating PLC programs for controlling different real-world systems and includes introducing ladder logic bombs. The programming is done using the Ladder Diagram (LD) format, a popular language for writing PLC programs. For simulation purposes, OpenPLC, an open-source PLC emulator, is used.
- **Tools**: OpenPLC
- **Key Concepts**: PLC programming, ladder logic, emulation, real-world process simulation

### 3. Network Traffic Analysis for ICS Reconnaissance (see `traffic_analysis/`)
- **Description**: This project teaches how to conduct reconnaissance on an ICS network by collecting and analyzing network traffic, a critical skill for an attacker trying to compromise an ICS network through PLCs. The project involves examining data from a pcap file containing network traffic of an ICS network using the Modbus protocol.
- **Tools**: Mininet
- **Key Concepts**: Network traffic analysis, ICS network reconnaissance, Modbus protocol
