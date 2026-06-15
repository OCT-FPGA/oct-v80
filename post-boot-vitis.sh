mount_filesystems() {
    sudo mkdir -p /fpga/tools   
    sudo mount -t nfs -o nolock ops.cloudlab.umass.edu:/fpga/tools /fpga/tools
}    

install_headers(){
    sudo apt update
    sudo apt install linux-headers-$(uname -r)
}

install_ami_driver(){
    sudo apt install $SLASH_BASE_PATH/deb/ami_*.deb
}

check_slash() {
    echo "Attempting to load the SLASH module..."
    
    if sudo modprobe slash; then
        echo "SLASH module loaded successfully."
    else
        echo "Error: Failed to load the SLASH module."
        return 1
    fi

    if lsmod | grep -q "slash"; then
        echo "Verification successful: SLASH module is active."
        return 0
    else
        echo "Error: SLASH module not found."
        return 1
    fi
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
check_slash
