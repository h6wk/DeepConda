# Windows Subsystem for Linux

The **Windows Subsystem for Linux** (WSL) is a feature of Windows that allows you to run a Linux environment directly on your Windows machine, without the need for a separate virtual machine or dual booting. WSL uses the Linux kernel, which is translated into Windows system calls. When you run a Linux command, WSL maps it to the corresponding Windows functionality. This allows Linux binaries to execute without modification.

There are two versions of WSL.
* **WSL 2** (default): Uses virtualization technology to run a Linux kernel inside a lightweight utility virtual machine (VM). Distributions run as isolated containers within the WSL 2 VM. Provides better file system performance and full system call compatibility.
* **WSL 1**: Runs Linux distributions directly on Windows, without virtualization. Less performant but simpler architecture. 

You can choose between WSL 1 and WSL 2 for individual distributions.

# Configure WSL 2 for GPU Workflows

With the **oneAPI Toolkit** you can use your Intel GPU within the WSL 2 subsystem. Using the WSL 2 distro as a host for the docker images, the docker containers will be given access to the workstation's GPU.

Pull an Ubuntu distribution from the WSL repository and follow the instructions of [1] to configure the distro.

Example output of command ``clinfo``:
```
Number of platforms                               1
  Platform Name                                   Intel(R) OpenCL Graphics
  Platform Vendor                                 Intel(R) Corporation
  Platform Version                                OpenCL 3.0
  Platform Profile                                FULL_PROFILE
  ```

## Start a docker container accessing the WSL's GPU

Enter the Ubuntu distribution (wsl.exe if it was set as the default) and pull & start the pre-configured tensorflow image. (you can chose any other preconfigured image you like)

1. ``docker pull intel/intel-extension-for-tensorflow:gpu``
2. ``docker run -it -p 8888:8888 --device /dev/dri -v /dev/dri/by-path:/dev/dri/by-path intel/intel-extension-for-tensorflow:gpu``



# References
[1] https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2023-0/configure-wsl-2-for-gpu-workflows.html

[2] https://intel.github.io/intel-extension-for-tensorflow/latest/docs/install/install_for_gpu.html