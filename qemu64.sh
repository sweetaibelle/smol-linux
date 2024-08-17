#!/bin/bash
qemu-system-x86_64 -m 128M -cdrom smol_linux_live.iso -boot d -vga std -nographic
