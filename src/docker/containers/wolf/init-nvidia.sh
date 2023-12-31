#!/bin/bash
## Script to initialize nvidia device nodes.
## https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile-verifications

/sbin/modprobe nvidia
if [ "$?" -eq 0 ]; then
  # Count the number of NVIDIA controllers found.
  NVDEVS=$(lspci | grep -i NVIDIA)
  N3D=$(echo "$NVDEVS" | grep -c "3D controller")
  NVGA=$(echo "$NVDEVS" | grep -c "VGA compatible controller")
  N="$(expr "$N3D" + "$NVGA" - 1)"
  for i in $(seq 0 "$N"); do
    mknod -m 666 /dev/nvidia"$i" c 195 "$i"
  done
  mknod -m 666 /dev/nvidiactl c 195 255
else
  exit 1
fi

/sbin/modprobe nvidia-uvm
if [ "$?" -eq 0 ]; then
  # Find out the major device number used by the nvidia-uvm driver
  D=$(grep nvidia-uvm /proc/devices | awk '{print $1}')
  mknod -m 666 /dev/nvidia-uvm c "$D" 0
  mknod -m 666 /dev/nvidia-uvm-tools c "$D" 0
else
  exit 1
fi