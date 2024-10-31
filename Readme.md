# UART Bluetooth Serial PC Project

## 📖 Project Overview

This project implements a UART-based communication system that interfaces with a Bluetooth module and connects to a PC. Designed for the BASYS3 FPGA board, it demonstrates real-time serial communication between the FPGA and an external device via Bluetooth.

## ✨ Features

- **UART Communication**: Provides a UART interface for serial communication.
- **Bluetooth Integration**: Interfaces with a Bluetooth module (e.g., HC-05) for wireless communication.
- **Configurable Parameters**: Baud rate and other parameters can be adjusted as needed.

## 📁 Directory Structure

- **`src/`**: Contains source files, including `.sv` and `.v` files for the UART and traffic light modules.
- **`constraints/`**: Contains the XDC constraint files for setting up pin assignments and clock configurations.
- **`README.md`**: Project documentation (this file).

## 🚀 Getting Started

### Prerequisites

- **BASYS3 FPGA Board**: Required for hardware deployment.
- **Vivado**: Xilinx Vivado Design Suite to synthesize, implement, and program the FPGA.
- **Bluetooth Module**: HC-05 or compatible module for Bluetooth communication.

### Setup and Compilation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/gambablue/UART_Bluetooth_SerialPC.git
   cd UART_Bluetooth_SerialPC
2. **Open the Project in Vivado:**
   - Open Vivado and create a new project.
   - Add the .v, .sv, and .xdc files from this repository to the project.
   - Assign the appropriate pins according to the BASYS3 board.

3. **Synthesize and Implement:**
   - Run synthesis and implementation in Vivado.
   - Generate the bitstream file to program the FPGA.

4. **Load the Program on the FPGA:**
   - Connect your BASYS3 board to the PC.
   - Load the generated bitstream onto the FPGA.

### Usage

1. Connect Bluetooth Module:
   - Connect the HC-05 or compatible Bluetooth module to the FPGA.
   - Pair the Bluetooth module with your PC.

2. Establish Serial Communication:
   - Open a serial terminal on your PC (e.g., PuTTY, Tera Term).
   - Set the correct baud rate and other UART settings to match the configuration in your code.
   - You should now be able to send and receive data between the PC and FPGA over Bluetooth.

## File Descriptions

- `UART.sv`: UART communication module.
- `baudrate generator.sv`: To generate the required baud rate.
- `constraints.xdc`: Xilinx Design Constraints for pin assignments and clock settings.

## Troubleshooting

1. No Connection to Bluetooth: Verify the baud rate and make sure the Bluetooth module is paired correctly.
2. No Response on Serial Terminal: Check the UART settings and ensure that the clk and reset signals are functioning properly.

## License

This project is open-source and available under the MIT License.

## Acknowledgments

This project was inspired by embedded systems communication needs and prototyping with FPGAs for the course work.

Good luck!
- Ali Ziya Alkar
