rm IupputerAVRCore-0.95.tar.gz
cd ./IupputerAVRCore-0.95/
tar -zcvf ../IupputerAVRCore-0.95.tar.gz ./
cd ..
	
rm esp8266-2.3.0.tar.gz
cd ./esp8266-2.3.0/
tar -zcvf ../esp8266-2.3.0.tar.gz ./
cd ..
shasum -a 256 esp8266-2.3.0.tar.gz
stat -F esp8266-2.3.0.tar.gz

shasum -a 256 IupputerAVRCore-0.95.tar.gz
stat -F IupputerAVRCore-0.95.tar.gz 