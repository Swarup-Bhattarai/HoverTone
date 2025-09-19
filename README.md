# HoverTone 

**HoverTone** demonstrates **contactless levitation** using **40 kHz ultrasonic transducers** driven by an **FPGA (Terasic DE10-Lite)**.  
By generating precise 40 kHz signals with controllable phase shifts, the system creates **standing acoustic waves** that trap and suspend lightweight objects (e.g., small beads, styrofoam) in mid-air.

---

## Features
- **FPGA-controlled signal generation** – stable 40 kHz outputs derived from a 50 MHz clock.  
- **Multi-channel phase control** – steer or shape acoustic fields with ease.  
- **MOSFET driver stage** – boosts FPGA signals to ~12–24 Vpp for powering ultrasonic transducers.  
- **Modular design** – scale from a single pair of transducers to full arrays.  
- **Real-time levitation demo** – levitate particles at pressure nodes of standing waves.  

---

## Hardware
- Terasic DE10-Lite (Intel MAX 10 FPGA)  
- 40 kHz ultrasonic transducers (16 mm, matched pairs/arrays)  
- MOSFET half-bridge / full-bridge drivers  
- 12–24 V DC power supply  
- Mechanical frame with ~8.5 mm spacing between opposing transducers (half-wavelength in air at 40 kHz)  
