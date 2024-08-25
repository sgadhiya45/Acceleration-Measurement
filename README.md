# Acceleration-Measurement

## Overview
A project for measuring and analyzing elevator acceleration to calculate floor heights using an ATmega32 microcontroller and ADXL355 accelerometer.

## Features
- **Circuit Design and Simulation**: The circuit was designed to amplify and filter the sensor output, simulated in LTspice, and implemented on a PCB.
- **Acceleration Measurement**: Real-time acceleration data collection during elevator trips using the ADXL355 accelerometer.
- **Microcontroller Integration**: The ATmega32 microcontroller processes the analog data and stores it on an SD card for further analysis.
- **Data Analysis**: MATLAB scripts are used to process the data, correct temporal drift, and calculate velocity and displacement, allowing for accurate floor height measurements.

## Hardware Components
- **ADXL355 Accelerometer**: Measures acceleration along a single axis, used to capture the elevator's motion.
- **ATmega32 Microcontroller**: Handles data acquisition, analog-to-digital conversion, and storage.
- **Circuit Components**: Includes operational amplifiers, Zener diode, resistors, and capacitors, assembled on a PCB.

## Project Structure
- **`src/`**: Contains the C source code for the ATmega32 microcontroller, responsible for data acquisition and logging.
  - `main.c`: Main program for the microcontroller.
  - `sensor_config.c`: Configuration and initialization of the ADXL355 sensor.
- **`hardware/`**: Contains circuit diagrams and PCB layouts.
  - `circuit_diagram.pdf`: Detailed circuit diagram used in the project.
  - `PCB_layout.pdf`: Layout of the printed circuit board.
- **`data/`**: Contains raw and processed data collected from the elevator.
  - `raw_data.csv`: Unprocessed data from the accelerometer.
  - `processed_data.csv`: Calibrated and corrected data used in analysis.
- **`analysis/`**: MATLAB scripts and results from data analysis.
  - `analysis.m`: MATLAB script for analyzing the acceleration data and calculating floor height.
  - `velocity_plot.png`: Plot of velocity over time.
  - `displacement_plot.png`: Plot of displacement over time, showing floor height.
- **`report/`**: Contains the final project report.
  - `Acceleration_Measurement.pdf`: Detailed project report documenting the experiment, methodology, and results.

## Getting Started
1. **Clone the Repository**:
    ```sh
    git clone https://github.com/sgadhiya45/Acceleration-Measurement
    cd Acceleration-Measurement
    ```
2. **Hardware Setup**: Assemble the circuit using the provided circuit diagram and components list in the `hardware/` folder.
3. **Microcontroller Programming**:
    - Compile and upload the C code in the `src/` directory to the ATmega32 microcontroller.
    - Ensure the microcontroller is connected to the sensor and SD card as per the circuit design.
4. **Data Collection**: Power the system and perform elevator trips to collect acceleration data. The data will be stored on the SD card.
5. **Data Analysis**:
    - Transfer the data from the SD card to the `data/` folder.
    - Run the MATLAB scripts in the `analysis/` folder to process the data and calculate floor height.

## Results
The experiment successfully measured the floor heights with a mean value of 3.178 meters and a standard deviation of 0.199 meters. The data was corrected for temporal drift, ensuring accurate velocity and displacement calculations.

## Conclusion
The project effectively demonstrates how an accelerometer, combined with microcontroller processing and MATLAB analysis, can be used to measure elevator floor heights with precision. The system was tested in real-world conditions, showing consistent results across multiple elevator trips.

## References
- [1] Small, Low Power, 3-Axis ±3 g Accelerometer ADXL335. Analog Devices.
- [2] Bochert, A., Winter Semester 2021/2022. Hochschule Bremerhaven.
- [3] Texas Instruments, Precision Dual Operational Amplifier TLC227, August 1994.
- [4] Agilent Technologies, InfiniiVision 2000 X-Series Oscilloscopes, 2011.
- [5] Atmel Corporation, Data Sheet ATmega32; 8-bit AVR Microcontroller, 2011.
