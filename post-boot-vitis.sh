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

install_slash_packages(){
    sudo apt install -y \
    $SLASH_BASE_PATH/deb/slash-dkms_*_all.deb \
    $SLASH_BASE_PATH/deb/libslash_*_amd64.deb \
    $SLASH_BASE_PATH/deb/vrtd_*_amd64.deb \
    $SLASH_BASE_PATH/deb/libvrtd_*_amd64.deb \
    $SLASH_BASE_PATH/deb/libvrt_*_amd64.deb \
    $SLASH_BASE_PATH/deb/v80-smi_*_amd64.deb \
    $SLASH_BASE_PATH/deb/slashkit_*_amd64.deb
}

TOOLVERSION=$1
BASE_DIR="/fpga"
SLASH_BASE_PATH="$BASE_DIR/tools/v80/$TOOLVERSION/SLASH"
mount_filesystems
install_headers
install_ami_driver
install_slash_packages
#program_board
