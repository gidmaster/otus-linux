# HW01

## Get Started.
1. Get `vagrant`.
2. Get `git`.
3. Get `otuslinux`.
    ```bash
    git clone git@github.com:erlong15/otus-linux.git  
    cd otuslinux  
    vagrant up  
    vagrant ssh otuslinux  
    ```
4. Set default kernel version in GRUB:

    * Open and edit the file /etc/default/grub. Set:
        ```bash
        GRUB_DEFAULT=0
        ```

    * Recreate the kernel configuration
        ```bash
        grub2-mkconfig -o /boot/grub2/grub.cfg
        ```

5. Reboot your system:
6. Put `update-kernel.sh` to `VM`
    
    * Get vagrant open port:
    ```bash
    vagrant port
    The forwarded ports for the machine are listed below. Please note that
    these values may differ from values configured in the Vagrantfile if the
    provider supports automatic port collision detection and resolution.

    22 (guest) => 2222 (host)
    ```
    * Use SCP to send `update-kernel.sh` to `VM`
    ```bash
    scp -P 2222 ./update-kernel.sh vagrant@127.0.0.1:/home/vagrant
    ```
    * Connect to `VM`:
    ```bash
    vagrant ssh otuslinux
    ```
    * Make `update-kernel.sh` executable and run it:
    ```bash
    chmod +x update-kernel.sh
    ./update-kernel.sh
    ```

7. Reboot system.

