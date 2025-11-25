sudo apt update
sudo apt install libxml2-dev libzmq3-dev libjsoncpp-dev xvfb -y

#Install AVED software stack
sudo apt install /share/tools/v80/vitis-flow/ami/ami_2.3.0-0.0bab29e5.20251021_amd64_22.04.deb
#Install V80 runtime
sudo apt install /share/tools/v80/vitis-flow/vrt/amd-vrt_1.0.0_2025-11-24-15-50-46_amd64.deb
#Install the QDMA driver
sudo apt-get install libaio-dev
scp -r /share/tools/v80/vitis-flow/qdma_drv /tmp/ && cd /tmp/qdma_drv/linux-kernel/ && make && sudo make install

#Card preparation
sudo ami_tool cfgmem_program -d 0d:00.0 -i /opt/amd/vrt/design.pdi -t primary -p 1 -y
