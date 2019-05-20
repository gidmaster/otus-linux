# HW04

## Get Started.



1. Get `vagrant`.
2. Get `git`.
3. Get `otuslinux`.
    ```bash
    git clone git@github.com:erlong15/otus-linux.git  
    cd otuslinux 
    vagrant up
    ```
4. Go to `GUI VirtualBox` and run VM:
5. Reset `root` password:

    _NOTE BENE:_  **Described methods didn't work on Windows 10 host VM with VirtualBox.**
    1. Stop system boot be pressing `e` on keyboard while grup menu appering:
    2. Go to line started from `linux16`
    3. Delete `rhgb` and `quite` from the and
    4. Method `init=/bin/sh`
        * Change `ro` to `rw init=\bin\sh`
        * Press `Ctrl-X`
        * Reset `root password`:
        ```
        passwd root
        ```
        * Create `.autorelabel` file:
        ```
        touch /.autorelabel
        ```
    6. Method `rd.break`. The same idea. But just add to the end of the line `rd.break enforcing=0` and change `ro` to `rw`.
    7. Method  rw init=/sysroot/bin/sh. The same idea.
    5. Reboot.
6. Install system with LVM, and rename VG.
    1. Run `volume-group.sh`
    2. Reboot.
7. Add module into `initrd`.
    1. Run `vagrant up`. Script alredy add into provision section.
    2. Check it during system boot.