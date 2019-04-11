#!/bin/bash

function launch_linux_uos()
{
vm_name=$1

# create a unique tap device for each VM
tap="tap1"
tap_exist=$(ip a | grep acrn_"$tap" | awk '{print $1}')
if [ "$tap_exist"x != "x" ]; then
  echo "tap device existed, reuse acrn_$tap"
else
  ip tuntap add dev acrn_$tap mode tap
fi

# if acrn-br0 exists, add VM's unique tap device under it
br_exist=$(ip a | grep acrn-br0 | awk '{print $1}')
if [ "$br_exist"x != "x" -a "$tap_exist"x = "x" ]; then
  echo "acrn-br0 bridge aleady exists, adding new tap device to it..."
  ip link set acrn_"$tap" master acrn-br0
  ip link set dev acrn_"$tap" down
  ip link set dev acrn_"$tap" up
fi

#check if the vm is running or not
vm_ps=$(pgrep -a -f acrn-dm)
result=$(echo $vm_ps | grep "${vm_name}")
if [[ "$result" != "" ]]; then
  echo "$vm_name is running, can't create twice!"
  exit 1
fi

#for memsize setting
mem_size=3072M

acrn-dm -A -m $mem_size -c $2 -s 0:0,hostbridge -s 1:0,lpc -l com1,stdio \
  -s 2,pci-gvt -G "$3" \
  -s 5,virtio-console,@pty:pty_port \
  -s 6,virtio-hyper_dmabuf \
  -r /usr/share/acrn/images/android-x86/initrd.img \
  -s 8,virtio-blk,/usr/share/acrn/images/android-x86/android.img \
  -s 4,virtio-net,$tap \
  -s 7,xhci,1-7 \
  -k /usr/share/acrn/images/android-x86/kernel \
  -B "console=tty0 console=hvc0 \
  console=ttyS0 root=/dev/ram0 no_timer_check log_buf_len=16M loglevel=6 \
  consoleblank=0 tsc=reliable i915.avail_planes_per_pipe=$4 vga=current modeset=1 \
  i915.enable_hangcheck=0 i915.nuclear_pageflip=1 i915.enable_guc_loading=0 \
  i915.enable_guc_submission=0 i915.enable_guc=0 security=selinux androidboot.selinux=permissive androidboot.hardware=acrn_android_x86_64 \
  SRC=android-8.1-r1 DATA= " $vm_name
}

ipu_passthrough=0
# Check the device file of /dev/vbs_ipu to determine the IPU mode
if [ ! -e "/dev/vbs_ipu" ]; then
ipu_passthrough=1
fi

cse_passthrough=0
hbm_ver=`cat /sys/class/mei/mei0/hbm_ver`
major_ver=`echo $hbm_ver | cut -d '.' -f1`
minor_ver=`echo $hbm_ver | cut -d '.' -f2`
if [[ "$major_ver" -lt "2" ]] || \
   [[ "$major_ver" == "2" && "$minor_ver" -lt "2" ]]; then
    cse_passthrough=1
fi

# offline SOS CPUs except BSP before launch UOS
for i in `ls -d /sys/devices/system/cpu/cpu[1-99]`; do
        online=`cat $i/online`
        idx=`echo $i | tr -cd "[1-99]"`
        echo cpu$idx online=$online
        if [ "$online" = "1" ]; then
                echo 0 > $i/online
		# during boot time, cpu hotplug may be disabled by pci_device_probe during a pci module insmod
		while [ "$online" = "1" ]; do
			sleep 1
			echo 0 > $i/online
			online=`cat $i/online`
		done
                echo $idx > /sys/class/vhm/acrn_vhm/offline_cpu
        fi
done

launch_linux_uos "android-x86" 2 "64 448 4" 0x090000
