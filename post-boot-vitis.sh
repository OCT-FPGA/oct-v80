mount_filesystems() {
    sudo mkdir -p /fpga/tools   
    sudo mount -t nfs -o nolock ops.cloudlab.umass.edu:/fpga/tools /fpga/tools
}    

install_headers(){
    sudo apt update
    sudo apt install linux-headers-$(uname -r)
}

install_ami_driver(){
    sudo apt install $SLASH_BASE_PATH/deb/slashkit_1.0.0_amd64_*.deb
}

TOOLVERSION=$1
BASE_DIR="/fpga"
SLASH_BASE_PATH="$BASE_DIR/tools/v80/$TOOLVERSION"
mount_filesystems
install_headers
install_ami_driver
