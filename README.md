# I/Q Phase Drift Tracking Engine

Fixed-point differential I/Q phase-rotation discriminator with first-order IIR smoothing, Verilog RTL and independent verification assets.

## Intended use

Tracks the trend and direction of carrier phase rotation; it does not estimate calibrated Doppler frequency in hertz or compensate frequency offset.

## Repository structure

- `rtl/doppler_tracker.v`: synthesizable Verilog module
- `tb/tb_doppler_tracker.v`: self-checking RTL testbench
- `reference/test_model.py`: independent Python algorithm/arithmetic sanity checks
- `run_tests.sh`: Python check and optional Icarus Verilog simulation

## Run

Requirements: Python 3; optional Icarus Verilog (`iverilog`, `vvp`) for RTL simulation.

```bash
bash run_tests.sh
```

## Verification status

- Python reference sanity checks: passed in original authoring environment.
- RTL self-checking testbench: written, not yet executed in original authoring environment.
- RTL vs Python sample-by-sample comparison: not yet established.
- ASIC synthesis / timing / silicon: not completed.

## Scope

A standalone educational/portfolio prototype using only original generic signal-processing techniques. It does not reproduce proprietary RPMA or satellite SoC design, and makes no claims of production readiness.
