# Digital Communication (BPSK)

A MATLAB project implementing a digital communication chain with **BPSK** modulation over **AWGN** and **audio** channels: pulse shaping, matched filtering, synchronization, and BER evaluation.

## Repository Structure
```
digital-communication-bpsk/
├─ docs/
│  ├─ Digital_Communication_bpsk_Project_Questions.pdf   # assignment
│  └─ Digital_Communication_bpsk_Project_Answers.pdf                                          # written answers
├─ src/
│  ├─ DigitalCommunicationFinal.m
│  ├─ TX.m
│  └─ RX.m
├─ helpers/
│  ├─ audioSim.m
│  ├─ ChannelTXRXAudio.m
│  ├─ text2bitstream.m
│  └─ bitstream2text.m
└─ results/
   ├─ Q2A.jpg  Q2B.jpg  Q2C.jpg  Q2D.jpg  Q2SNR40.jpg
   ├─ Q3SNR100.jpg  Q3SNR12.jpg
   ├─ Q4A.jpg  Q4C.jpg  Q4E.jpg
   ├─ Q5E.jpg
   └─ Q6C.jpg
```

## How to Run
1. Open MATLAB and set the **Current Folder** to the repository root.
2. Add source paths (once per session):
   ```matlab
addpath(genpath('src'));
addpath('helpers');
   ```
3. Open `src/DigitalCommunicationFinal.m`.
4. Run the entire script, or comment/uncomment blocks as indicated inside the file.

> Use `TX.m` and `RX.m` for transmission/reception logic. `helpers/` contains utilities for audio channel simulation and text/bitstream conversion.

## Results
All figures are located under `results/`. See also the detailed explanations in [`docs/Digital_Communication_bpsk_Project_Answers.pdf`](docs/Digital_Communication_bpsk_Project_Answers.pdf).

| Question | Figures | Notes |
|---|---|---|
| Q2 – Pulse shaping | Q2A.jpg, Q2B.jpg, Q2C.jpg, Q2D.jpg, Q2SNR40.jpg | Pulse trains (rect/sinc), filtered output |
| Q3 – Channel (AWGN) | Q3SNR100.jpg, Q3SNR12.jpg | Input/output for different SNRs |
| Q4 – Matched Filter & BER | Q4A.jpg, Q4C.jpg, Q4E.jpg | Filter response, BER vs. SNR |
| Q5 – Synchronization | Q5E.jpg | Sync symbol correlation, nopt |
| Q6 – Modulation/Downconversion | Q6C.jpg | Spectrum after carrier modulation |
