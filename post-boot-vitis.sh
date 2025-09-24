sudo apt update
sudo apt install libxml2-dev libzmq3-dev libjsoncpp-dev xvfb -y

#Install AVED software stack
sudo apt install /proj/octfpga-PG0/tools/v80/ami_2.3.0-0.0bab29e5.20250915_amd64_22.04.deb
#Install V80 runtime
sudo apt install /proj/octfpga-PG0/tools/v80/amd-vrt_1.0.0_2025-09-15-22-20-35_amd64.deb
#Install the QDMA driver
sudo apt-get install libaio-dev
scp -r /proj/octfpga-PG0/tools/v80/qdma_drv /tmp/ && cd /tmp/qdma_drv/QDMA/linux-kernel/ && make && sudo make install

#Card preparation
sudo ami_tool cfgmem_program -d 0d:00.0 -i /opt/amd/vrt/design.pdi -t primary -p 1 -y
