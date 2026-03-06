PixelOS
Build Date: 16/04/2026
Device Tree:
- peridot: init: Increase zram to 8gb
- peridot: Pin Adreno blobs to WW-36.0210.1420.39
- peridot: Disable android rescue party
- peridot: Update from OS3.0.5.0.WNPMIXM
- peridot: init: Add option to use fscompress for F2FS
- peridot: Include app debloater
- peridot: overlay: Add new adaptive Leica camera icon
- peridot: init: Import cgroup tuning from gs101
- peridot: init: Manually place msm_drm and msm_kgsl_3d0 IRQs
- peridot: init: Chown the cgroup.procs nodes

PixelOS
Build Date: 12/03/2026
Device Tree:
- peridot: sepolicy: Fix property access denials for MiuiCamera
- peridot: sepolicy: Fix audio zoom property denial for MiuiCamera
- peridot: sepolicy: Fix SELinux denial for P3 color mode property
- peridot: Use vulkan renderer
- peridot: Disable verbose camera logs

Kernel:
- Merge to latest lineage kernel

PixelOS
Build Date: 07/03/2026
Device Tree:
- peridot: Add initial unofficial OTA
- peridot: Use AOSP default renderer
- peridot: wlan: Enable Optimized Power Management
- peridot: Disable kpti
- peridot: Use FBE v2

Kernel:
- cgroup: Increase kp 3 boost duration
- UPSTREAM: kbuild: Add AutoFDO support for Clang build
- ANDROID: Fix adding cflags for CONFIG_AUTOFDO_CLANG
- FROMLIST: AutoFDO: Remove the architecture specific config
- scripts/Makefile.afdo: Enable fuzzy profile matching
- treewide: Import and hardcode afdo profile
- Makefile: set instr limit to 40 with AutoFDO
- ANDROID: Update AutoFDO profile for 6.6.92
- ANDROID: Update AutoFDO profile for 6.6.100
- ANDROID: Update AutoFDO profile for 6.6.111

PixelOS
Build Date: 06/03/2026
Device Tree:
- peridot: Initial QPR2 unofficial
- peridot: Introduce Dolby Atmos
- peridot: Kang c2 service from sony pdx237
- peridot: Set ART debug to release mode
- peridot: wifi: Disable RX wakelock feature
- peridot: wifi: Disable WLAN Firmware loggings
- peridot: Switch to libperfmgr from hardware/google
- peridot: overlay: Drop config power decouple mode
- peridot: Introduce displayfeature color service and use MIUI color modes
- peridot: Import Miui Camera
- peridot: Fix Miui Camera elf checks properly
- peridot: Silence ColorManager logspam
- peridot: Enable CameraX extensions support
- peridot: sepolicy: Dontaudit camera hal default_prop
- peridot: Set SurfaceFlinger min uclamp to 30%
- peridot: Build ANGLE app
- peridot: Initial variant handler libinit
- peridot: Drop sku props
