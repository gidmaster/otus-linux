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

5. Reboot your system.
