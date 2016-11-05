#!/bin/sh
esptool.py -p /dev/cu.SLAB_USBtoUART -b 921600 erase_flash &&
echo "Please switch to flash mode" &&
sleep 5 
esptool.py -p /dev/cu.SLAB_USBtoUART -b 921600 write_flash -fm dio -fs 32m 0x00000 nodemcu-integer.bin 0x3fc000 esp_init_data_default.bin 
# bit,enduser_setup,i2c,mdns,mqtt,rtcfifo,rtcmem,rtctime,sntp