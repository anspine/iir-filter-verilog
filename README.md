## 1. iir-filter-verilog
A first-order IIR low-pass filter implemented in Verilog on the Arty A7-100T FPGA, using a custom 4 bit Baugh–Wooley signed multiplier and verified through simulation and hardware testing.

## 2. what is an iir filter
An Infinite Impulse Response (IIR) filter is a digital filter that calculates its current output using both the current input sample and one or more previous output samples.

Unlike a Finite Impulse Response (FIR) filter, which does not require feedback from its previous outputs, an IIR filter uses feedback. This allows it to produce a smoothing effect with relatively few calculations.

IIR filters are commonly used in digital signal processing applications such as noise reduction, sensor signal conditioning, and audio processing.

### filter equation:
This project implements a first-order IIR low-pass filter using the following recurrence equation:

y[n] = {6x[n] + 2y[n-1]}/{8}

where:
(x[n]) is the current input sample.
(y[n-1]) is the previous output sample.
(y[n]) is the newly calculated output sample.
(6/8) is the coefficient applied to the current input - (a)
  (2/8) is the coefficient applied to the previous output - (b)

The coefficients determine how much influence the current input and previous output have on the next output. The previous output introduces feedback into the system.


### Selection and Quantization of Filter Coefficients:

The filter coefficients determine the relative contributions of the current input and the previous output. They are important because they control the filter's response to changes in the input signal.
w_c = {2pi(f_c)}/{f_s}; where w_c is the cutoff frequency

Substituting the selected values,
w_c = {2pi(10)}/{40} = pi/2
then using the coefficient formula, the coefficient values were calculated as:
b = 2-sqrt{3} = 0.268
a = 1-b = 0.732


#### Choosing the sampling and cutoff frequencies-

The initial design exploration used a sampling frequency of
f_s = 40Hz
and a cutoff frequency of
f_c = 10Hz


The sampling frequency determines how often the input signal is sampled, while the cutoff frequency describes the desired frequency response of the low-pass filter.

#### Calculating the coefficients
The coefficients must be chosen together so that the filter has the intended response and remains stable.

#### Representing the coefficients in hardware

The final Verilog implementation uses integer arithmetic rather than floating-point coefficients. The implemented recurrence is
y[n] = {6x[n] + 2y[n-1]}/{8}
Equivalently,
y[n] = 0.75x[n] + 0.25y[n-1]

This representation uses integer multiplications followed by scaling through division by 8. It is convenient for a hardware implementation using fixed-width signed arithmetic.

The integer coefficients are an implementation choice and should be distinguished from the coefficients calculated during the initial filter-design stage. Quantization can change the filter's frequency response, so the implemented coefficients should be evaluated against the original design goals.

## 3. RTL Architecture

The design is divided into two main modules: a Baugh–Wooley multiplier and an IIR filter module.

### Baugh–Wooley Multiplier

The Baugh–Wooley multiplier performs signed binary multiplication using partial products and addition logic. It is implemented as a separate module so that it can be reused in the filter.

### IIR Filter Module

The IIR filter module calculates the next output by multiplying the current input and previous output by their respective integer coefficients, adding the products, and scaling the result by dividing by 8.
The previous output is stored in a register and updated on the rising edge of the clock. A reset signal initializes the stored output to zero.

### Simulation Testbench

The testbench applies input values and reset signals to the filter and checks its sequential behavior. This allows the design to be evaluated in simulation before testing it on the FPGA.

### Testbench Verification

#### Simulation Results

A Verilog testbench was used to simulate the IIR filter and the Baugh wooley multiplier by applying input samples and observing the corresponding output values. The simulation verifies that the filter correctly performs the required calculations using the chosen coefficients and previous output values. The resulting waveforms were examined to confirm the expected filter response.

![iir filter simulation]
<img width="1920" height="1080" alt="iir filter simulation" src="https://github.com/user-attachments/assets/63a5d603-4ee8-439e-ada1-1227c7554e1f" />

![baugh wooley simulation]
<img width="1920" height="1080" alt="baugh wooley simulation" src="https://github.com/user-attachments/assets/ea19b70d-72f1-4b3b-b3ac-ec5f479dc616" />

#### Hardware Verification

The Logic 8 analyzer was used to capture and verify
the hardware output.
![logic8_iir]
<img width="1512" height="982" alt="logic8_iir" src="https://github.com/user-attachments/assets/5316bb60-66cd-4169-b7bb-ba568af34139" />




