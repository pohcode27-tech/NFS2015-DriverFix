# NFS 2015 Driver Check Bypass

Fixes the "Detected AMD Radeon driver version 0.0" error in Need for Speed (2015) on modern AMD GPUs.

![Error Message](https://raw.githubusercontent.com/pohcode27-tech/NFS2015-DriverFix/refs/heads/main/NFSDriverErrorMsg.png)

## Problem

NFS 2015 uses an outdated driver version check that doesn't recognize modern AMD Adrenalin drivers (RDNA 3/4 GPUs like RX 7000/9000 series). The game reads the driver version as "0.0" and refuses to start.

## Solution

This PowerShell script patches `NFS16.exe` to bypass the driver version check by changing the minimum required version from `13.251` to `0.0.00`.

## Usage

1. Run `PatchNFS.ps1` as Administrator
2. Enter the path to your `NFS16.exe`
3. Done! The game should now start normally.

A backup (`NFS16.exe.backup`) is automatically created before patching.

## Tested On

- AMD RX 9070 XT (RDNA 4)
- AMD RX 6700 (RDNA 2)
- AMD Adrenalin 25.x drivers

## Disclaimer

Use at your own risk. This modifies game files which may trigger anti-cheat or require re-verification through EA App.
