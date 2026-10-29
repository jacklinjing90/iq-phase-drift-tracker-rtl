#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 reference/test_model.py
if command -v iverilog >/dev/null && command -v vvp >/dev/null; then
  mkdir -p build
  iverilog -g2012 -s tb_doppler_tracker -o build/doppler_tracker.vvp rtl/doppler_tracker.v tb/tb_doppler_tracker.v
  vvp build/doppler_tracker.vvp
else
  echo 'RTL SIMULATION NOT RUN: install iverilog and vvp first.'
fi
