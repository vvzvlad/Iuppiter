cd ./IupputerAVRCore-0.95/
tar -zcvf IupputerAVRCore-0.95.tar.gz ./*
mv IupputerAVRCore-0.95.tar.gz ../
cd ../
shasum -a 256 IupputerAVRCore-0.95.tar.gz
stat -F IupputerAVRCore-0.95.tar.gz 